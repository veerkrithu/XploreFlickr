//
//  XFListViewModel.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/13/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import Foundation

class XFListViewModel {
    
    var galleryList: XFBox<[GalleryModel]> = XFBox([])
    
    func setupGalleryList() {
        
        var galleriesArr = [GalleryModel]()
        
        var gallery = GalleryModel(id: "72157677476597845", title: "Top Flickr Photos of 2016" , description: "For the Top Flickr Photos of 2016, we sorted through billions of uploads to arrive at these 50 favorites.", thumbnail: "https://farm2.staticflickr.com/1695/24173905193_89196bf532_q.jpg")
        
        galleriesArr.append(gallery)
        
        gallery = GalleryModel(id: "72157667163347739", title: "Top Landscape Photography of 2017" , description: "Landscapes from around the world are some of the most gorgeous examples of photography that you'll see on Flickr.", thumbnail: "https://farm5.staticflickr.com/4240/34943640193_c2a25d399e_q.jpg")
        
        galleriesArr.append(gallery)
        
        gallery = GalleryModel(id: "72157688116208652", title: "Flickr's Top-25 photos of 2017" , description: "These are the Top-25 Flickr photos from around the world in 2017. These were determined by starting with an engagement algorithm and then curation from Flickr staff.", thumbnail: "https://farm5.staticflickr.com/4486/38054858802_e3ab654ce1_q.jpg")
        
        galleriesArr.append(gallery)
        
        gallery = GalleryModel(id: "72157657418706139", title: "On Island Time" , description: "Things move at a different pace on the islands. Daydream with us for a moment as the sun kisses your face and the warm sand hits your toes.", thumbnail: "https://farm5.staticflickr.com/4085/5201509508_453c837a4f_q.jpg")
        
        galleriesArr.append(gallery)
        
        galleryList.value.append(contentsOf: galleriesArr)
    }
}
