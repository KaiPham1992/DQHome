//
//  RoomData.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/26/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import XMLMapper

class RoomData: XMLMappable {
    var nodeName: String!
    var svg: SvgData?
    
    required init?(map: XMLMap) {
        
    }
    
    init(){
        self.svg = SvgData()
    }
    
    func mapping(map: XMLMap) {
        svg <- map["svg"]
    }
    
    init(svg: SvgData?) {
        self.svg = svg
    }
    
    init(fileName: String) {
        let xmlHelper = XMLHelper()
        
        if let url = Utils.toSVGDocument(fileName: fileName&) {
            print("read: \(fileName)")
            xmlHelper.startParsingFileFromURL(url: url)
            print("End: \(fileName)")
        }
        self.svg = xmlHelper.roomData?.svg
        
        //        if fileName& == "2037425735236075521_1" {
        //            if let url = Utils.toSVGDocument(fileName: fileName&) {
        //                xmlHelper.startParsingFileFromURL(url: url)
        //            }
        //            self.svg = xmlHelper.roomData?.svg
        //            print("End: \(fileName)")
        //        }
        
    }
    
    func getBackground() -> UIImage? {
        return svg?.image?.image
        
    }
}



