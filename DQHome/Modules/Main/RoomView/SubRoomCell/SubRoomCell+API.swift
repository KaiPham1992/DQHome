//
//  SubRoomCellViewModel.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/29/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation


extension SubRoomCell {
    func getDevice(completion: @escaping CompletionAny) {
        if let _groupId = group?.id {
//            if let _listDevice = DataManager.shared.deviceByGroup["\(_groupId)"] _
//
//
//            if !_listDevice.isEmpty {
//
//            } else {
//
//            }
            
            Provider.shared.deviceAPIService.getDeviceByGroup(groupId: _groupId, success: { devices in
                var listDeviceData = [DeviceData]()
                devices.forEach({ deviceEntity in
                    listDeviceData.append(contentsOf: deviceEntity.toListDeviceData())
                })
                
                completion(listDeviceData)
            }) { error in
                print("Error getDevice: \(error?.message&)")
                completion(nil)
            }
        }
    }
}
