//
//  AttractionsViewModel.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/14.
//
import UIKit

class AttractionsViewModel {
    
    func downloadAllImage(srcs: [String], completion: @escaping(([UIImageView]) ->())) {
        let group = DispatchGroup()
        var images: [UIImageView] = []
        
        for src in srcs {
            group.enter()
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
            imageView.loadImage(with: src) { _ in
                images.append(imageView)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(images)
        }
    }
}
