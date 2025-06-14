//
//  String+utils.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/11.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "LocalizedStrings", bundle: Bundle.main, comment: self)
    }
    
    func addLineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
}
