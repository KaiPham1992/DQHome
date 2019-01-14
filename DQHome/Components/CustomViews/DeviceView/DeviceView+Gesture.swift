//
//  DeviceView+Gesture.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/3/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

protocol DeviceViewDelegate: class {
    func moveDeviceView(deviceView: DeviceView, pangesture: UIPanGestureRecognizer)
}

extension DeviceView {
    
    // addLongGesture
    func addLongGesture() {
        longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
        btnAction.addGestureRecognizer(longGesture)
    }
    
    @objc func handleLongGesture(sender : UIGestureRecognizer) {
        if sender.state == .began {
            let popUp = EditRoomPopUp()
            popUp.delegate = self
            popUp.showPopUp(width: 400, height: 250, type: .zoomOut)
        }
    }
    
    // Pan gesture
    func addPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer))
        btnAction.addGestureRecognizer(panGesture)
    }
    
    func removePanGesture() {
        btnAction.removeGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGestureRecognizer(sender: UIPanGestureRecognizer) {
        delegate?.moveDeviceView(deviceView: self, pangesture: sender)
    }
    
}
