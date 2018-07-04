//
//  XFImageDetailViewModel.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/17/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import Foundation

class XFImageDetailViewModel {
    
    var photoDescModel:XFBox<PhotoDescModel> = XFBox(PhotoDescModel())
    
    //Functvar to retrieve url for photos from flickr gallery
    func urlForPhotosInfo(id: String)-> URL {
        
        let url = ServiceManager.getBaseUrl(withMethod: "flickr.photos.getInfo") + "&photo_id=\(id)&format=json&nojsoncallback=1"
        
        return URL(string: url)!
    }
    
}

//Extension that downloads the photos from Flickr gallery and photo size from size API
extension XFImageDetailViewModel {
    
    //Method to download photo gallery asynchronously from Flickr service
    func downloadPhotoInfo(url: URL) {
        
        DispatchQueue.global(qos: .background).async {
            
            let serviceManager = ServiceManager(withUrl: url)
            
            serviceManager.downloadData(withCompletionHandler: { /*[unowned self]*/ (data, error) in
                
                guard let httpData = data else { return }
                
                guard let photoDescModel = self.parsePhotoInfo(data: httpData) else { return }
                
                self.photoDescModel.value = photoDescModel
            })
        }
    }
    
    //Method to parse the photo object from photo gallery response
    private func parsePhotoInfo(data: Data)-> PhotoDescModel?
    {
        var photoDescModel = PhotoDescModel()
        
        guard let responseDict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else { return nil }
        
        guard let photoDict = responseDict!["photo"] as? [String : Any] else { return nil }
        
        guard let locationDict = photoDict["location"] as? [String : Any] else { return nil }
        
        guard let datesDict = photoDict["dates"] as? [String : Any] else { return nil }
        
        if let id = photoDict["id"] as? String
        {
            photoDescModel.id = id
        }
        
        if let views = photoDict["views"] as? String
        {
            photoDescModel.views = views
        }
        
        if let latitude = locationDict["latitude"] as? String
        {
            photoDescModel.latitude = latitude
        }
        
        if let longitude = locationDict["longitude"] as? String
        {
            photoDescModel.longitude = longitude
        }
        
        if let accuracy = locationDict["accuracy"] as? String
        {
            photoDescModel.accuracy = accuracy
        }
        
        if let datetaken = datesDict["taken"] as? String
        {
            photoDescModel.datetaken = datetaken
        }

        return photoDescModel
    }
}
