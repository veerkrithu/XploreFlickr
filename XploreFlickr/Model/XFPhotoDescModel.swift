//
//  XFPhotoDescModel.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/17/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import Foundation

struct PhotoDescModel {
    
    var id:             String?
    var description:    String?
    var datetaken:      String?
    var views:          String?
    var latitude:       String?
    var longitude:      String?
    var accuracy:       String?
    
    init(id: String? = nil, description: String? = nil, datetaken: String? = nil, views: String? = nil, latitude: String? = nil, longitude: String? = nil, accuracy: String? = nil) {
        
        self.id = id
        self.description = description
        self.datetaken = datetaken
        self.views = views
        self.latitude = latitude
        self.longitude = longitude
        self.accuracy = accuracy
    }
}
