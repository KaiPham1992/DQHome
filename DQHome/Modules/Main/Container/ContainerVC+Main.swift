//
//  ContainerVC+extension.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

//--- MARK: Help Main
extension ContainerViewController {
    
    
    func removeViewController(controller: UIViewController) {
        controller.willMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
    
    @objc func rootViewTapped() {
        hideMenu()
    }
    
    func addTapGesture() {
        self.vBlack.addGestureRecognizer(tapGesture)
    }
    
    func removeTapGesture() {
        self.vBlack.removeGestureRecognizer(tapGesture)
    }
    
    @objc func btnLeftTapped(sender: UIButton) {
        showMenu()
    }
    
//    @objc func btnRightTapped(sender: UIButton) {
//        let popUp = ListItemPopUp()
//        popUp.showPopUp(listItem: get)
//    }
}

extension ContainerViewController {
    func addFullToMain(controller: UIViewController) {
//        self.btnRightMenu.isHidden = true
//        self.imgRightMenu.isHidden = true
        DispatchQueue.main.async {
            self.vContentMain.subviews.forEach { subView in
                subView.removeFromSuperview()
            }
            
            self.removeViewController(controller: controller)
            self.addChildViewController(controller)
            self.vContainerMain.addSubview(controller.view)
            controller.view.fillSuperview()
            
            controller.viewWillAppear(true)
            controller.didMove(toParentViewController: self)
            controller.viewWillAppear(true)
        }
    }
    
    func addSmallToMain(controller: UIViewController) {
        // remove room view
//        self.btnRightMenu.isHidden = false
//        self.imgRightMenu.isHidden = false
        removeViewController(controller: vcRoomView)
        //--
        vContentMain.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
        
        removeViewController(controller: controller)
        addChildViewController(controller)
        vContentMain.addSubview(controller.view)
        controller.view.fillSuperview()
        
        controller.viewWillAppear(true)
        controller.didMove(toParentViewController: self)
        controller.viewWillAppear(true)
    }
}


