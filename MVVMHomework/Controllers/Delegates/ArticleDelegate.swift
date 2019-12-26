//
//  ArticleDelegate.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/25/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import Foundation

protocol ArticleDelegate {
    func didFinishInsertingArticle(_ article: ArticleModel)
    func didFinishUpdatingArticle(_ article: ArticleModel)
}
