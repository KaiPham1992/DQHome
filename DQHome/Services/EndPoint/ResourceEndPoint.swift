//
//  ResourceEndPoint.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/21/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Alamofire

enum ResourceEndPoint {
    case getResource(groupId: String, slot: Int)
    case uploadResouceStepOne(groupId: String, slot: Int, md5: String)
    case uploadResouceStepTwo(url: String, md5: String)
}

extension ResourceEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getResource(let groupId, let slot):
            return "resource/\(groupId)/\(slot)"
        case .uploadResouceStepOne(let groupId, let slot, _):
            return "resource/\(groupId)/\(1)"
        case .uploadResouceStepTwo(let url, _ ):
            return url
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getResource:
            return .get
        case .uploadResouceStepOne, .uploadResouceStepTwo:
            return .put
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getResource, .uploadResouceStepOne, .uploadResouceStepTwo:
            return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getResource:
            return DefaultHeader().addAuthHeader()
        case .uploadResouceStepOne(_, _, let md5):
            var  header = DefaultHeader().addAuthHeader()
            header["x-file-md5"] = md5
            header["Content-Type"] = "application/json"
            return header
        case .uploadResouceStepTwo(_, let md5):
            var  header = DefaultHeader().addAuthHeader()
            header["Content-MD5"] = md5
            return header
        }
        
    }
}
