//
//  Entry.swift
//  SimpleZhihuDaily
//
//  Created by Mingyu Cui on 06/03/2017.
//  Copyright © 2017 CuiMingyu. All rights reserved.
//

import Foundation
import RealmSwift

class Entry: Object {
    dynamic var id: Int = 0
    dynamic var name: String?
    dynamic var descriptionString: String?
    
    let color = RealmOptional<Int>()
    dynamic var thumbnail: String?
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}
