//
//  Story.swift
//  SimpleZhihuDaily
//
//  Created by Mingyu Cui on 22/03/2017.
//  Copyright © 2017 CuiMingyu. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Story: Object {
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var image: String = ""
    dynamic var shareURLString: String = ""
    
    dynamic var body: String = ""
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    func load(with json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.image = json["image"].stringValue
        self.shareURLString = json["share_url"].stringValue
        
        self.body = json["body"].stringValue
    }
    
    var shareURL: URL? {
        return URL(string: shareURLString)
    }
}
