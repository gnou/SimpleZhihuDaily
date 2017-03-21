//
//  CacheManager.swift
//  SimpleZhihuDaily
//
//  Created by Mingyu Cui on 09/03/2017.
//  Copyright © 2017 CuiMingyu. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class CacheManager {
    
    struct Formatter {
        static let Formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            return formatter
        }()
    }
    
    var realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func entriesOfDate(_ date: Date, handler: @escaping (Result<[Entry]>) -> Void) {
        let entries = realm.objects(Entry.self).filter("date = %@", date)
        if entries.count > 0 {
            handler(.success(Array(entries)))
            return
        }
        
        Alamofire.request(SRRouter.someday(date)).validate().responseJSON { [unowned self] (response: DataResponse<Any>) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let resultDate = Formatter.Formatter.date(from: json["date"].stringValue) ?? date
                var results = [Entry]()
                for subJSON in json["stories"].arrayValue {
                    if let title = subJSON["title"].string {
                        let entry = Entry()
                        entry.id = subJSON["id"].intValue
                        entry.title = title
                        entry.image = subJSON["images"].array?.first?.string
                        entry.date = resultDate
                        
                        results.append(entry)
                    } else {
                        continue
                    }
                }
                
                handler(.success(results))
                return
            case .failure(let error):
                handler(.failure(error))
                return
            }
        }
    }
}
