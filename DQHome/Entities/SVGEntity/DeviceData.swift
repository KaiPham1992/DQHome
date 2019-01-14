//
//  DeviceData.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/26/18.
//  Copyright © 2018 Engma. All rights reserved.
//

// use read RECT in svg
import XMLMapper

class DeviceData: XMLMappable {
    var nodeName: String!
    
    //--- Frame in SVG
    var x: Float?
    var y: Float?
    var width: Float?
    var height: Float?
    var fillOpacity: String? = "0"
    var stroke: String? = "#000000"
    
    var frameInMobile: CGRect? {
        didSet {
            
            guard let frameInMobile = frameInMobile else { return }
            let scaleX = DataManager.shared.sizeBackground.width / UIScreen.main.bounds.width
            let scaleY = DataManager.shared.sizeBackground.height / UIScreen.main.bounds.height
            
            
            width = Float(frameInMobile.width * scaleX)
            height = Float(frameInMobile.height * scaleY)
            x = Float(frameInMobile.minX * scaleX)
            y = Float(frameInMobile.minY * scaleY)
        }
        
    }
    
    //---
    var type: DeviceType?
    var deviceId: String?
    var name: String?
    var metaData: String? // use for MCE V1
    
    // user for IR
    var devType: String?
    var devModel: String?
    var devMaker: String?
    
    var currentREKey: String {
        let splitName = name&.split(separator: "/")
        if splitName.count > 0 {
            return splitName[0].description
        }
        return ""
    }
    // other index metadata
    var currentIndexRE: String {
        let splitName = currentREKey.split(separator: "_")
        if splitName.count > 1 {
            return splitName[1].description
        }
        return "1"
    }
    
    required init?(map: XMLMap) {
        
    }
    
    init(type: DeviceType?, deviceId: String?, name: String?, metaData: String?) {
        self.deviceId = deviceId
        self.name = name
        self.metaData = metaData
        self.type = type
    }
    
    init(type: DeviceType?, deviceId: String?, name: String?, metaData: String?, devType: String?, devModel: String?, devMaker: String?) {
        self.deviceId = deviceId
        self.name = name
        self.metaData = metaData
        self.type = type
        self.devType = devType
        self.devModel = devModel
        self.devMaker = devMaker
    }
    
    init(frameSvg: CGRect, frameInMobile: CGRect, type: Int, deviceId: String?, name: String?, metaData: String?) {
        self.x = Float(frameSvg.minX)
        self.y = Float(frameSvg.minY)
        self.width = Float(frameSvg.width)
        self.height = Float(frameSvg.height)
        
        self.deviceId = deviceId
        self.name = name
        self.metaData = metaData
        self.frameInMobile = frameInMobile
        
        self.type = DeviceType(rawValue: type)
    }
    
    init(frameInMobile: CGRect, type: Int, deviceId: String?, name: String?, metaData: String?) {
        self.deviceId = deviceId
        self.name = name
        self.metaData = metaData
        self.frameInMobile = frameInMobile
        self.type = DeviceType(rawValue: type)
    }
    
    func mapping(map: XMLMap) {
        self.width <- map.attributes["width"]
        self.height <- map.attributes["height"]
        self.x <- map.attributes["x"]
        self.y <- map.attributes["y"]
        self.fillOpacity <- map.attributes["fill-opacity"]
        self.stroke <- map.attributes["stroke"]
        self.type <- map.attributes["type"]
        self.name <- map.attributes["name"]
        self.deviceId <- map.attributes["deviceId"]
        self.metaData <- map.attributes["metaData"]
        
        self.devType <- map.attributes["devType"]
        self.devModel <- map.attributes["devModel"]
        self.devMaker <- map.attributes["devMaker"]
        
    }
}
