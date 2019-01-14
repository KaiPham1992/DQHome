//
//  APolloDevice.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import ObjectMapper

class APolloDevice: BaseEntity {
    var state: ApolloState?
    var currentTimeStamp: Int64?
    var metaData: APolloMeta?
    var version: Int64?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.state <- map["state"]
        self.currentTimeStamp <- map["timestamp"]
        self.version <- map["version"]
        self.metaData <- map["metadata"]
    }
    
    var isOnline: Bool {
        if let _currentTimestamp = currentTimeStamp {
            return _currentTimestamp > 0
        }
        return false
    }
}

class APolloMeta: BaseEntity {
    
}

class ApolloState: BaseEntity {
    var reported: ApolloStateReport?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.reported <- map["reported"]
    }
    
}

class ApolloStateReport: BaseEntity {
    var jsonVersion: String?
    var rgbw: String?
    var r: Int?
    var g: Int?
    var b: Int?
    var w: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.jsonVersion <- map["json_version"]
        self.rgbw <- map["rgbw"]
        self.r <- map["r"]
        self.g <- map["g"]
        self.b <- map["b"]
        self.w <- map["w"]
    }
    
    var color: UIColor {
        guard let r = r, let g = g, let b = b else { return UIColor.clear}
        
        return UIColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: 1)
    }
}
