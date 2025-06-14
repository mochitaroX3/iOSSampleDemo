//
//  API.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/10.
//

import UIKit
import Alamofire

public enum CLError: Error, Equatable {
    case `default`
    case statusCodeNot200
    
    public var localizedDescription: String {
        switch self {
        case .statusCodeNot200:
            return "服務異常，請稍後再試"
        default:
            return "服務異常，請稍後再試"
        }
    }
}

// MARK: - ResponseObject
struct ResponseObject<A: Codable>: Codable {
    let total: Int
    let data: [A]
}

class API {
    
    private struct Static {
        static var instance : API!
    }
    
    public static var shared : API = {
        let queue = DispatchQueue(label: "once")
        queue.sync {
            Static.instance = API()
        }
        return Static.instance
    }()
    
    func doGet<A: Codable>(url: URL, completion: @escaping (Result<[A]?, CLError>) -> ()) {
        let headers = ["accept": "application/json"]
        let httpHeaders = HTTPHeaders(headers)

        AF.request(url, method: .get, headers: httpHeaders).responseDecodable(of: ResponseObject<A>.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result.data))
            case .failure(_):
                if response.response?.statusCode != 200 {
                    completion(.failure(CLError.statusCodeNot200))
                } else {
                    completion(.failure(CLError.default))
                }
            }
        }
    }
}
