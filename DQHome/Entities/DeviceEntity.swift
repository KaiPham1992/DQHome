//
//  DeviceEntity.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/17/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import ObjectMapper


// use when call api get device 
class DeviceEntity: BaseEntity {
    var id: String?
    var ownerId: String?
    var category: Int = 0
    var name: String?
    var groups = [UInt64]()
    var metaData: DeviceMetadata?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.id <- map["id"]
        self.ownerId <- map["ownerId"]
        self.category <- map["category"]
        self.name <- map["name"]
        self.groups <- map["group"]
        
        self.metaData <- map["metadata"]
    }
    
    // use MCE
    func toListDeviceData() -> [DeviceData] {
        var listDeviceData = [DeviceData]()
        // MCE
        if let subDevices = self.metaData?.subDevices {
            
            for (index, value) in subDevices.enumerated() {
                
                for aliaseIndex in 0...value.aliases.count - 1 {
                    let name = value.subDeviceId&.isEmpty ? "\(value.aliases[aliaseIndex])": "\(value.subDeviceId&)/\(value.aliases[aliaseIndex])"
                    
                    // IR
                    if category == 8 {
                        let deviceData = DeviceData(type: DeviceType(rawValue: category), deviceId: id&, name: name, metaData: nil, devType: value.devType&, devModel: value.devModel&, devMaker: value.devMaker&)
                            
                            //DeviceData(type: DeviceType(rawValue: category), deviceId: id&, name: name, metaData: value.toJSONString()&.toBase64()&)
                        
                        listDeviceData.append(deviceData)
                    } else {
                        let deviceData = DeviceData(type: DeviceType(rawValue: category), deviceId: id&, name: name, metaData: aliaseIndex.description)
                        
                        listDeviceData.append(deviceData)
                    }
                    
                    
                }
            }
            // not MCE
        } else {
            let deviceData = DeviceData(type: DeviceType(rawValue: category), deviceId: id&, name: name&, metaData: nil)
            listDeviceData.append(deviceData)
        }
        return listDeviceData
    }
    
}

//---
class DeviceMetadata: BaseEntity {
    var subDevices = [SubDevice]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.subDevices <- map["subDevices"]
    }
}

//---
class SubDevice: BaseEntity {
    var subDeviceId: String?
    var aliases = [String]()
    
    //---
    var devMaker: String?
    var devType: String?
    var devModel: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.subDeviceId <- map["subDeviceId"]
        self.aliases <- map["aliases"]
        self.devMaker <- map["devMaker"]
        self.devType <- map["devType"]
        self.devModel <- map["devModel"]
    }
}
