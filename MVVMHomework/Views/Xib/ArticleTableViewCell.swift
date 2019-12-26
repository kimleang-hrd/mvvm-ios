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
        articleImageView.kf.setImage(with: articleModel.imageUrl, placeholder: UIImage(named: "default"))
        titleLabel.text = articleModel.articleTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        numberOfViewLabel.text = "\(articleModel.numberOfViews)".trimmingCharacters(in: .whitespacesAndNewlines)
        dateLabel.text = articleModel.date.trimmingCharacters(in: .whitespacesAndNewlines)
        authorLabel.text = articleModel.authorName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    
}
