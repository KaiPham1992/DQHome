//
//  ResourceEntity.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/21/18.
//  Copyright © 2018 Engma. All rights reserved.
//
import ObjectMapper

class ResourceEntity: BaseEntity {
    var url: String?
    var timeStamp: UInt64?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.url <- map["url"]
        self.timeStamp <- map["timestamp"]
        self.timeStamp = 0
    }
}
