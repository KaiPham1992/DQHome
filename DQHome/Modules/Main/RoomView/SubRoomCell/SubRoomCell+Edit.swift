//
//  SubRoomCell+Edit.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/29/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

extension SubRoomCell {
//    func addLongGesture() {
//        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
//        self.addGestureRecognizer(longGesture)
//    }
    
//    @objc func handleLongGesture(sender : UIGestureRecognizer) {
//        if sender.state == .began {
//            let position = sender.location(in: self)
//            let popUp = ListItemPopUp()
//            let frameRoot = CGRect(x: position.x, y: position.y, width: 50, height: 50)
//
//            popUp.showPopUp(frame: frameRoot, listItem: getDevice(), completion: { item in
//                guard let deviceData = item as? DeviceData else { return }
//                let newDevice = DeviceView()
//                newDevice.delegate = self
//
//                newDevice.deviceData = deviceData
//                self.addSubview(newDevice)
//
//                // frame device view to add in mobile
//                let newFrame = CGRect(x: frameRoot.minX - frameRoot.width/2, y: frameRoot.minY - frameRoot.height/2, width: frameRoot.width, height: frameRoot.height)
//                newDevice.frame = newFrame
//                deviceData.frameInMobile = newDevice.frame
//
//                self.listDeviceView.append(newDevice)
//            })
//
//        }
//    }
    
    func addNewDevice(deviceData: DeviceData) {
        let newDevice = DeviceView()
        newDevice.delegate = self
        newDevice.deviceData = deviceData
        vContent.addSubview(newDevice)
        newDevice.addPanGesture()
        // frame device view to add in mobile
        let sizeDevice = CGSize(width: 50, height: 50)
        let newFrame = CGRect(x: self.vContent.center.x - sizeDevice.width/2, y: self.vContent.center.y - sizeDevice.height/2, width: sizeDevice.width, height: sizeDevice.height)
        
        newDevice.frame = newFrame
        deviceData.frameInMobile = newDevice.frame
        
//        self.listDeviceView.append(newDevice)

    }
}

extension SubRoomCell: DeviceViewDelegate {
    func moveDeviceView(deviceView: DeviceView, pangesture: UIPanGestureRecognizer) {
        self.bringSubview(toFront: deviceView)
        let translation = pangesture.translation(in: self)
        deviceView.center = CGPoint(x: deviceView.center.x + translation.x, y: deviceView.center.y + translation.y)
        pangesture.setTranslation(CGPoint.zero, in: self)
        
        // set new frame in mobile to set frame in svg again
        deviceView.deviceData?.frameInMobile = deviceView.frame
    }
}
