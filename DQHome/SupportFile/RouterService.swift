//
//  RouterService.swift
//  DQHome
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class RouterService {
    static let shared = RouterService()
    
    func goToLoading() {
        self.getWindow().rootViewController = LoadingViewController()
    }
    
    func goToLogin() {
        DispatchQueue.main.async {
            self.getWindow().showFromRight(rootViewController: LoginRouter.createModule())
        }
    }
    
    func goToHome() {
        DispatchQueue.main.async {
            self.getWindow().showFromRight(rootViewController: ContainerViewController())
        }
    }
    
    func goToMain() {
        DispatchQueue.main.async {
            self.getWindow().showFromRight(rootViewController: ContainerViewController())
        }
    }
}

extension RouterService {
    private func getWindow() -> UIWindow {
        guard let window = UIApplication.shared.keyWindow else {
            print("window cannot shared")
            return UIWindow(frame: UIScreen.main.bounds)
        }
        
        return window
    }
}
