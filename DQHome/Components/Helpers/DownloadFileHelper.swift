//
//  DownloadFileHelper.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation

class DownloadFileHelper {
    class func downLoad(urlString: String, completion: @escaping CompletionMessage, failure: @escaping RequestFailure) {
        guard let url = URL(string: urlString) else {
            failure(APIError(message: "DownloadFileHelper: wrong url"))
            return
        }
        let session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                failure(APIError(error: error))
            } else {
                guard let _data = data else { return }
                let text = String(data: _data, encoding: String.Encoding.utf8)
                completion(text)
            }
        }
        
        task.resume()
        
    }
}
