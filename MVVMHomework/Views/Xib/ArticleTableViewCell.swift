//
//  ArticleTableViewCell.swift
//  MVVMHomework
//
//  Created by Kimleang Kea on 12/24/19.
//  Copyright © 2019 Kimleang Kea. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfViewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ articleModel: ArticleModel) {
        articleImageView.kf.setImage(with: articleModel.imageUrl)
        titleLabel.text = articleModel.articleTitle
        numberOfViewLabel.text = "\(articleModel.numberOfViews)"
        dateLabel.text = articleModel.date
        authorLabel.text = articleModel.authorName
    }
    
    
    
}
