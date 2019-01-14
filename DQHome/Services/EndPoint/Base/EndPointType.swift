//
//  EndPointType.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/27/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: JSONDictionary { get }
    var headers: HTTPHeaders? { get }
}

struct DefaultHeader {
    func addAuthHeader() -> [String: String] {
        var header: [String: String] = [:]
        header["Authorization"] = CognitoService.shared.token
        
        return header
    }
    
}

