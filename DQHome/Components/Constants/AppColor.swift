//
//  AppColor.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

struct AppColor {
    static let red = UIColor(hexString: "ea2127") //ea2127 //ec1c24
    static let loadGif = UIColor(hexString: "de3629")
    static let white = UIColor.white
    static let placeHolderWhite = UIColor.white.withAlphaComponent(0.7)
    static let gray = UIColor(hexString: "4d4d4d")
    static let clear = UIColor.clear
    static let backgroundMenu = UIColor.black.withAlphaComponent(0.8)
    static let backgroundItem = UIColor.black.withAlphaComponent(0.5)
    static let line = UIColor.black.withAlphaComponent(0.5)
    static let yellow = UIColor.yellow
    
    static let baseColors: [UIColor] = [.red, .green, .blue, .yellow, UIColor(hexString: "00ffff"), UIColor(hexString: "ff00ff") , UIColor.white]
}
