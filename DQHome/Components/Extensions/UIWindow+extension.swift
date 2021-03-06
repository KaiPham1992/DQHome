//
//  UIWindow+extension.swift
//  DQHome
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func showFromRight(rootViewController: UIViewController) {
        show(rootViewController: rootViewController, animated: true, animationType: kCATransitionFromRight)
    }
    
    func showFromLeft(rootViewController: UIViewController) {
        show(rootViewController: rootViewController, animated: true, animationType: kCATransitionFromLeft)
    }
    
    func showFromBottom(rootViewController: UIViewController) {
        show(rootViewController: rootViewController, animated: true, animationType: kCATransitionFromBottom)
    }
    
    func showFromTop(rootViewController: UIViewController) {
        show(rootViewController: rootViewController, animated: true, animationType: kCATransitionFromTop)
    }
    
    private func show(rootViewController: UIViewController, animated: Bool, animationType: String = kCATransitionFromRight) {
        
        DispatchQueue.main.async {
//            if animated {
//                let animation               = CATransition()
//                animation.timingFunction    = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//                animation.type              = kCATransitionPush
//                animation.subtype           = animationType
//                animation.duration          = 0.4
//                self.layer.add(animation, forKey: "transitionViewAnimation")
//            } else {
//                self.layer.removeAllAnimations()
//            }
            self.rootViewController = rootViewController
            self.makeKeyAndVisible()
        }
    }
}
