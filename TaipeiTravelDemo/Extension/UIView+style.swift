//
//  UIView+style.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/12.
//

import UIKit

extension UIView {
    
    func addBorder(borderColor: UIColor = .descriptionColor, borderWidth: CGFloat = 1) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func addRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
