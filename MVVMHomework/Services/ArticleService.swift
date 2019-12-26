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
    
    func addArticle(image: UIImage, article: Article, completion: @escaping (Article) -> ()) {
        uploadImage(image: image) { [weak self] (imageUrl) in
            guard let self = self else { return }
            var articleToUpload = article
            articleToUpload.imageUrl = imageUrl
            self.addArticle(article: articleToUpload)
            completion(articleToUpload)
        }
    }
    
    func updateArticle(isImageNotChanged: Bool, image: UIImage, article: Article, completion: @escaping (Article) -> ()) {
        if isImageNotChanged {
            var articleToUpload = article
            articleToUpload.imageUrl = article.imageUrl
            print(articleToUpload)
            self.updateArticle(article: articleToUpload)
            completion(articleToUpload)
        } else {
            uploadImage(image: image) { [weak self] (imageUrl) in
                guard let self = self else { return }
                var articleToUpload = article
                articleToUpload.imageUrl = imageUrl
                self.updateArticle(article: articleToUpload)
                completion(articleToUpload)
            }
        }
    }
    
    func deleteArticle(id: Int, completion: @escaping () -> ()) {
        Alamofire.request("\(APIManager.MUTATE_URL)/\(id)", method: .delete).responseJSON { (response) in
            switch response.result {
                case .success(_):
                    print("Delete Success")
                    completion()
                case .failure(_):
                    print("Delete Fail")
            }
        }
    }
    
    private func updateArticle(article: Article) {
        let articleMapper = article.toJSON()
        print(article)
        Alamofire.request("\(APIManager.MUTATE_URL)/\(article.id ?? 0)", method: .put, parameters: articleMapper, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                case .success(_):
                    print("Update Success")
                case .failure(_):
                    print("Update Fail")
            }
        }
    }
    
    private func addArticle(article: Article) {
        let articleMapper = article.toJSON()
        Alamofire.request(APIManager.MUTATE_URL, method: .post, parameters: articleMapper, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                case .success(_):
                    print("Success")
                case .failure(_):
                    print("Fail")
            }
        }
    }
    
    func uploadImage(image: UIImage, completion: @escaping (String?) -> ()) {
        guard let pngData = image.pngData() else {
            print("PNG Error")
            return
        }
        Alamofire.upload(multipartFormData: { (data) in
            data.append(pngData, withName: "FILE", fileName: "1.png", mimeType: "image/jpeg")
        }, to: APIManager.UPLOAD_IMAGE) { (result) in
            switch result {
                case .success(let uploaded, _, _):
                    uploaded.responseJSON { (response) in
                        switch response.result {
                            case .success(let value):
                                let v = value as! [String: Any]
                                completion(v["DATA"] as? String)
                            case .failure(_):
                                print("Failure")
                        }
                    }
                case .failure(_):
                    print("Error")
                    completion(nil)
            }
        }
    }
    
}
