//
//  AppString.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
struct AppString {
    struct Title {
        static let vietNamese = "VietNamese"
        static let english = "English"
        static let admin = "Admin"
        static let userNamePlaceHolder = "UserNamePlaceHolder"
        static let userNameControlPlaceHolder = "UserNameControlPlaceHolder"
        static let password = "Password"
        static let savePassword = "SavePassword"
        static let notification = "Notification"
        static let login = "Login"
        static let forgotPassword = "ForgotPassword"
        static let accept = "Accept"
        static let tryAgain = "TryAgain"
        static let settingTitle = "SettingTitle"
    }
    
    struct Message {
        static let notAuthorizedException = "NotAuthorizedException"
        static let errorUserNameEmpty = "ErrorUserNameEmpty"
        static let errorUserNameControlEmpty = "ErrorUserNameControlEmpty"
        static let errorPasswordEmpty = "ErrorPasswordEmpty"
        
        static let sendSignalSuccess = "SendSignalSuccess"
        static let sendSignalFailed = "SendSignalFailed"
        static let deviceOffline = "DeviceOffline"
        static let notYetSetUpGroup = "NotYetSetUpGroup"
    }
    
    struct Loading {
        static let loadingDefault = "LoadingDefault"
        static let sendSignal = "SendSignal"
        static let login = "LoginLoading"
        static let getScenes = "GetScenes"
        static let getRooms = "GetRooms"
        static let getRoomInfo = "GetRoomInfo"
        static let downloadInfoRoom = "DownloadInfoRoom"
        static let saveData = "SaveData"
    }
}
