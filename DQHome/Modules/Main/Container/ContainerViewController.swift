//
//  ContainerViewController.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation

import UIKit

class ContainerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    let imgBackGround: UIImageView = {
        let img = UIImageView()
        img.image = AppImage.imgBackground
        
        return img
    }()
    
    // Main
    let vContainerMain: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let vContentMain: UIView = {
        let view = UIView()
        return view
    }()
    
    let lbRoomName: AppLabel = {
        let lb = AppLabel()
        lb.textColor = AppColor.white
        lb.backgroundColor = AppColor.backgroundItem
        return lb
    }()
    
    // Menu
    
    let vContentMenu: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let vBottomAction: UIView = {
        let v = UIView()
        
        return v
    }()
    
    lazy var btnLeftMenu: UIButton = {
        let v = UIButton()
        v.tag = 1992
        v.addTarget(self, action: #selector(btnLeftTapped), for: .touchUpInside)
        
        return v
    }()
    
    let imgLeftMenu: UIImageView = {
        let img = UIImageView()
        img.image = AppImage.imgMenuIcon
        
        return img
    }()
    
//    lazy var btnRightMenu: UIButton = {
//        let v = UIButton()
//        v.addTarget(self, action: #selector(btnRightTapped), for: .touchUpInside)
//
//        return v
//    }()
    
//    let imgRightMenu: UIImageView = {
//        let img = UIImageView()
//        img.image = AppImage.imgSetting
//
//        return img
//    }()
    
    //---
    let vcHome      = HomeRouter.createModule()
    let vcListRoom      = ListGroupRouter.createModule()
    let vcListScene      = ListSceneRouter.createModule()
    let vcLeftMenu      = LeftMenuRouter.createModule()
    let vcRightMenu      = RightMenuRouter.createModule()
    var vcRoomView      = RoomViewController.initFrom(storyboardName: ConstantStoryboard.main)
    var isLeftMenu = true
    
    //---
    var widthMenuConstraint: NSLayoutConstraint?
    var widthMenu: CGFloat = 0
    
    var minXContent: CGFloat = 50
    
    var tapGesture      : UITapGestureRecognizer!
    var currentController: UIViewController!
    
    let vBlack: UIView = {
        let view = UIView()
        
        return view
    }()
    
    func setUpViews() {
        
        //-- Main
        view.addSubview(vContainerMain)
        vContainerMain.fillSuperview()
        vContainerMain.addSubview(imgBackGround)
        imgBackGround.fillSuperview()
        
        vContainerMain.addSubview(vContentMain)
        vContentMain.anchor(vContainerMain.topAnchor, bottom: vContainerMain.bottomAnchor, topConstant: 10, bottomConstant: 50)
        vContentMain.widthAnchor.constraint(equalTo: vContainerMain.widthAnchor, multiplier: 680/1000, constant: 0).isActive = true
        
        vContentMain.leftAnchor.constraint(equalTo: vContainerMain.leftAnchor, constant: minXContent).isActive = true
        
        //-- Menu
        view.addSubview(vContentMenu)
        vContentMenu.fillSuperview()
        
        //-- bottom Action
        view.addSubview(vBottomAction)
        vBottomAction.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, leftConstant: 0, bottomConstant: 0, rightConstant: 150, heightConstant: 40)
        
        //--
        vBottomAction.addSubview(imgLeftMenu)
//        vBottomAction.addSubview(imgRightMenu)
        vBottomAction.addSubview(btnLeftMenu)
//        vBottomAction.addSubview(btnRightMenu)
        btnLeftMenu.anchor(vBottomAction.topAnchor, left: vBottomAction.leftAnchor, bottom: vBottomAction.bottomAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, widthConstant: 40, heightConstant: 40)
//        btnRightMenu.anchor(vBottomAction.topAnchor, bottom: vBottomAction.bottomAnchor, right: vBottomAction.rightAnchor, topConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        imgLeftMenu.centerToView(view: btnLeftMenu)
        imgLeftMenu.anchor(widthConstant: 30, heightConstant: 30)
//        imgRightMenu.centerToView(view: btnRightMenu)
//        imgRightMenu.anchor(widthConstant: 30, heightConstant: 30)
        
        //--
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(rootViewTapped))
        addSmallToMain(controller: self.vcListRoom)
        addBlackView()
        addMenuViewController(vcMenu: vcRightMenu)
        addMenuViewController(vcMenu: vcLeftMenu)
        
        // DELEGATE
        vcHome.delegate = self
        vcLeftMenu.delegate = self
        vcListRoom.delegate = self
    }
}

extension ContainerViewController: HomeViewControllerDelegate, ListGroupViewControllerDelegate {
    func itemGroupSelected(items: [Any], floor: Int, room: Int) {
        self.vcRoomView.showRoom(listRoom: items, floor: floor, room: room)
        addFullToMain(controller: self.vcRoomView)
    }
    
    func itemHomeSelected(items: [Any], index: Int) {
        // go to room view
        addFullToMain(controller: self.vcRoomView)
    }
}
