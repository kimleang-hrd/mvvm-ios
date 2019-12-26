//
//  ArticleModel.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/24/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

struct ArticleModel {
    
    var hiddenId: Int
    var articleTitle: String
    var description: String
    var date: String
    var authorName: String
    var numberOfViews: Int
    var imageUrl: URL?
    
    init(article: Article) {
        hiddenId = article.id ?? 0
        articleTitle = article.articleTitle ?? ""
        description = article.description ?? ""
        date = CustomDateFormatter.convertStringToDate(dateString: article.date ?? "")
        authorName = ArticleInitialization.author
        numberOfViews = ArticleInitialization.view
        imageUrl = URL(string: article.imageUrl ?? "")
    }
    
}
