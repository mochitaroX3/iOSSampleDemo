//
//  News.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/10.
//

import Foundation

// MARK: - News
struct News: Codable {
    let id: Int
    let title: String
    let description: String?
    let posted: String?
    let modified: String?
    let url: String?
    let files: [File]? // 這裡會有ＰＤＦ的檔案
    let links: [RelatedLink]?
}

// MARK: - File
struct File: Codable {
    let src: String?
    let subject: String?
    let ext: EXT
}

enum EXT: String, Codable {
    case pdf = ".pdf"
}
