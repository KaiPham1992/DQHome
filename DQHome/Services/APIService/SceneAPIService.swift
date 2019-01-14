//
//  SceneAPIService.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/20/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol SceneAPIServiceProtocol {
    func getScene(success: @escaping SuccessHandler<SceneEntity>.array, failure: @escaping RequestFailure)
     func triggerScene(sceneId: String, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure)
}

class SceneAPIService: SceneAPIServiceProtocol {
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getScene(success: @escaping SuccessHandler<SceneEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = SceneEndPoint.getScene()
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func triggerScene(sceneId: String, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = SceneEndPoint.triggerScene(id: sceneId)
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
}
