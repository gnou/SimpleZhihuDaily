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
    
    let backgroundQueueLabel = "me.gnou.realmbg"
    
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
        
        let router: SRRouter
        if Calendar.current.isDate(date, inSameDayAs: Date()) {
            router = SRRouter.latest
        } else {
            router = SRRouter.someday(date)
        }
        
        Alamofire.request(router).validate().responseJSON { [weak self] (response: DataResponse<Any>) in
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
                
                if let weakSelf = self {
                    DispatchQueue(label: weakSelf.backgroundQueueLabel).async {
                        autoreleasepool {
                            do {
                                let bgRealm = try Realm()
                                bgRealm.beginWrite()
                                for entry in results {
                                    bgRealm.add(entry)
                                }
                                do {
                                    try bgRealm.commitWrite()
                                } catch {
                                }
                            } catch {
                                
                            }
                        }
                    }
                    
                }
                return
            case .failure(let error):
                handler(.failure(error))
                return
            }
        }
    }
    
    func story(_ id: Int, handler: @escaping (Result<Story>) -> Void) {
        let stories = realm.objects(Story.self).filter("id = \(id)")
        if let story = stories.first {
            handler(.success(story))
            return
        }
        
        Alamofire.request(SRRouter.content(id)).responseJSON { [weak self] response in
            switch response.result {
            case .failure(let error):
                handler(.failure(error))
                return
            case .success(let value):
                let json = JSON(value)
                let story = Story()
                story.load(with: json)
                
                handler(.success(story))
                if let weakSelf = self {
                    do {
                        try weakSelf.realm.write {
                            weakSelf.realm.add(story)
                        }
                    } catch {
                        
                    }
                }
                
                return
            }
        }
    }
}
