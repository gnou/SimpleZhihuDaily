//
//  Entry.swift
//  SimpleZhihuDaily
//
//  Created by Mingyu Cui on 06/03/2017.
//  Copyright © 2017 CuiMingyu. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Entry: Object {
    
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var image: String?
    
    dynamic var type: Int = 0
    
    dynamic var date: Date = Date()
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
    
}

//extension Entry: ResponseJSONObjectSerializable {
//    required convenience init?(json: JSON) {
//        guard let id = json["id"].int,
//            let title = json["title"].string else {
//                return nil
//        }
//        
//        self.id = id
//        self.title = title
//        self.image = json["images"].array?.first?.string ?? json["image"].string
//        
////        self.type = json["type"].int
////        self.init()
//    }

//    required init(value: Any, schema: RLMSchema) {
//        fatalError("init(value:schema:) has not been implemented")
//    }
//}
