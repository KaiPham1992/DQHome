//
//  LoadingViewController.swift
//  DQHome
//
//  Created by Ngoc Duong on 10/17/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
import SDWebImage

class LoadingViewController: UIViewController {
    
    let imgLoading: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.gifImageWithName(name: "loadscreen")
        img.contentMode = UIViewContentMode.center
        img.backgroundColor = UIColor.clear
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserLogin()
        setUpViews()
    }
    
    func setUpViews() {
        self.view.addSubview(imgLoading)
        imgLoading.fillSuperview()
        self.view.backgroundColor = AppColor.loadGif
    }
    
    func checkUserLogin() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            CognitoService.shared.pool = AWSCognitoIdentityUserPool(forKey: Constants.AWSCognitoUserPoolsSignInProviderKey)
            
            if (CognitoService.shared.user == nil) {
                CognitoService.shared.user = CognitoService.shared.pool?.currentUser()
            }
            
            CognitoService.shared.refreshUser()
            RouterService.shared.goToLogin()
        }
    }
}
