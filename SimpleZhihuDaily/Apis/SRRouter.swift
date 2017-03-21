//
//  SRRouter.swift
//  SimpleZhihuDaily
//
//  Created by CuiMingyu on 1/1/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import Foundation
import Alamofire

enum SRRouter: URLRequestConvertible {
    static let baseURLString = "https://news-at.zhihu.com/api/4"
    
    struct Formatter {
        static let Formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            return formatter
        }()
    }
    
    case latest
    case someday(Date)
    case content(Int)
    case extraData(Int)
    case longComments(Int)
    case shortComments(Int)
    
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {
            case .latest, .someday, .content, .extraData, .longComments, .shortComments:
                return .get
            }
        }
        
        let url: URL = {
            let relativePath: String?
            
            switch self {
            case .latest:
                relativePath = "/news/latest"
            case .someday(let date):
                let dayString = Formatter.Formatter.string(from: date)
                relativePath = "/news/before/\(dayString)"
            case .content(let id):
                relativePath = "/news/\(id)"
            case .extraData(let id):
                relativePath = "/story-extra/\(id)"
            case .longComments(let id):
                relativePath = "/story/\(id)/long-comments"
            case .shortComments(let id):
                relativePath = "/story/\(id)/short-comments"
            }
            
            var url = URL(string: SRRouter.baseURLString)
            
            if let _relativePath = relativePath {
                url?.appendPathComponent(_relativePath)
            }
 
            return url!
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding = JSONEncoding.default
        return try encoding.encode(urlRequest)
    }
}
