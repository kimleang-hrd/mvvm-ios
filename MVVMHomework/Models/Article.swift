//
//  Article.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/24/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Article {
    
    var articleTitle: String?
    var date: String?
    var imageUrl: String?
    
    init(json: JSON) {
        articleTitle = json["TITLE"].string
        date = json["CREATED_DATE"].string
        imageUrl = json["IMAGE"].string
    }
    
}
