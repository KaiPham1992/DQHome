//
//  Group.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/1/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import ObjectMapper

class GroupEntity: BaseEntity {
    var id: Int64?
    var name: String?
    var parentId: Int64?
    var ownerId: String?
    var children = [GroupEntity]()
    
    var listRoomData = [RoomData]()
    
//    var imgUrl: String?
//    var listImageRoom = [ImageRoom]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
        self.name <- map["name"]
        self.parentId <- map["parentId"]
        self.ownerId <- map["ownerId"]
        self.children <- map["children"]
    }
    
//    override init() {
//        super.init()
//        self.name = ""
//    }
    
//    init(name: String?, listImageRoom: [ImageRoom]) {
//        super.init()
//        self.listImageRoom = listImageRoom
//        self.name = name
//    }
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }

}
