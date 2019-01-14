//
//  Network.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/27/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

/***
 Input: endPoint (all info to request)
 Ouput: data or error
 ***/
import Alamofire

#if PROD || APPSTORE
let BASE_URL = "https://0c86m2ysti.execute-api.ap-southeast-1.amazonaws.com/v2/"
#else
let BASE_URL = "https://0c86m2ysti.execute-api.ap-southeast-1.amazonaws.com/v2/"
#endif

//---
typealias RequestSuccess = (_ data: Data) -> Void
typealias RequestFailure = (_ error: APIError?) -> Void

//---
typealias NetworkSuccess = (_ data: BaseResponse ) -> Void

//---
struct SuccessHandler<T> {
    typealias object = (_ object: T?) -> Void
    typealias array = (_ array: [T]) -> Void
    typealias anyObject = (_ object: Any?) -> Void
}

// NetworkPotocol
protocol NetworkRequestProtocol {
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure)
    func uploadImage(endPoint: EndPointType)
    func uploadFile(endPoint: EndPointType)
    func uploadVideo(endPoint: EndPointType)
    func uploadFileAWS(fileName: String, url: String, header: HTTPHeaders, success: @escaping RequestSuccess, failure: @escaping RequestFailure)
}

//---
struct NetworkRequest: NetworkRequestProtocol {
    func uploadFile(endPoint: EndPointType) {
        
    }
    
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
        let url = makeUrl(path: endPoint.path)
        let encoding = getAlamofireEncoding(httpMethod: endPoint.httpMethod)
        //let manager = Alamofire.SessionManager.default
        print("url: \(url)")
        
        let request = Alamofire.request(url, method: endPoint.httpMethod, parameters: endPoint.parameters, encoding: encoding, headers: endPoint.headers)
        request.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                let apiError = APIError(error: error)
                failure(apiError)
            }
        }
    }
    
    func uploadImage(endPoint: EndPointType) {
        
    }
    
    func uploadFileAWS(fileName: String, url: String, header: HTTPHeaders, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {
        let path = resoucesFolder.appendingPathComponent("\(fileName).svg")
        do {
            let data = try Data(contentsOf: path)
            let request = Alamofire.upload(data, to: url, method: .put, headers: header)
            
            request.uploadProgress { progress in
                print(progress.fractionCompleted)
            }
            request.responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    success(data)
                case .failure(let error):
                    let apiError = APIError(error: error)
                    failure(apiError)
                }
            }
        } catch {
            
        }
    }
    
    func uploadVideo(endPoint: EndPointType) {
        
    }
}

// MARK: helper NetworkRequest
extension NetworkRequest {
    private func getAlamofireEncoding(httpMethod: HTTPMethod) -> ParameterEncoding {
        switch httpMethod {
        case .get:
            return URLEncoding.default
        case .post:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    private func makeUrl(path: String) -> String {
        return "\(BASE_URL)\(path)"
    }
}

