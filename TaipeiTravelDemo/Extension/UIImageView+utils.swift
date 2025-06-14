//
//  UIImageView+utils.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/12.
//

import UIKit

extension UIImageView {
    
    /// - Parameter urlString: _
    public func loadImage(with urlString: String, completion: ((UIImage?) -> Void)? = nil) {
        guard let url = URL(string: urlString) as URL? else {
            debugPrint("Invalid url: \(urlString)")
            self.image = UIImage()
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let error = error {
                debugPrint("load image fail: \(error.localizedDescription)")
                self.image = UIImage()
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    completion?(self.image)
                }
            }
        }
        dataTask.resume()
    }
}
