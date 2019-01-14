//
//  FileEntity.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import ObjectMapper

enum FileStatus {
    case New
    case Downloaded
    case Failed
}

class FileEntity: BaseEntity {
    var status = FileStatus.New
    var url: String?
    var text: String?
    
    init(url: String?) {
        super.init()
        self.url = url
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
}
