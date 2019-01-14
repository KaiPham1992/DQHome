//
//  GroupAPIService.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/1/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation

protocol GroupAPIServiceProtocol {
    func getTopGroup(success: @escaping SuccessHandler<GroupEntity>.array, failure: @escaping RequestFailure)
}

class GroupAPIService: GroupAPIServiceProtocol {
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getTopGroup(success: @escaping SuccessHandler<GroupEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = GroupEndPoint.getTopGroup()
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
}
