//
//  HomeViewModel.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/11.
//

import Foundation

enum AppLanguage: String, CaseIterable {
    case zh_tw = "zh-Hant"
    case zh_cn = "zh-Hans"// 簡體中文
    case en // 英文
    case ja // 日文
    case ko //韓文
    
    var apiLange: String {
        switch self {
        case .zh_tw:
            return "zh-tw"
        case .zh_cn:
            return "zh-cn"
        case .en, .ja, .ko:
            return self.rawValue
        }
    }
    
    var displayName: String {
        switch self {
        case .zh_tw:
            return "zh_tw.language.displayed.name".localized
        case .zh_cn:
            return "zh_cn.language.displayed.name".localized
        case .en:
            return "en.language.displayed.name".localized
        case .ja:
            return "ja.language.displayed.name".localized
        case .ko:
            return "ko.language.displayed.name".localized
        }
    }
}

class HomeViewModel {
    
    var showErrorMessage: ((String) ->())? = nil
    var showLoading: (() ->())? = nil
    var hideLoading: (() ->())? = nil
    
    func fetchAttractions(lange: AppLanguage, completion: @escaping([Attraction]) ->()) {
        guard let url = URL(string: "https://www.travel.taipei/open-api/\(lange.apiLange)/Attractions/All?page=1") else { return }
        showLoading?()
        API.shared.doGet(url: url) { (result: Result<[Attraction]?, CLError>) in
            self.hideLoading?()
            switch result {
            case.success(let data):
                guard let data = data else {
                    self.showErrorMessage?(CLError.default.localizedDescription)
                    return
                }
                completion(Array(data.prefix(5)))
            case.failure(let err):
                self.showErrorMessage?(err.localizedDescription)
            }
        }
    }
    
    func fetchNews(lange: AppLanguage, completion: @escaping([News]) ->()) {
        guard let url = URL(string: "https://www.travel.taipei/open-api/\(lange.apiLange)/Events/News?page=1") else { return }
        showLoading?()
        API.shared.doGet(url: url) { (result: Result<[News]?, CLError>) in
            self.hideLoading?()
            switch result {
            case.success(let data):
                guard let data = data else {
                    self.showErrorMessage?(CLError.default.localizedDescription)
                    return
                }
                completion(Array(data.prefix(5)))
            case.failure(let err):
                self.showErrorMessage?(err.localizedDescription)
            }
        }
    }
}
