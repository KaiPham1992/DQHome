//
//  ApolloParam.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import ObjectMapper

class ApolloParam: BaseParam {
    var jsonVersion: String?
    var cmd: String?
    var param = [SubApolloParam]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.jsonVersion <- map["json_version"]
        self.cmd <- map["cmd"]
        self.param <- map["param"]
    }
    
    init(jsonVersion: String, id: String, r: Int, g: Int, b: Int, cmd: String = "set") {
        super.init()
        self.jsonVersion = jsonVersion
        self.cmd = cmd
        let newSubParam = SubApolloParam(id: id, r: r, g: g, b: b)
        
        param.append(newSubParam)
    }
    
    init(jsonVersion: String, id: String, r: Int, g: Int, b: Int, w: Int, cmd: String = "set") {
        super.init()
        self.jsonVersion = jsonVersion
        self.cmd = cmd
        let newSubParam = SubApolloParam(id: id, r: r, g: g, b: b, w: w)
        
        param.append(newSubParam)
    }
    
    init(jsonVersion: String, id: String, w: Int, cmd: String = "set") {
        super.init()
        self.jsonVersion = jsonVersion
        self.cmd = cmd
        let newSubParam = SubApolloParam(id: id, w: w)
        
        param.append(newSubParam)
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
}

//
class SubApolloParam: BaseParam {
    var id: String?
    var type: String?
    var r: Int?
    var g: Int?
    var b: Int?
    var w: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
        self.type <- map["type"]
        self.r <- map["r"]
        self.g <- map["g"]
        self.b <- map["b"]
        self.w <- map["w"]
    }
    
    init(id: String, r: Int, g: Int, b: Int) {
        super.init()
        self.id = id
        self.type = "int"
        self.r = r
        self.g = g
        self.b = b
        
        if r != 0 || g != 0 || b != 0 {
            w = 0
        } else {
            w = 255
        }
    }
    
    init(id: String, r: Int, g: Int, b: Int, w: Int) {
        super.init()
        self.id = id
        self.type = "int"
        self.r = r
        self.g = g
        self.b = b
        self.w = w
    }
    
    init(id: String, w: Int) {
        super.init()
        self.id = id
        self.w = w
        if w != 0 {
            self.r = 0
            self.g = 0
            self.b = 0
        }
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
