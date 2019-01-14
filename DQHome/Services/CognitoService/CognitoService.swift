//
//  CognitoService.swift
//  DQHome
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

class CognitoService: NSObject {
    static let shared = CognitoService()
    
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    
    var isLogin = true
    
    func logoutUser() {
        isLogin = false
        self.user?.signOut()
        self.refreshUser()
    }
    
    var token: String {
        guard let _token = pool?.token().result else { return "" }
        if _token.description.isEmpty {
            print("TOKEN EXPIRE")
            self.refreshUser()
            
            guard let _token = pool?.token().result else { return "" }
            return _token as String
        }
        return _token as String
    }
    
    func clearSession() {
        self.user?.clearSession()
    }
    
    func refreshUser() {
        user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            return nil
        }
        
//        user?.getSession().continueOnSuccessWith(block: { task -> Any? in
//            guard let _token = self.pool?.token().result else { return "" }
//            return nil
//        })
    }
}
