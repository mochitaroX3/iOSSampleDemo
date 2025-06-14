//
//  AttractionCell.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/12.
//

import UIKit

class AttractionCell: UICollectionViewCell {

    static let id = "AttractionCell"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
        
        imageContentView.addRadius(radius: 8)

        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }

    func config(with attr: Attraction) {
        titleLabel.text = attr.name
        descriptionLabel.text = attr.introduction
        imageView.contentMode = .scaleAspectFill
        imageView.loadImage(with: attr.oneImageSrc ?? "")
    }
}
