//
//  FileManagerHelper.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/7/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import CommonCrypto

let resoucesFolder = FileManagerHelper.getDocumentsDirectory()

class FileManagerHelper {
    static func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return path
    }
    
    static func sizeForLocalFilePath(filePath: String) -> UInt64 {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: filePath)
            if let fileSize = fileAttributes[FileAttributeKey.size]  {
                return (fileSize as! NSNumber).uint64Value
            } else {
                print("Failed to get a size attribute from path: \(filePath)")
            }
        } catch {
            print("Failed to get file attributes for local path: \(filePath) with error: \(error)")
        }
        return 0
    }
    
    static func createFile(fileName: String, type: String = "svg") {
        let path = resoucesFolder.appendingPathComponent("\(fileName).\(type)").path
        do {
            if !FileManager.default.fileExists(atPath: path) {
                try! FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func writeFile(text: String, fileName: String, type: String = "svg") {
        let path = resoucesFolder.appendingPathComponent("\(fileName).\(type)")
        print(path.absoluteString)
        
        do {
            try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func readFile(fileName: String, type: String = "svg") -> String? {
        let path = resoucesFolder.appendingPathComponent("\(fileName).\(type)")
        print(path.absoluteString)
        do {
            let text = try String(contentsOf: path, encoding: String.Encoding.utf8)
            return text//.fromBase64()
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// user private for Group svg
extension FileManagerHelper {
    static func writeFileForGroup(text: String, groupId: Int64, slot: Int, timeStamp: UInt64) {
        let fileName = "\(groupId)_\(slot)"
        FileManagerHelper.createFile(fileName: fileName)
        FileManagerHelper.writeFile(text: text, fileName: fileName)
        UserDefaultHelper.shared.saveTimeStamp(groupId: groupId, slot: slot, timeStamp: timeStamp)
    }
    
    static func readFileForGroup( groupId: Int64, slot: Int) -> String? {
        let fileName = "\(groupId)_\(slot)"
        return FileManagerHelper.readFile(fileName: fileName)
    }
    
    static func isExistFile(groupId: Int64, slot: Int, type: String = "svg") -> Bool {
        let fileName = "\(groupId)_\(slot)"
        let path = resoucesFolder.appendingPathComponent("\(fileName).\(type)").path
        
        return FileManager.default.fileExists(atPath: path)
    }
    
    static func writeSvgFromRoomData(roomData: RoomData, fileName: String, type: String = "svg") {
        let path = resoucesFolder.appendingPathComponent("\(fileName).\(type)")
        print(path.absoluteString)
        let newText = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n\(roomData.toXMLString()&)"
        do {
            try newText.write(to: path, atomically: false, encoding: String.Encoding.utf8)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


extension FileManagerHelper {
    
    static func md5Base64(fileName: String) -> String {
        let string = FileManagerHelper.readFile(fileName: fileName)!
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
       return digestData.base64EncodedString()
        
    }
}
