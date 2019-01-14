//
//  Scene.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/1/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import ObjectMapper

class SceneEntity: BaseEntity {
    var name: String?
    var timeStamp: UInt64?
    var owner: String?
    var desc: String?
    var id: String?
    var content = [ContentSceneEntity]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        timeStamp <- map["timestamp"]
        owner <- map["owner"]
        desc <- map["desc"]
        id <- map["id"]
        content <- map["content"]
    }
}

class ContentSceneEntity: BaseEntity {
    var groupId: String?
    var deviceId: String?
    var requestId: String?
    var categories = [Int]()
    var timestamp: UInt64?
    var command: [String: Any]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.groupId <- map["groupId"]
        self.deviceId <- map["deviceId"]
        self.requestId <- map["requestId"]
        self.categories <- map["categories"]
        self.command <- map["command"]
    }
}
