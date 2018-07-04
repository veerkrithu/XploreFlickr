//
//  XFServiceManager.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/17/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import Foundation

class ServiceManager {
    
    typealias DownloadCompletionHandler = (_ data: Data?, _ error: Error?)->Void
    let url: URL?
    
    init(withUrl: URL) {
        
        self.url = withUrl
    }
    
    //Generic method to initiate download using url session in asynchronous mode. Once download completed completion handler closure will be invoked
    func downloadData(withCompletionHandler: @escaping DownloadCompletionHandler)
    {
        URLSession.shared.dataTask(with: self.url!, completionHandler: { [unowned self] (data, response, error) in
            
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200 {
                
                if let httpData = data {
                    withCompletionHandler(httpData, nil)
                }
            }
            else {
                withCompletionHandler(nil, self.errorForMessage(message: "Invalid Response"))
            }
            
        }).resume()
    }
    
    //Method to return error object based on given error message
    private func errorForMessage(message: String)->Error {
        
        return NSError(domain: "com.Self.XploreFlickr", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
