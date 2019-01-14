//
//  TotalResource.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/21/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import ObjectMapper

class TotalResourceEntity: BaseEntity {
    var total = [UInt64]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.total <- map["total"]
    }
    
    var isHaveResource: Bool {
        let filter = total.filter{$0 > 0}
        return filter.count > 0
    }
}
