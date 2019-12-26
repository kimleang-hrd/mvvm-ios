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
    
    var id: Int?
    var articleTitle: String?
    var date: String?
    var description: String?
    var imageUrl: String?
    
    init(json: JSON) {
        id = json["ID"].int
        articleTitle = json["TITLE"].string
        date = json["CREATED_DATE"].string
        description = json["DESCRIPTION"].string
        imageUrl = json["IMAGE"].string
    }
    
    init() {}
    
}

extension Article {
    func toJSON() -> [String: Any] {
        return [
            "TITLE": self.articleTitle ?? "",
            "CREATED_DATE": self.date ?? "",
            "DESCRIPTION": self.description ?? "",
            "IMAGE": self.imageUrl ?? ""
        ]
    }
}
