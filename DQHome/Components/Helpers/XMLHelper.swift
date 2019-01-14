//
//  XMLHelper.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/24/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class XMLHelper: NSObject {
    
    static let shared = XMLHelper()
    
    var xmlParser: XMLParser!
    var frameScreen: CGRect = CGRect(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.minY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 9/16)
    var frameSvg: CGRect = CGRect.zero
    
    var roomData: RoomData?
    
    func startParsingFileFromURL(url: URL) {
        roomData = RoomData()
        self.xmlParser = XMLParser(contentsOf: url)
        self.xmlParser.delegate = self
        if !self.xmlParser.parse() {
            print("Can not open file!: \(url)")
        }
    }
    
    func scaleX() -> CGFloat {
        let scaleWidth = frameScreen.width / frameSvg.width
        return scaleWidth
    }
    
    func scaleY() -> CGFloat {
        let scaleHeight = frameScreen.height / frameSvg.height
        return scaleHeight
    }
}

extension XMLHelper: XMLParserDelegate {
    // start document
    func parserDidStartDocument(_ parser: XMLParser) {
        //        print("parserDidStartDocument: \(parser.description)")
    }
    
    // start element <key>
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        let deviceId = attributeDict["deviceId"]&
        let name = attributeDict["name"]&
        let metaData = attributeDict["metaData"]&
        let type = attributeDict["type"]&.toDouble()
        
        
        if elementName == "svg" {
            guard let tempSplit =  attributeDict["viewBox"]?.split(separator: " ") else { return }
            
            if tempSplit.count >= 4 {
                self.frameSvg = CGRect(x: tempSplit[0].description.toDouble(),
                                       y: tempSplit[1].description.toDouble(),
                                       width: tempSplit[2].description.toDouble(),
                                       height: tempSplit[3].description.toDouble())
                
                
            }
        }
        
        if elementName == "rect" {
            let x = attributeDict["x"]&.toDouble() * Double(scaleX())
            let y = attributeDict["y"]&.toDouble() * Double(scaleY())
            let width = attributeDict["width"]&.toDouble() * Double(scaleX())
            let height = attributeDict["height"]&.toDouble() * Double(scaleY())
            
            
            let frameSvg = CGRect(x: attributeDict["x"]&.toDouble(), y: attributeDict["y"]&.toDouble(), width: attributeDict["width"]&.toDouble(), height: attributeDict["height"]&.toDouble())
            let frameInMobile = CGRect(x: x, y: y, width: width, height: height)
            let newDeviceData = DeviceData(frameSvg: frameSvg, frameInMobile: frameInMobile, type: Int(type), deviceId: deviceId, name: name, metaData: metaData)
            // use for IR
            newDeviceData.devModel = attributeDict["devModel"]&
            newDeviceData.devMaker = attributeDict["devMaker"]&
            newDeviceData.devType = attributeDict["devType"]&
            
            self.roomData?.svg?.addDevice(device: newDeviceData)
        }
        
        // read image
        //&& attributeDict["id"] == "background"
        if elementName == "image" {
            let base64Image = attributeDict["xlink:href"]&.removeTextInBase64()
            if let _image = base64Image.toUIImage() {
                 self.roomData?.svg?.setUpImage(image: _image)
            }
        }
    }
    
    // found value of element <key>value</key>
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //        print("foundCharacters")
    }
    
    // end element </key>
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //        print("didEndElement")
    }
    
    // end document
    func parserDidEndDocument(_ parser: XMLParser) {
        //        print("parserDidEndDocument")
    }
}

// MARK: read background
extension XMLHelper {
    
}
