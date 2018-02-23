//
//  Article.swift
//  TechNews
//
//  Created by Lucy Mambre on 24/01/2018.
//  Copyright © 2018 Lucy Mambre. All rights reserved.
//

import UIKit

class Article: NSObject {
    
    var title: String?
    var desc: String?
    var author: String?
    var url: String?
    var imageUrl: String?
    
    init?(title: String, desc: String, author: String, url: String, imageUrl: String) {
        self.title = title
        self.desc = desc
        self.author = author
        self.url = url
        self.imageUrl = imageUrl
    }
}
