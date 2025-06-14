//
//  HeaderView.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/12.
//

import UIKit

class HeaderView: UICollectionReusableView {

    static let id = "HeaderView"
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .label
    }
    
    func setup(with text: String) {
        titleLabel.text = text
    }
}
