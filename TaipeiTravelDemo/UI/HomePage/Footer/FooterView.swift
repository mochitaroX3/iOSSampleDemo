//
//  FooterView.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/12.
//

import UIKit

class FooterView: UICollectionReusableView {

    static let id = "FooterView"
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .footerBkColor
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = .buttonTextColor
        titleLabel.text = "click.me".localized

        let tap = UITapGestureRecognizer(target: self, action: #selector(onCklick))
        addGestureRecognizer(tap)
    }
    
    @objc func onCklick() {
        print("Click FooterView>>>>>>")
    }
    
}
