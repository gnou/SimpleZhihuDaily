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
