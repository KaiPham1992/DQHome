//
//  ImageData.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/26/18.
//  Copyright © 2018 Engma. All rights reserved.
//


// user read image in svg
import XMLMapper
import UIKit

class ImageData: XMLMappable {
    var nodeName: String!
    
    var width: Float?
    var height: Float?
    var imageBase64: String?
    var id: String?
    
    var image: UIImage?
    
    required init?(map: XMLMap) {
        
    }
    
    init(image: UIImage) {
        self.width = Float(image.size.width)
        self.height = Float(image.size.height)
        let base64 = "data:image/png;base64,\(image.base64(format: ImageFormat.png)&)"
        self.imageBase64 = base64
        self.image = image
        self.id = "background"
    }
    
    func mapping(map: XMLMap) {
        self.width <- map.attributes["width"]
        self.height <- map.attributes["height"]
        self.imageBase64 <- map.attributes["xlink:href"]
        self.id <- map.attributes["id"]
    }
}
