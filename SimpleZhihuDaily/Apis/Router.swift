//
//  Router.swift
//  SimpleZhihuDaily
//
//  Created by CuiMingyu on 1/1/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import Foundation
import Alamofire

//enum SRRouter: URLRequestConvertible {
//    static let baseURLString = "http://news-at.zhihu.com/api/4"
//    
//    case latestStoryList
//    case storyListForDay(dayString: String)
//    case story(id: Int)
//    
//    var URLRequest: NSMutableURLRequest {
//        var method: Alamofire.Method {
//            switch self {
//            default:
//                return .GET
//            }
//        }
//        let result: (path: String, parameters: [String: AnyObject]?) = {
//            switch self {
//            case .latestStoryList:
//                return ("news/latest", nil)
//            case .story(let id):
//                return ("news/\(id)", nil)
//            case .storyListForDay(let dayString):
//                return ("news/before/\(dayString)", nil)
//            }
//        }()
//        
//        let URL = Foundation.URL(string: Router.baseURLString)!
//        let URLRequest = NSMutableURLRequest(url: URL.appendingPathComponent(result.path))
//        
//        let encoding: ParameterEncoding = {
//            switch method {
//            case .GET, .HEAD, .DELETE:
//                return ParameterEncoding.URL
//            case .POST, .PUT:
//                return ParameterEncoding.JSON
//            default:
//                return ParameterEncoding.JSON
//            }
//        }()
//        
//        let encodingRequest = encoding.encode(URLRequest as! URLRequestConvertible, with: result.parameters).0
//        encodingRequest.HTTPMethod = method.rawValue
//        return encodingRequest
//    }
//}
