//
//  DeviceView+Edit.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/3/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

extension DeviceView: EditRoomPopUpDelegate {
    func btnShowControlTapped() {
        guard let type = deviceData?.type else { return }
        if type == .apollo {
            showControlApollo()
        }
       
    }
    
    func btnDeleteTapped() {
        self.removeFromSuperview()
    }
    
    func btnMoveTapped() {
        self.deviceViewAction = .move
        addPanGesture()
    }
    
    func btnChangeSize() {
        self.deviceViewAction = .changeSize
    }
    
    func add4View() {
        removePanGesture()
        let viewTop = UIImageView()
        viewTop.backgroundColor = .red
        let viewRight = UIImageView()
        viewRight.backgroundColor = .green
        
        let viewBottom = UIImageView()
        viewBottom.backgroundColor = .green
        
        let viewLeft = UIImageView()
        viewLeft.backgroundColor = .green
        
        self.addSubview(viewTop)
        self.addSubview(viewRight)
        self.addSubview(viewBottom)
        self.addSubview(viewLeft)
        
        viewTop.centerXToSuperview()
        viewTop.anchor(self.topAnchor, topConstant: 0, rightConstant: 10, widthConstant: 10, heightConstant: 10)
        
        viewBottom.centerXToSuperview()
        viewBottom.anchor(bottom: self.bottomAnchor, bottomConstant: 0, rightConstant: 10, widthConstant: 10, heightConstant: 10)
        viewBottom.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(viewBottomLongPress)))
        
    }
    
    @objc func viewBottomLongPress(pangesture: UIPanGestureRecognizer) {
        var rootFrame = CGRect.zero
        switch pangesture.state {
        case .began:
            rootFrame = self.frame
        case .changed:
            let translation = pangesture.translation(in: self)
            self.frame = CGRect(x: rootFrame.minX, y: rootFrame.minY, width: rootFrame.width, height: rootFrame.height + translation.y)
        default:
            break
        }
        
    }
    
}
