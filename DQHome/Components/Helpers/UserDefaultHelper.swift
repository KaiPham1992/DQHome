//
//  UserDefaultHelper.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation

enum UserDefaultHelperKey: String {
    case userName = "UserName"
    case userNameControl = "UserNameControl"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    
    let userDefaultManager = UserDefaults.standard
    
    func save(value: Any?, key: UserDefaultHelperKey) {
        userDefaultManager.set(value, forKey: key.rawValue)
        userDefaultManager.synchronize()
    }
    
    func save(value: Any?, key: String) {
        userDefaultManager.set(value, forKey: key)
        userDefaultManager.synchronize()
    }
    
    func get(key: String) -> Any? {
        return userDefaultManager.object(forKey: key)
    }
    
    func get(key: UserDefaultHelperKey) -> Any? {
        return userDefaultManager.object(forKey: key.rawValue)
    }
    
    
    func saveTimeStamp(groupId: Int64, slot: Int, timeStamp: UInt64) {
        let fileName = "\(groupId)_\(slot)"
        userDefaultManager.set(timeStamp, forKey: fileName)
    }
    
    func getTimstampResouceChanged(groupId: Int64, slot: Int)  -> UInt64 {
        let fileName = "\(groupId)_\(slot)"
        guard let timeStamp = get(key: fileName) as? UInt64 else { return 0}
        return timeStamp
    }
    
    
}
