//
//  AppDelegate.swift
//  DQHome
//
//  Created by Ngoc Duong on 10/15/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loginViewController: LoginViewController?
    var navigationController: UINavigationController?
    var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        CognitoService.shared.clearSession()
        configurePushNotification(application: application)
        LanguageHelper.setAppleLAnguageTo(lang: .vietname)
        // AWS
        configAWS()
        setUpWindow()
        
        //
        UIApplication.shared.isStatusBarHidden = true
        IQKeyboardManager.shared.enable = true
        
        RouterService.shared.goToLoading()
        return true
    }
    
    private func setUpWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }
    
}
