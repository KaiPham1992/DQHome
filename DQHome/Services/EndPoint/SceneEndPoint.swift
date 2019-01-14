//
//  SceneEndPoint.swift
//  DQHome
//
//  Created by Ngoc Duong on 11/20/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Alamofire

enum SceneEndPoint {
    case getScene()
    case createScene()
    case triggerScene(id: String)
}

extension SceneEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getScene, .createScene:
            return "scene"
        case .triggerScene(let id):
             return "scene/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getScene:
            return .get
        case .createScene, .triggerScene:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getScene, .triggerScene:
            return [:]
        case .createScene:
            return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }
    
    
}
