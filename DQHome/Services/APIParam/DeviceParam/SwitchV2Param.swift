//
//  File.swift
//  DQHome
//
//  Created by Kai Pham on 1/10/19.
//  Copyright © 2019 Engma. All rights reserved.
//

import ObjectMapper
//{
//    "json_version": "0001",
//    "id": "XX01",
//    "cmd": "set",
//    "param": [
//    {
//    "type": "int",
//    "sw[x]": "0|1"
//    }
//    ],
//    "refid": "<max 32 character code>",
//    "timestamp": <seconds since epoch, int64>
//}

class SwitchV2Param: BaseParam {
    var jsonVersion: String?
    var id: String?
    var cmd: String?
    var refid: String?
    var timestamp: Int64?
    var param = [SwitchSubParam]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.jsonVersion <- map["json_version"]
        self.id <- map["id"]
        self.cmd <- map["cmd"]
        self.timestamp <- map["timestamp"]
        self.param <- map["param"]
    }
    
    convenience init(id: String?, index: String, isOn: Int) {
        self.init()
        self.jsonVersion = Constants.jsonVersion
        self.id = id
        self.cmd = "set"
        self.timestamp = Date().millisecondsSince1970
        
        let subParam = SwitchSubParam(index: index, isOn: isOn)
        self.param.append(subParam)
    }
    
}

class SwitchSubParam: BaseParam {
    var type: String = "int"
    var index: String = "1" // 1 2 3 4
    var isOn: Int = 0 // 0 or 1
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.isOn <- map["sw\(index)"]
        self.type <- map["type"]
    }
    
    convenience init(index: String, isOn: Int) {
        self.init()
        self.index = (Int(index)! + 1).description
        self.isOn = isOn
    }
}
