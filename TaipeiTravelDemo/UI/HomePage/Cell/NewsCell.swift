//
//  NewsCell.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/12.
//

import UIKit

class NewsCell: UICollectionViewCell {

    static let id = "NewsCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.setLineSpacing(5)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail

        descriptionLabel.setLineSpacing(5)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .descriptionColor
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail

        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
    
    func config(with news: News, isLast: Bool) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        separatorLineView.isHidden = isLast
    }
}
