//
//  XFGalleryViewModel.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/12/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import UIKit

class XFGalleryViewModel {
    
    //PhotoModel gallery object in boxed for binding the UI for update. This supports MVVM architecture well.
    var galleryPhotos: XFBox<[PhotoModel]> = XFBox([])
    
    func setupPhotoGallery(galleryId: String) {
        
        let url = urlForPhotosfromGallery(id: galleryId)
        downloadPhotosfromGallery(url: url)
    }
    
    //Function to retrieve url for photos from flickr gallery
    func urlForPhotosfromGallery(id: String)-> URL {
        
        let url = ServiceManager.getBaseUrl(withMethod: "flickr.galleries.getPhotos") + "&gallery_id=\(id)&format=json&nojsoncallback=1"
        
        return URL(string: url)!
    }
    
    //Function to retrieve url for photo size
    func urlForPhotoSize(id: String)->URL {
        
        let url = ServiceManager.getBaseUrl(withMethod: "flickr.photos.getSizes") + "&photo_id=\(id)&format=json&nojsoncallback=1"
        
        return URL(string: url)!
    }
}

//Extension that parse and load the photos from Flickr gallery and image size from photo size. This also populates the Photo model object
extension XFGalleryViewModel {
    
    //Method to load the parsed photo objects from photo gallery object. This includes the download of thumbnail and medium photo url from photo size flikcr service
    private func loadPhotos(items: [Any]) {
        
        var values = [PhotoModel]()
        
        //Using dispatch group to notify the photo size download complete for all photos
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .background)
        
        for photoDict in items {
            
            if let photoObj = photoDict as? [String: Any] {
                
                group.enter()
                
                queue.async {
                    
                    let url = self.urlForPhotoSize(id: String(describing: photoObj["id"]!))
                    
                    self.downloadPhotoSize(url: url, completionHandler: { (data, error) in
                        
                        guard let httpData = data else { return }
                        
                        guard let sizes = self.parsePhotoSize(data: httpData) else { return }
                        
                        //Predicate used to extract the thubmnail image url from array of sizes dictionary
                        var predicate = NSPredicate(format: "label like %@", "Thumbnail")
                        let thumbnail = sizes.filter{ predicate.evaluate(with: $0)}.first as! [String : String]
                        
                        //Predicate used to extract the medium size image url from array of sizes dictionary
                        predicate = NSPredicate(format: "label like %@", "Medium")
                        let image = sizes.filter{ predicate.evaluate(with: $0)}.first as! [String : String]
                        
                        //Construct the photo object from Photo Model structure
                        let photo = PhotoModel(id: String(describing: photoObj["id"]!), farm: String(describing: photoObj["farm"]!), owner: photoObj["owner"] as! String, secret: String(describing: photoObj["secret"]!), server: String(describing: photoObj["server"]!), title: photoObj["title"] as! String, thumbnail: thumbnail["source"]!, source: image["source"]!)
                        
                        /*let photo = PhotoModel(id: String(describing: photoObj["id"]!), farm: String(describing: photoObj["farm"]!), owner: photoObj["owner"]! as! String, secret: String(describing: photoObj["secret"]!), server: String(describing: photoObj["server"]!), title: photoObj["title"]! as! String, thumbnail: thumbnail["source"]!, source: image["source"]!)*/
                        
                        values.append(photo)
                        
                        group.leave()
                    })
                }
            }
        }
        
        //Update the view model photos object. This will trigger the gallery view display update as per binding
        group.notify(queue: queue, execute: {
            self.galleryPhotos.value.removeAll()
            self.galleryPhotos.value.append(contentsOf: values)
        })
    }
    
    //Method to parse the size object from photo size response
    private func parsePhotoSize(data: Data)-> [Any]?
    {
        guard let responseDict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else { return nil }
        
        guard let sizesDict = responseDict!["sizes"] as? [String : Any] else { return nil }
       
        guard let sizesArr = sizesDict["size"] as? [Any] else { return nil }
        
        return sizesArr
    }
    
    //Method to parse the photo object from photo gallery response
    private func parsePhotosfromGallery(data: Data)-> [Any]?
    {
        guard let responseDict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else { return nil }
        
        guard let photosDict = responseDict!["photos"] as? [String : Any] else { return nil }
        
        guard let photosArr = photosDict["photo"] as? [Any] else { return nil }
        
        return photosArr
    }
}

//Extension that downloads the photos from Flickr gallery and photo size from size API
extension XFGalleryViewModel {
    
    //Method to download photo gallery asynchronously from Flickr service
    func downloadPhotosfromGallery(url: URL) {
        
        DispatchQueue.global(qos: .background).async {
            
            let serviceManager = ServiceManager(withUrl: url)
            
            serviceManager.downloadData(withCompletionHandler: { [unowned self] (data, error) in
                
                guard let httpData = data else { return }
                
                guard let values = self.parsePhotosfromGallery(data: httpData) else { return }
                
                self.loadPhotos(items: values)
            })
        }
    }
    
    //Method to download avaiable photo size asynchronously from Flickr service
    func downloadPhotoSize(url: URL, completionHandler:@escaping DownloadCompletionHandler) {
        
        let serviceManager = ServiceManager(withUrl: url)
        
        serviceManager.downloadData { (data, error) in
            
            if let httpData = data {
                completionHandler(httpData, nil)
            }
            else {
                completionHandler(nil, error)
            }
        }
    }
}
