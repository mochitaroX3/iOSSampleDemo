//
//  Untitled.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/12.
//

import UIKit

public enum Colors {
    case description // #949494
    case footerbackground // #d9e4ff
    case buttonText // #004aff
    case pageIndicator // #fa8d4d
    
    var color: UIColor {
        switch self {
        case .description: return UIColor(hexString: "#949494")
        case .footerbackground: return UIColor(hexString: "#d9e4ff")
        case .buttonText: return UIColor(hexString: "#004aff")
        case .pageIndicator: return UIColor(hexString: "#fa8d4d")
        }
    }
}

extension UIColor {
    static let descriptionColor = Colors.description.color
    static let footerBkColor = Colors.footerbackground.color
    static let buttonTextColor = Colors.buttonText.color
    static let pageIndicatorColor = Colors.pageIndicator.color
    static let mainColor = UIColor(named: "mainColor")!
}

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
//        Scanner(string: hex).scanHexInt32(&int)
        
        let scanner = Scanner(string: hex)
        if let scanned = Scanner(string: hex).scanUInt64(representation: .hexadecimal) {
            int = scanned
        } else {
            // 若解析失敗，預設為黑色
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
