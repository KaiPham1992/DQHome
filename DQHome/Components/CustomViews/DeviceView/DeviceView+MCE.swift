//
//  DeviceView+MCE.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/5/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit
// MARK: handle MCE
extension DeviceView {
    func tapMCE() {
        // from server
        guard let isOnline = mceDevice?.isOnline else { return }
        guard let mceId = mceDevice?.state?.reported?.mceId else { return }
        
        
        // from svg
        guard let _device = deviceData else { return }
        guard let index = Int(_device.metaData&) else { return }
        let _deviceId = _device.deviceId&
        
        // get status RE_x (XX:XX:XX:XX) from server
        guard let valueStatusMCE = mceDevice?.valueStatusMCE(reKey: _device.currentREKey) else { return }
        
        
        if !isOnline {
            PopUpNotificationHelper.shared.showMessage(message: AppString.Message.deviceOffline.showLanguage)
            return
        }
        
        //-- change status and set value again ON -> OFF, OFF -> ON, before call API, can fixed later
        let message = changeStatusMCE(message: valueStatusMCE, index: index)
        
        //--
        let param = MCEParam(id: _device.currentIndexRE, type: "RE4", val: message)
        param.mceId = mceId
        
        ProgressView.shared.showProgress(with: AppString.Loading.sendSignal)
        // call API
        Provider.shared.deviceAPIService.changeStatusDeviceGeneric(deviceId: _deviceId, param: param, success: { [weak self] baseEntity in
            ProgressView.shared.hideProgressView()
            guard let strongSelf = self else { return }
            
            // find Re_x and change status -> new status
            if let listRe = self?.mceDevice?.state?.reported?.listRE {
                for re in listRe {
                    if re.reKey == _device.currentREKey {
                        re.reValue = message
                    }
                }
            }
            
            strongSelf.isOn = strongSelf.isOn(message: message, index: index)
        }) { error in
            ProgressView.shared.hideProgressView()
            if let message = error?.message {
                PopUpNotificationHelper.shared.showMessage(message: message)
            }
        }
    }
    
    // change status on/off to send command
    func changeStatusMCE(message: String, index: Int) -> String {
        var listBool = message.split(separator: ":")
        if listBool[index].description == "ON" {
            listBool[index] = "OFF"
        } else {
            listBool[index] = "ON"
        }
        
        // change switch not control to XX
        for (indexSub, _) in listBool.enumerated() {
            if indexSub != index {
                listBool[indexSub] = "XX"
            }
        }
        
        // return message change
        var result = ""
        for (indexSub, value) in listBool.enumerated() {
            if indexSub == 0 {
                result = "\(value.description)"
            } else {
                result = "\(result):\(value.description)"
            }
        }
        
        return result
    }
    
    // get device on or off
    func isOn(message: String, index: Int) -> Bool {
        var listBool = message.split(separator: ":")
        if index < listBool.count {
            return listBool[index].description == "ON"
        }
        
        return false
    }
    
    func getOnlineOfflineMCE() {
        guard let _deviceData =  self.deviceData else { return }
        
        if let _deviceId = self.deviceData?.deviceId, let type = self.deviceData?.type {
            if type != .mce {
                return
            }
            
            if !_deviceId.isEmpty {
                let queue = OperationQueue()
                queue.name = "Get status device"
                queue.addOperation {
                    Provider.shared.deviceAPIService.getStatusMCE(deviceId: _deviceId, success: { [weak self] mceDevice in
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                            
                            guard let strongSelf = self else { return }
                            guard let _mceDevice  = mceDevice else { return }
                            strongSelf.mceDevice = _mceDevice
                            
                            // change on off
                            let message = mceDevice?.valueStatusMCE(reKey: _deviceData.currentREKey) // XX:XX:XX:XX
                            guard let index = Int(strongSelf.deviceData!.metaData&) else { return }
                            strongSelf.isOn = strongSelf.isOn(message: message&, index: index)
                        })
                        
                    }) { error in
                        print("DeviceView+ MCE: \(error.debugDescription)")
                    }
                }
            }
        }
    }
}
