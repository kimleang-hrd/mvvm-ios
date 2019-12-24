//
//  ArticleViewModel.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/24/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import Foundation

class ArticleViewModel {
    
    private let articleService = ArticleService()
    
    func fetchArticles(page: Int, completion: @escaping ([ArticleModel]) -> ()) {
        articleService.fetchArticles(page: page) { (articles) in
            completion(articles.compactMap(ArticleModel.init))
        }
    }
    
}
