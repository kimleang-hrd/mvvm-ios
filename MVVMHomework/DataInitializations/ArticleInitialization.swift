//
//  ArticleInitialization.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/24/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import Foundation

struct ArticleInitialization {
    
    private static let authors = [
        "Monkey D. Luffy",
        "Roronoa Zoro",
        "Itachi Uchicha",
        "Naruto Uzumaki",
        "Trafalgar D. Water Law"
    ]

    private static let views = [
        105,
        50,
        123,
        290,
        300
    ]
    
    static var author: String {
        return authors[Int.random(in: 0..<authors.count)]
    }
    
    static var view: Int {
        return views[Int.random(in: 0..<views.count)]
    }
    
}
