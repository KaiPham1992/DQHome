//
//  DeviceStatus.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/25/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import ObjectMapper


class MCEDevice: BaseEntity {
    var state: MCEState?
    var currentTimeStamp: Int64?
    var metaData: MCEMetaData?
    var version: Int64?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.state <- map["state"]
        self.currentTimeStamp <- map["timestamp"]
        self.version <- map["version"]
        self.metaData <- map["metadata"]
    }
    
    var mecId: String? {
        return self.state?.reported?.mceId
    }
    
    // Key (RE4_1, )
    func valueStatusMCE(reKey: String) -> String {
        var  curentREStatus = "" //ON:XX:XX:XX
        if let listRe = state?.reported?.listRE {
            for re in listRe {
                if re.reKey == reKey {
                    curentREStatus = re.reValue&
                }
            }
        }
        
        return curentREStatus
    }
    
    var isOnline: Bool {
        // FIX ME
        if let _currentTimestamp = currentTimeStamp, let _lastesTimestamp =  metaData?.reported?.mceId?.timestamp {
            print("Time stamp is online : \(_currentTimestamp - _lastesTimestamp)")
            return (_currentTimestamp - _lastesTimestamp) <= 15
        }
        return false
    }
}

/************************** STATE *****************************/
// MARK:
class MCEState: BaseEntity {
    var reported: MECReported?
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.reported <- map["reported"]
    }
}

// MARK:
class MECReported: BaseEntity {
//    var re41: String?
//    var re42: String?
//    var re43: String?
//    var re44: String?
//    var re45: String?
//    var re46: String?
    
    var listRE = [REEntity]()
    var mceId: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.mceId <- map["mce_id"]
        
        for (key, value) in map.JSON {
            if key.contains("RE") {
                let newRE = REEntity(key: key, value: value as? String)
                listRE.append(newRE)
            }
        }
        
    }
}

class REEntity: BaseEntity {
    var reKey: String?
    var reValue: String?
    
    convenience init(key: String?, value: String?) {
        self.init()
        self.reKey = key
        self.reValue = value
    }
}
/************************** METADATA *****************************/
// MARK:
class MCEMetaData: BaseEntity {
    var reported: MCEMetaReported?
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.reported <- map["reported"]
    }
}


// MARK:
class MCEMetaReported: BaseEntity {
    var mceId: MCEId?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.mceId <- map["mce_id"]
    }
}


class MCEId: BaseEntity {
    var timestamp: Int64?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.timestamp <- map["timestamp"]
    }
}
