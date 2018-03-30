//
//  Food.swift
//  RxTableViewTest
//
//  Created by mac on 30.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

struct Food {
    
    let name: String
    let flickrID: String
    var image: UIImage?
    
    init(name: String, flickrID: String) {
        self.name = name
        self.flickrID = flickrID
        image = UIImage(named: flickrID)
    }
    
}

extension Food: CustomStringConvertible {
    
    var description: String {
        return "\(name): flickr.com/\(flickrID)"
    }
    
}
