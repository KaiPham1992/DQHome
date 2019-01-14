//
//  DeviceAPIService.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/25/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol DeviceAPIServiceProtocol {
    // MCE
    func getStatusMCE(deviceId: String, success: @escaping SuccessHandler<MCEDevice>.object, failure: @escaping RequestFailure)
    func changeStatusDeviceGeneric(deviceId: String, param: MCEParam, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure)
    
    // APOLLO
    func getStatusAPollo(deviceId: String, success: @escaping SuccessHandler<APolloDevice>.object, failure: @escaping RequestFailure)
    
    func changeStatusApollo(deviceId: String, param: ApolloParam, success: @escaping SuccessHandler<APolloDevice>.object, failure: @escaping RequestFailure)
    
    // Switch V2
    func getStatusSwitchV2(deviceId: String, success: @escaping SuccessHandler<SwitchV2Entity>.object, failure: @escaping RequestFailure)
    func changeStatusSwitchV2(deviceId: String, param: SwitchV2Param, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure)
    
    //---
    func getDeviceByGroup(groupId: Int64, success: @escaping SuccessHandler<DeviceEntity>.array, failure: @escaping RequestFailure)
    
    // curtain
     func getStatusCurtain(deviceId: String, success: @escaping SuccessHandler<CurtainEntity>.object, failure: @escaping RequestFailure)
    
    func changeStatusCurtain(deviceId: String, param: CurtainParam, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure)
    
}

class DeviceAPIService: DeviceAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    // APOLLO
    func getStatusAPollo(deviceId: String, success: @escaping (APolloDevice?) -> Void, failure: @escaping RequestFailure) {
        let endPoint = DeviceEndPoint.getStatus(deviceId: deviceId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changeStatusApollo(deviceId: String, param: ApolloParam, success: @escaping SuccessHandler<APolloDevice>.object, failure: @escaping RequestFailure) {
        let json = JSON(param.toJSON())
        print(json)
        
        let endPoint = DeviceEndPoint.changeStatusApollo(deviceId: deviceId, param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
    
    // MCE
    func getStatusMCE(deviceId: String, success: @escaping (MCEDevice?) -> Void, failure: @escaping RequestFailure) {
        let endPoint = DeviceEndPoint.getStatus(deviceId: deviceId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changeStatusDeviceGeneric(deviceId: String, param: MCEParam, success: @escaping (BaseEntity?) -> Void, failure: @escaping RequestFailure) {
        let endPoint = DeviceEndPoint.changeStatusDeviceGeneric(deviceId: deviceId, param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
    
    //--
    func getDeviceByGroup(groupId: Int64, success: @escaping SuccessHandler<DeviceEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = DeviceEndPoint.getDeviceByGroup(groupId: groupId)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    // switch v2
    func getStatusSwitchV2(deviceId: String, success: @escaping SuccessHandler<SwitchV2Entity>.object, failure: @escaping RequestFailure) {
        let endPoint = DeviceEndPoint.getStatus(deviceId: deviceId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changeStatusSwitchV2(deviceId: String, param: SwitchV2Param, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = DeviceEndPoint.changeStatusSwitchV2(deviceId: deviceId, param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    // curtain
    func getStatusCurtain(deviceId: String, success: @escaping SuccessHandler<CurtainEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = DeviceEndPoint.getStatus(deviceId: deviceId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changeStatusCurtain(deviceId: String, param: CurtainParam, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = DeviceEndPoint.changeStatusCurtain(deviceId: deviceId, param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}


