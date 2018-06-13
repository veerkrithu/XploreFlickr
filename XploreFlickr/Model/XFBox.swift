//
//  XFBox.swift
//  XploreFlickr
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 6/12/18.
//  Copyright © 2018 Ganesan, Veeramani - Contractor {BIS}. All rights reserved.
//

import Foundation
/*This is the boxed class of generic type. This class will support binding via listeners. Listeners are the closures where target class can pass it's clousers as listeners and any change in the boxed value will call the listeners. The UI update code can be enclosed in the target listener to perform any UI changes*/
class XFBox <T> {
    
    typealias Listener = (T)->Void
    var listener: Listener?
    
    var value: T {
        
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
