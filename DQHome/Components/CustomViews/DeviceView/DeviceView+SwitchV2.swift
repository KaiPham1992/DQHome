//
//  Device_SwitchV2.swift
//  DQHome
//
//  Created by Kai Pham on 1/10/19.
//  Copyright © 2019 Engma. All rights reserved.
//

import Foundation

extension DeviceView {
    func getOnlineOfflineSwitchV2() {
        guard let _deviceData =  self.deviceData else { return }
        
        if let _deviceId = self.deviceData?.deviceId, let type = self.deviceData?.type {
            if type != .lightSwitch {
                return
            }
            
            if !_deviceId.isEmpty {
                let queue = OperationQueue()
                queue.name = "Get status device"
                queue.addOperation {
                    Provider.shared.deviceAPIService.getStatusSwitchV2(deviceId: _deviceId, success: { [weak self] swV2Device in
                        self?.switchV2 = swV2Device
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                            
                            guard let strongSelf = self else { return }
                            guard let _swV2Device  = swV2Device else { return }
                            strongSelf.isOn = _swV2Device.isOn(index: _deviceData.metaData&) == 1
                        })
                        
                    }) { error in
                        print("DeviceView+ MCE: \(error.debugDescription)")
                    }
                }
            }
        }
    }
    
    func tapSwitchV2() {
        guard let index = self.deviceData?.metaData else { return }
        guard let reportSate = self.switchV2?.state?.reported else { return }
        guard let deviceId = self.deviceData?.deviceId else { return }
        let currentState = reportSate.isOnLight(index: index)
        let newState = currentState == 1 ? 0: 1
        
        ProgressView.shared.showProgressSendSignalOnTopView()
        let param = SwitchV2Param(id: reportSate.id, index: index, isOn: newState)
        Provider.shared.deviceAPIService.changeStatusSwitchV2(deviceId: deviceId, param: param, success: { _ in
            ProgressView.shared.hideProgressView()
            switch index {
            case "0":
                self.switchV2?.state?.reported?.sw1 = newState
            case "1":
                self.switchV2?.state?.reported?.sw2 = newState
            case "2":
                self.switchV2?.state?.reported?.sw3 = newState
            case "3":
                self.switchV2?.state?.reported?.sw4 = newState
            default:
                break
            }
            self.isOn = self.switchV2?.isOn(index: index) == 1
            
        }) { error in
            ProgressView.shared.hideProgressView()
            PopUpNotificationHelper.shared.showMessage(error: error)
        }
    }
}
