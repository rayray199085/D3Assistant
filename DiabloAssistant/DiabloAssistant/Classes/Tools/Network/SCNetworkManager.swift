//
//  SCNetworkManager.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 20/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import Alamofire

class SCNetworkManager{
    static let shared = SCNetworkManager()
    lazy var userAccount = SCUserAccount()
    var userLogon: Bool{
        return userAccount.access_token != nil
    }
    private init() {
        
    }
    
    /// send request with token
    ///
    /// - Parameters:
    ///   - urlString: url in string
    ///   - method: get/ post
    ///   - params: parameters in dictionary
    ///   - name: name in server, like: "pic" for upload
    ///   - data: file in data for upload
    ///   - completion: json(array/ dictionary), isSuccess
    func requestWithToken(urlString: String,method: HTTPMethod,params:[String:Any]?, name: String? = nil, data: Data? = nil, completion:@escaping (_ list:Any?, _ isSuccess: Bool)->()){
        guard let token = userAccount.access_token else{
            NotificationCenter.default.post(name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
            completion(nil,false)
            return
        }
        var params = params
        if params == nil{
            params = [String:Any]()
        }
        params?["access_token"] = token
        if let name = name,
            let data = data{
            // if name & data are not nil, use upload function
            upload(urlString: urlString, name: name, params: params, data: data) { (res, isSuccess, statusCode, _) in
                if statusCode == 403 {
                    NotificationCenter.default.post(name: NSNotification.Name(SCUserShouldLoginNotification), object: "invalid token")
                    completion(nil,false)
                    return
                }
                completion(res,isSuccess)
            }
        }else{
            request(urlString: urlString, method: method, params: params) { (res, isSuccess, statusCode, _) in
                if statusCode == 403 {
                   NotificationCenter.default.post(name: NSNotification.Name(SCUserShouldLoginNotification), object: "invalid token")
                    completion(nil,false)
                    return
                }
                completion(res,isSuccess)
            }
        }
    }
    /// request method
    ///
    /// - Parameters:
    ///   - urlString: url in string
    ///   - method: get/ post
    ///   - params: parameters in dictionary
    ///   - completion: json(array/ dictionary), isSuccess, error
    func request(urlString:String, method:HTTPMethod, params:[String:Any]?, completion :@escaping (_ response: Any?,_ isSuccess: Bool, _ statusCode: Int,_ error: Error?)->() ){
        Alamofire.request(urlString, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (dataResponse) in
            completion(
                dataResponse.result.value,
                dataResponse.result.isSuccess,
                dataResponse.response?.statusCode ?? -1,
                dataResponse.result.error)
        }
    }
    
    
    /// Upload a file to server
    ///
    /// - Parameters:
    ///   - urlString: url in string
    ///   - name: name in server, like: "pic"
    ///   - params: a dictionary for parameters
    ///   - data: file in data
    ///   - completion: response in json / nil
    func upload(urlString: String, name: String, params: [String: Any]?,data: Data, completion:@escaping (_ response: Any?,_ isSuccess: Bool, _ statusCode: Int,_ error: Error?)->()){
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(
                data,
                withName: name,
                fileName: "xxxxxx",
                mimeType: "application/octet-stream")
            for (key,value) in params ?? [:]{
                multipartFormData.append(
                    (value as! String).data(using: String.Encoding.utf8)!,
                    withName: key)
            }
        }, to: urlString) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    completion(
                        response.result.value,
                        response.result.isSuccess,
                        response.response?.statusCode ?? -1,
                        response.result.error)
                }
            case .failure(let encodingError):
                completion(nil, false, -1, encodingError)
            }
        }
    }
}
