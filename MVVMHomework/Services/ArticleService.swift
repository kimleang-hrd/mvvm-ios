//
//  ArticleService.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/24/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ArticleService {
    
    func fetchArticles(page: Int, completion: @escaping ([Article]) -> Void) {
        Alamofire.request("\(APIManager.FETCH_URL)?page=\(page)&limit=15").responseJSON { (response) in
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    var articles: [Article] = []
                    for article in json["DATA"].arrayValue {
                        articles.append(Article(json: article))
                    }
                    completion(articles)
                } catch {
                    completion([])
                }
            } else {
                completion([])
            }
        }
    }
    
}
