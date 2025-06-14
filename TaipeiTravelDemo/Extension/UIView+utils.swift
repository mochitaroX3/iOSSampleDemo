//
//  UIView+utils.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/13.
//

import UIKit

extension UIView {
    func newNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)!.first as! T
    }
    
    func fill(with subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: insets.right),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: insets.bottom)])
    }
}
