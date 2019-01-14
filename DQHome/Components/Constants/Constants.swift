//
//  Constant.swift
//  DQHome
//
//  Created by Ngoc Duong on 10/16/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import AWSCognitoIdentityProvider

struct Constants {
    
    //
    static let CognitoIdentityUserPoolRegion: AWSRegionType = .APSoutheast1
    static let CognitoIdentityUserPoolId = "ap-southeast-1_040c45HXG"
    static let CognitoIdentityUserPoolAppClientId = "st96k1fennl56ml69btac9qrk"
    
    static let AWSCognitoUserPoolsSignInProviderKey = "UserPool"
    
    
    // Notification
    static let dataDownloadCompleted = Notification.Name(rawValue: "dataDownloadCompleted")
    static let LoginAgain = Notification.Name(rawValue: "LoginAgain")
    static let EditRoomView = Notification.Name(rawValue: "EditRoomView")
    
    static let jsonVersion = "0001"

}
