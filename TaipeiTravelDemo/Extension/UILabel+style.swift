//
//  UILabel+style.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/12.
//

import UIKit

extension UILabel {
    func setLineSpacing(_ spacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing

        let attributedString = NSMutableAttributedString(string: self.text ?? " ")
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }
    
    func addClickStyle(text: String) {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.buttonTextColor
                                    , range:  NSRange(location: 0, length: text.count))        
        self.attributedText = attributedText
    }
    
}
