//
//  Router.swift
//  SimpleZhihuDaily
//
//  Created by CuiMingyu on 1/1/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "http://news-at.zhihu.com/api/4"
    
    case LatestStoryList
    case StoryListForDay(dayString: String)
    case Story(id: Int)
    
    var URLRequest: NSMutableURLRequest {
        var method: Alamofire.Method {
            switch self {
            default:
                return .GET
            }
        }
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
            case .LatestStoryList:
                return ("news/latest", nil)
            case .Story(let id):
                return ("news/\(id)", nil)
            case .StoryListForDay(let dayString):
                return ("news/before/\(dayString)", nil)
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        
        let encoding: ParameterEncoding = {
            switch method {
            case .GET, .HEAD, .DELETE:
                return ParameterEncoding.URL
            case .POST, .PUT:
                return ParameterEncoding.JSON
            default:
                return ParameterEncoding.JSON
            }
        }()
        
        let encodingRequest = encoding.encode(URLRequest, parameters: result.parameters).0
        encodingRequest.HTTPMethod = method.rawValue
        return encodingRequest
    }
}