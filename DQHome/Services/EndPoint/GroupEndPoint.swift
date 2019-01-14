//
//  GroupEndPoint.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/1/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Alamofire

enum GroupEndPoint {
    case getTopGroup()
    case createGroup()
}

extension GroupEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getTopGroup, .createGroup:
            return "group"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTopGroup:
            return .get
        case .createGroup:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getTopGroup:
            return [:]
        case .createGroup:
            return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }
    
}
