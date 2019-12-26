//
//  ArticleViewModel.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/24/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewModel {
    
    private let articleService = ArticleService()
    
    func fetchArticles(page: Int, completion: @escaping ([ArticleModel]) -> ()) {
        articleService.fetchArticles(page: page) { (articles) in
            completion(articles.compactMap(ArticleModel.init))
        }
    }
    
    func addArticle(image: UIImage, article: Article, completion: @escaping (ArticleModel) -> ()) {
        articleService.addArticle(image: image, article: article) { (article) in
            completion(ArticleModel(article: article))
        }
    }
    
    func updateArticle(isImageNotChanged: Bool, image: UIImage, article: Article, completion: @escaping (ArticleModel) -> ()) {
        articleService.updateArticle(isImageNotChanged: isImageNotChanged, image: image, article: article) { (article) in
            completion(ArticleModel(article: article))
        }
    }
    
    func deleteArticle(id: Int, completion: @escaping () -> ()) {
        articleService.deleteArticle(id: id) {
            completion()
        }
    }
    
}
