//
//  DetailViewController.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/25/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var articleModel: ArticleModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        setupData()
    }
    
    func setupUI() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(holdToSaveImage(gesture:)))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func setupData() {
        guard let article = articleModel else {
            print("Article is nil")
            return
        }
        self.imageView.kf.setImage(with: article.imageUrl)
        self.titleLabel.text = article.articleTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        self.dateLabel.text = article.date.isEmpty ? "No Date" : article.date
        self.viewLabel.text = article.numberOfViews > 1 ? "\(article.numberOfViews) views".trimmingCharacters(in: .whitespacesAndNewlines) : "\(article.numberOfViews) view".trimmingCharacters(in: .whitespacesAndNewlines)
        self.descriptionLabel.text = article.description.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    @objc func holdToSaveImage(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .changed {
            let image = self.imageView.image!
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
                UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    
}
