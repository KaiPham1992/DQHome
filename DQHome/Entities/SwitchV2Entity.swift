//
//  SwitchV2Entity.swift
//  DQHome
//
//  Created by Kai Pham on 1/10/19.
//  Copyright © 2019 Engma. All rights reserved.
//

// user when call get status switch v2

import ObjectMapper
class SwitchV2Entity: BaseEntity {
    var state: SwitchV2State?
    var currentTimeStamp: Int64?
    var metaData: SwitchV2MetaData?
    var version: Int64?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.state <- map["state"]
        self.currentTimeStamp <- map["timestamp"]
        self.version <- map["version"]
        self.metaData <- map["metadata"]
    }
    var isConnecting: Bool {
        guard let timeStamp = self.currentTimeStamp else { return false }
        return timeStamp > 0
    }
    
    func isOn(index: String) -> Int {
        guard let report = self.state?.reported else { return 0 }
        return report.isOnLight(index: index)
    }
}

/************************** STATE *****************************/
// MARK:
class SwitchV2State: BaseEntity {
    var reported: SwitchV2Reported?
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.reported <- map["reported"]
    }
}

// MARK:
class SwitchV2Reported: BaseEntity {
    var sw1: Int?
    var sw2: Int?
    var sw3: Int?
    var sw4: Int?
    var level: Int?
    var jsonVersion: String?
    var id: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.sw1 <- map["sw1"]
        self.sw2 <- map["sw2"]
        self.sw3 <- map["sw3"]
        self.sw4 <- map["sw4"]
        self.level <- map["level"]
        self.jsonVersion <- map["json_version"]
        self.id <- map["id"]
    }
    
    func isOnLight(index: String) -> Int {
        switch index {
        case "0":
            return self.sw1 == 1 ? 1: 0
        case "1":
            return self.sw2 == 1 ? 1: 0
        case "2":
            return self.sw3 == 1 ? 1: 0
        case "3":
            return self.sw4 == 1 ? 1: 0
        default:
            return 1
        }
    }
}
/************************** METADATA *****************************/
//MARK:
class SwitchV2MetaData: BaseEntity {
    var reported: SwitchV2MetaReported?
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.reported <- map["reported"]
    }
}

// MARK:
class SwitchV2MetaReported: BaseEntity {
    var mceId: SwitchV2Id?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.mceId <- map["mce_id"]
    }
}


class SwitchV2Id: BaseEntity {
    var timestamp: Int64?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.timestamp <- map["timestamp"]
    }
}

