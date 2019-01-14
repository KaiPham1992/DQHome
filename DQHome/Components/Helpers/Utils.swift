//
//  Utils.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class Utils {
    class func estimateHeight(_ width: CGFloat, customFont: UIFont, str: String) -> CGFloat {
        let size = CGSize(width: width, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: customFont], context: nil)
        return estimateFrame.height
    }
    
    class func estimateWidth(_ height: CGFloat, customFont: UIFont, str: String) -> CGFloat{
        let size = CGSize(width: 1000, height: height)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: customFont], context: nil)
        return estimateFrame.width
    }
}

extension Utils {
    class func toSVGDocument(fileName: String) -> URL? {
        let newFileName = "\(fileName).svg"
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return path.appendingPathComponent(newFileName)
    }
    

}
