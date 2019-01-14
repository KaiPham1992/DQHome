//
//  DeviceEndPoint.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/25/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import Alamofire

enum DeviceEndPoint {
    case getStatus(deviceId: String)
    case changeStatusDeviceGeneric(deviceId: String, param: MCEParam)
    case changeStatusApollo(deviceId: String, param: ApolloParam)
    case sendCommand(deviceId: String, param: [String: Any]) // user send when scene
    case changeStatusSwitchV2(deviceId: String, param: SwitchV2Param)
    
    case getDeviceByGroup(groupId: Int64)
    case changeStatusCurtain(deviceId: String, param: CurtainParam)
    
}

extension DeviceEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getStatus(let id):
            return "device/stats/\(id)"
        case .changeStatusDeviceGeneric(let id, _):
            return "device/stats/\(id)"
        case .changeStatusApollo(let id, _):
            return "device/stats/\(id)"
        case .sendCommand(let id, _):
            return "device/stats/\(id)"
        case .getDeviceByGroup(let groupId):
            return "device/group/\(groupId)"
        case .changeStatusSwitchV2(let id, _):
            return "device/stats/\(id)"
        case .changeStatusCurtain(let id, _):
            return "device/stats/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getStatus, .getDeviceByGroup:
            return .get
        case  .changeStatusDeviceGeneric, .changeStatusApollo, .sendCommand, .changeStatusSwitchV2, .changeStatusCurtain:
            return .put
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getStatus, .getDeviceByGroup:
            return [:]
        case .changeStatusDeviceGeneric(_, let param):
            return param.toJSON()
        case .changeStatusApollo(_, let param):
            return param.toJSON()
        case .sendCommand(_, let param):
            return param
        case .changeStatusSwitchV2(_, let param):
            return param.toJSON()
        case .changeStatusCurtain(_, let param):
            return param.toJSON()
        }
    }
    
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }
    
    
}
