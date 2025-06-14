//
//  Attractions.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/10.
//

import Foundation

// MARK: - Attraction
struct Attraction: Codable {
    let id: Int
    let name: String
    let introduction: String?
    let openTime: String?
    let zipcode: String?
    let distric: String?
    let address: String?
    let tel: String?
    let fax: String?
    let email: String?
    let months: String?
    let nlat: Double?
    let elong: Double?
    let officialSite: String?
    let facebook: String?
    let ticket: String? // 再看看需不需要？
    let remind: String? // 再看看需不需要？
    let modified: String? // 修改的時間
    let url: String?
    let category: [Category]?
    let target: [Category]?
    let friendly: [Category]?
    let images: [AttrImage]?
    let links: [RelatedLink]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case introduction
        case openTime = "open_time"
        case zipcode
        case distric
        case address
        case tel
        case fax
        case email
        case months
        case nlat
        case elong
        case officialSite = "official_site"
        case facebook
        case ticket
        case remind
        case modified
        case url
        case category
        case target
        case friendly
        case images
        case links
    }
}

extension Attraction {
    var oneImageSrc: String? {
        if let image = images?.first, let src = image.src {
            return src
        }
        return nil
    }
    
    var imageSrcs: [String]? {
        return images?.compactMap({ $0.src })
    }
    
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String?
}

// MARK: - AttrImage
struct AttrImage: Codable  {
    let src: String?
    let subject: String?
    let ext: String?
}

// MARK: - Link
struct RelatedLink: Codable  {
    let src: String?
    let subject: String?
}

// MARK: - SpotDetail
typealias SpotDetailRow = (title: String, content: Any, key: String)

struct SpotDetail {
    let name: String
    let introduction: String?
    let openTime: String?
    let address: String?
    let tel: String?
    let fax: String?
    let url: String?
    
    static let keyMap: [String: String] = [
        "name": "spot.name".localized,
        "introduction": "spot.introduction".localized,
        "openTime": "spot.openTime".localized,
        "address": "spot.address".localized,
        "tel": "spot.tel".localized,
        "fax": "spot.fax".localized,
        "url": "spot.url".localized,
    ]
    
    // 顯示的順序
    static let orderedKeys: [String] = [
        "openTime", "address", "fax", "tel", "url", "introduction"
    ]
}

extension SpotDetail {
    var asDictionary: [String: Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.compactMap { (key: String?, value: Any) -> (String, Any)? in
            guard let key = key else { return nil }
            return (key, value)
        })
        return dict
    }
    
    var asArray: [SpotDetailRow] {
        var array: [SpotDetailRow] = []

        let dict = self.asDictionary
        for key in SpotDetail.orderedKeys {
            if let value = dict[key], let displayKey = SpotDetail.keyMap[key] {
                array.append((key == "introduction" ? "" : displayKey, value, key))
            }
        }
        return array
    }
}
