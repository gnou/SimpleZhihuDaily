//
//  SRError.swift
//  SimpleZhihuDaily
//
//  Created by Mingyu Cui on 08/03/2017.
//  Copyright © 2017 CuiMingyu. All rights reserved.
//

import Foundation

enum SRError: Error {
    case network(Error)
    case responseJSONObjSerializationFailed
}
