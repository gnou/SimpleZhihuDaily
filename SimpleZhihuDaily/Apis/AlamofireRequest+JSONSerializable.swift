//
//  AlamofireRequest+JSONSerializable.swift
//  SimpleZhihuDaily
//
//  Created by CuiMingyu on 1/1/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension DataRequest {
    @discardableResult
    public func responseObject<T: ResponseJSONObjectSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        let responseSerializer = DataResponseSerializer<T> { (request, response, data, error) -> Result<T> in
            guard error == nil else { return .failure(error!) }
            
            guard let responseData = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            let json = JSON(data: responseData)
            
            guard let newObj = T(json: json) else {
                return .failure(SRError.responseJSONObjSerializationFailed)
            }
            
            return .success(newObj)
        }
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    @discardableResult
    public func responseCollection<T: ResponseJSONObjectSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void)
        -> Self
    {
        let responseSerializer = DataResponseSerializer<[T]> { (request, response, data, error) -> Result<[T]> in
            guard error == nil else { return .failure(error!) }
            
            guard let responseData = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            let json = JSON(data: responseData)
            
            let objects = json.arrayValue.flatMap { T(json: $0) }
            return .success(objects)
        }
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
}
