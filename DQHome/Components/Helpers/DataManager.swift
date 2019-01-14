//
//  DataManager.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/29/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class DataManager {
    static let shared = DataManager()
    
    var isEditRoom = false
    var sizeBackground = UIScreen.main.bounds.size
    
    let deviceByGroup = [String: [DeviceData]]()
    
}
