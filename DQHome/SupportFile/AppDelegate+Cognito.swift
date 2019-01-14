//
//  AppDelegate+extension.swift
//  DQHome
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

// MARK: AWS
extension AppDelegate: AWSCognitoIdentityInteractiveAuthenticationDelegate {
    
    func configAWS() {
        
        // setup logging
        AWSDDLog.sharedInstance.logLevel = AWSDDLogLevel.verbose
        
        // setup service configuration
        let serviceConfiguration = AWSServiceConfiguration(region: Constants.CognitoIdentityUserPoolRegion, credentialsProvider: nil)
        
        // create pool configuration
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: Constants.CognitoIdentityUserPoolAppClientId, clientSecret: nil, poolId: Constants.CognitoIdentityUserPoolId)
        
        // initialize user pool client
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey: Constants.AWSCognitoUserPoolsSignInProviderKey)
        
        CognitoService.shared.pool = AWSCognitoIdentityUserPool(forKey: Constants.AWSCognitoUserPoolsSignInProviderKey)
        CognitoService.shared.pool?.delegate = self
    }
    
    
    func startPasswordAuthentication() -> AWSCognitoIdentityPasswordAuthentication {
        print("startPasswordAuthentication")
        
        if loginViewController == nil {
            loginViewController = LoginRouter.createModule()
        }
        
        if CognitoService.shared.isLogin {
            window?.showFromRight(rootViewController: loginViewController!)
        } else {
            // logout
            window?.showFromLeft(rootViewController: loginViewController!)
        }
        
        return loginViewController!
    }
    
    func startRememberDevice() -> AWSCognitoIdentityRememberDevice {
        return self
    }
    
}

extension AppDelegate: AWSCognitoIdentityRememberDevice {
    func getRememberDevice(_ rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>) {
        DispatchQueue.main.async {
            // dismiss the view controller being present before asking to remember device
            self.window?.rootViewController!.presentedViewController?.dismiss(animated: true, completion: nil)
            let alertController = UIAlertController(title: "Remember Device",
                                                    message: "Do you want to remember this device?.",
                                                    preferredStyle: .actionSheet)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.rememberDeviceCompletionSource?.set(result: true)
            })
            let noAction = UIAlertAction(title: "No", style: .default, handler: { (action) in
                self.rememberDeviceCompletionSource?.set(result: false)
            })
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as NSError? {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                DispatchQueue.main.async {
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}
