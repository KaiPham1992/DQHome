//
//  CurtainEntity.swift
//  DQHome
//
//  Created by Kai Pham on 1/11/19.
//  Copyright © 2019 Engma. All rights reserved.
//

import ObjectMapper
class CurtainEntity: BaseEntity {
    var state: CurtainState?
    var currentTimeStamp: Int64?
    var metaData: CurtainMetaData?
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
        return report.val*
    }
}

/************************** STATE *****************************/
// MARK:
class CurtainState: BaseEntity {
    var reported: CurtainStateReported?
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.reported <- map["reported"]
    }
}

// MARK:
class CurtainStateReported: BaseEntity {
    var jsonVersion: String?
    var id: String?
    var type: String?
    var level: Int?
    var refid: String?
    var val: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.jsonVersion <- map["json_version"]
        self.id <- map["id"]
        self.type <- map["type"]
        self.refid <- map["refid"]
        self.level <- map["level"]
        self.val <- map["val"]
    }
}
/************************** METADATA *****************************/
//MARK:
class CurtainMetaData: BaseEntity {
//    var reported: SwitchV2MetaReported?
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//        self.reported <- map["reported"]
//    }
}
//
//// MARK:
//class SwitchV2MetaReported: BaseEntity {
//    var mceId: SwitchV2Id?
//
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//        self.mceId <- map["mce_id"]
//    }
//}
//
//
//class SwitchV2Id: BaseEntity {
//    var timestamp: Int64?
//
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//        self.timestamp <- map["timestamp"]
//    }
//}
//
