//
//  UIViewController+utils.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/13.
//

import UIKit

extension UIViewController {
    public static func initInstance<T: UIViewController>() -> T {
        return UIStoryboard.Main.newInstance(id: String(describing: self))
    }
}

extension UIStoryboard {
    static var Main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func newInstance<T: UIViewController>(id: String) -> T {
        return self.instantiateViewController(withIdentifier: id) as! T
    }
}
