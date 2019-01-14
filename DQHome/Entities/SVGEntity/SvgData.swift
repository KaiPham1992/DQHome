//
//  SvgData.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/26/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import XMLMapper

class SvgData: XMLMappable {
    var nodeName: String!
    var listDevice = [DeviceData]()
    var image: ImageData?
    
    
    // attribute SVG
    var xmlns: String? = "http://www.w3.org/2000/svg"
    var link: String? = "http://www.w3.org/1999/xlink"
    var xmlSpace: String? = "preserve"
    var viewBox: String?
    var x: String? = "0px"
    var y: String? = "0px"
    
    required init?(map: XMLMap) {
        
    }
    
    init(){}
    
    func mapping(map: XMLMap) {
        // sub element
        image <- map["image"]
        self.listDevice <- map["rect"]
        
        // attribute
        self.xmlns <- map.attributes["xmlns"]
        self.link <- map.attributes["xmlns:xlink"]
        self.xmlSpace <- map.attributes["xml:space"]
        self.viewBox <- map.attributes["viewBox"]
        self.x <- map.attributes["x"]
        self.y <- map.attributes["y"]
    }
    
    func setUpImage(image: UIImage) {
        self.image = ImageData(image: image)
        self.viewBox = "0 0 \(image.size.width) \(image.size.height)"

    }
    
    func setUpDevice(listDevice: [DeviceData]) {
       self.listDevice = listDevice
    }
    
    func addDevice(device: DeviceData) {
        self.listDevice.append(device)
    }

    init(image: UIImage, listDevice: [DeviceData]) {
        self.image = ImageData(image: image)
        self.viewBox = "0 0 \(image.size.width) \(image.size.height)"
        self.listDevice = listDevice
    }
}
