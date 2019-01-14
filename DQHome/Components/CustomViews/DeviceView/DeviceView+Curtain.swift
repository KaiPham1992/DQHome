//
//  DeviceView+Curtain.swift
//  DQHome
//
//  Created by Ngoc Duong on 12/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation

extension DeviceView {
    
    func getConnectCurtain() {
        guard let _deviceData =  self.deviceData else { return }
        
        if let _deviceId = _deviceData.deviceId, let type = _deviceData.type {
            if type != .curtainControl {
                return
            }
            
            if !_deviceId.isEmpty {
                let queue = OperationQueue()
                queue.name = "Get status device"
                queue.addOperation {
                    Provider.shared.deviceAPIService.getStatusCurtain(deviceId: _deviceId, success: { [weak self] _curtain in
                        self?.curtain = _curtain
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                            guard let strongSelf = self else { return }
                            guard let _curtain  = _curtain else { return }
                            
                        })
                        
                    }) { error in
                        print("DeviceView+ MCE: \(error.debugDescription)")
                    }
                }
            }
        }
    }
    
    func curtainControl() {
        let pop = CurtainControlPopUp()
        pop.showPopUp { any in
            guard let _deviceData =  self.deviceData else { return }
            guard let action = any as? CurtainControlPopUpContentAction else { return }
            let curtainParam = CurtainParam(id: _deviceData.deviceId&, val: action.rawValue)
            ProgressView.shared.showProgressSendSignalOnTopView()
            
            Provider.shared.deviceAPIService.changeStatusCurtain(deviceId: _deviceData.deviceId&, param: curtainParam, success: { _ in
                ProgressView.shared.hideProgressView()
            }, failure: { error in
                ProgressView.shared.hideProgressView()
                PopUpNotificationHelper.shared.showMessage(error: error)
            })
        }
    }
}
