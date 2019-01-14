//
//  Provider.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/30/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation

class Provider {
    static let shared = Provider()
    
    private let request: NetworkRequestProtocol = NetworkRequest()
    
    private var networkManager: APINetworkProtocol {
        return APINetwork(request: request)
    }
    
    var deviceAPIService: DeviceAPIServiceProtocol {
        return DeviceAPIService(network: networkManager)
    }
    
    var groupAPIService: GroupAPIServiceProtocol {
        return GroupAPIService(network: networkManager)
    }
    
    var sceneAPIService: SceneAPIServiceProtocol {
        return SceneAPIService(network: networkManager)
    }
    
    var resourceAPIService: ResourceAPIServiceProtocol {
        return ResourceAPIService(network: networkManager)
    }
}
