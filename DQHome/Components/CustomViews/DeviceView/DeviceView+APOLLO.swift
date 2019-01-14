//
//  DeviceView+APOLLO.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/5/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

// MARK: hanlde APOLLO
extension DeviceView: ApolloPopUpRemoteDelegate {
    func didChangedValue(color: UIColor, brightness: CGFloat) {
        sendSignal(color: color, brightness: brightness)
    }
    
    private func sendSignal(color: UIColor? = UIColor.clear, brightness: CGFloat? = nil, setOff: Bool = false) {
        guard let deviceId = self.deviceData?.deviceId& else { return }
        guard let color = color else { return }
        var param: ApolloParam!
        ProgressView.shared.showProgressSendSignalOnWindow()
        
        if !setOff {
            let (r, g, b) = color.toIntRGB()
            param = ApolloParam(jsonVersion: "0002", id: "0002", r: r, g: g, b: b)
        } else {
            param = ApolloParam(jsonVersion: "0002", id: "0002", r: 0, g: 0, b: 0, w: 0)
        }
        
        Provider.shared.deviceAPIService.changeStatusApollo(deviceId: deviceId, param: param, success: { _baseEntity in
            if color.toRGB() == UIColor.black.toRGB() {
                self.imgIcon.tintColor = AppColor.gray
            } else {
                self.imgIcon.tintColor = color
            }
            
            ProgressView.shared.hideProgressView()
        }) { error in
            ProgressView.shared.hideProgressView()
            PopUpNotificationHelper.shared.showMessage(error: error)
        }
    }
    
    func showControlApollo() {
        if checkOnline() {
            let pop = ApolloPopUpRemote()
            pop.showPopUp(delegate: self)
        }
    }
    
    func tapApollo() {
        if checkOnline() {
            if self.imgIcon.tintColor.toRGB() != AppColor.gray.toRGB() {
                sendSignal(setOff: true)
            } else {
                ProgressView.shared.showProgressSendSignalOnWindow()
                self.getOnlineOfflineAPollo { _color in
                    // FIX COLOR RED TO COLOR GET From API
                    self.sendSignal(color: UIColor.red)
                }
            }
        }
    }
    
    func checkOnline() -> Bool {
        guard let isOnline = self.apolloDevice?.isOnline else { return false }
        if !isOnline {
            PopUpNotificationHelper.shared.showMessage(message: AppString.Message.deviceOffline.showLanguage)
            return false
        }
        
        return true
    }
    
    func getOnlineOfflineAPollo(completion:  @escaping (_ color: UIColor?) -> Void) {
        if let _deviceId = self.deviceData?.deviceId, let type = self.deviceData?.type {
            
            guard type == .apollo else {
                return
            }
            print(_deviceId)
            
            if !_deviceId.isEmpty {
                let queue = OperationQueue()
                queue.name = "Get status Apollo"
                queue.addOperation {
                    Provider.shared.deviceAPIService.getStatusAPollo(deviceId: _deviceId, success: { [weak self] _apolloDevice in
                        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                            guard let strongSelf = self else { return }
                            guard let _appolloDevice  = _apolloDevice else { return }
                            strongSelf.apolloDevice = _appolloDevice
                            if let color = _appolloDevice.state?.reported?.color {
                                
                                // OFF
                                if color.toRGB() == UIColor.black.toRGB() {
                                    self?.imgIcon.tintColor = AppColor.gray
                                    // ON
                                } else {
                                    self?.imgIcon.tintColor = color
                                    completion(color)
                                    UserDefaultHelper.shared.save(value: color.toRGB(), key: _deviceId)
                                }
                                
                                // complete
                                completion(color)
                            }
                        })
                        }, failure: { error in
                            print("DeviceView + APOLLO: \(error.debugDescription)")
                    })
                }
            }
        }
    }
}
