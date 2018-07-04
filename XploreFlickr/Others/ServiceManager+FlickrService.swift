//
//  ServiceManager+FlickrService.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/17/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import Foundation

extension ServiceManager {
    
    //Registered API key from Flickr
    private static let apiKey = "20848af5ebf3371bb9fce1480a497dab"
    
    class func getBaseUrl(withMethod method: String) -> String {
        
        return "https://api.flickr.com/services/rest/?method=\(method)&api_key=\(ServiceManager.apiKey)"
    }
}
