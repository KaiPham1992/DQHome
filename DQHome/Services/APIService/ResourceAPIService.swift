//
//  ResourceAPIService.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/21/18.
//  Copyright © 2018 Engma. All rights reserved.
//
import Foundation
import SwiftyJSON
import Alamofire

protocol ResourceAPIServiceProtocol {
    func getResourceMetadata(groupId: String, success: @escaping SuccessHandler<TotalResourceEntity>.object, failure: @escaping RequestFailure)
    func getResource(groupId: String, slot: Int, success: @escaping SuccessHandler<ResourceEntity>.object, failure: @escaping RequestFailure)
    func  uploadResourceStepOne(groupId: String, slot: Int, md5: String, success: @escaping SuccessHandler<ResourceEntity>.object, failure: @escaping RequestFailure)
    
    func  uploadResourceStepTwo(fileName: String, url: String, header: HTTPHeaders, success: @escaping SuccessHandler<ResourceEntity>.object, failure: @escaping RequestFailure)
}

class ResourceAPIService: ResourceAPIServiceProtocol {
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getResourceMetadata(groupId: String, success: @escaping (TotalResourceEntity?) -> Void, failure: @escaping RequestFailure) {
        let endPoint = ResourceEndPoint.getResource(groupId: groupId, slot: 0)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getResource(groupId: String, slot: Int, success: @escaping (ResourceEntity?) -> Void, failure: @escaping RequestFailure) {
        let endPoint = ResourceEndPoint.getResource(groupId: groupId, slot: slot)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    //-- upload
    func uploadResourceStepOne(groupId: String, slot: Int, md5: String, success: @escaping SuccessHandler<ResourceEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = ResourceEndPoint.uploadResouceStepOne(groupId: groupId, slot: 1, md5: md5)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func uploadResourceStepTwo(fileName: String, url: String, header: HTTPHeaders, success: @escaping SuccessHandler<ResourceEntity>.object, failure: @escaping RequestFailure) {
        network.uploadFileAWS(fileName: fileName, url: url, header: header, success: MapperData.mapObject(success), failure: failure)
    }
}
