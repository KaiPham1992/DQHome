//
//  CurtainParam.swift
//  DQHome
//
//  Created by Kai Pham on 1/14/19.
//  Copyright © 2019 Engma. All rights reserved.
//

import ObjectMapper

class CurtainParam: BaseParam {
    var jsonVersion: String?
    var id: String?
    var cmd: String?
    var timestamp: Int64?
    var param = [CurtainArrayParam]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.jsonVersion <- map["json_version"]
        self.id <- map["id"]
        self.cmd <- map["cmd"]
        self.param <- map["param"]
        self.timestamp <- map["timestamp"]
    }
    
    convenience init(id: String?, val: Int?) {
        self.init()
        self.jsonVersion = Constants.jsonVersion
        self.cmd = "set"
        self.id = id
        self.timestamp = Date().millisecondsSince1970
        self.param.append(CurtainArrayParam(val: val))
    }
}

class CurtainArrayParam: BaseParam {
    var type: String?
    var val: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.type <- map["type"]
        self.val <- map["val"]
    }
    
    convenience init(val: Int?) {
        self.init()
        self.type = "int"
        self.val = val
    }
}
