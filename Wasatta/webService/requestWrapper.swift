//
//  requestWrapper.swift
//  Wasatta
//
//  Created by Said Abdulla on 10/8/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import TRON
import Alamofire
import SwiftyJSON


class RequestWrapper: NSObject {
    
    
    static let tron1 = TRON(baseURL: "http://wasataa-001-site1.ftempurl.com/api/RealEstate/RealEstateDetails?Lang=ar&id=327")
    static let tron2 = TRON(baseURL: "http://wasataa-001-site1.ftempurl.com/api")
    
    static var accessToken:String!
    
    static func getAccessToken(completionHandler: @escaping (ResponseModel?, APIError<ErrorModel>?) -> Swift.Void) {
        let tokenHeaders = [String: String]()
        var params = [String: Any]()
        params["grant_type"] = "password"
        params["username"] = "ibrahem@developer.com"
        params["password"] = "109504"
        
        let request: APIRequest<ResponseModel, ErrorModel> = tron1.swiftyJSON.request("//token")
        request.method = HTTPMethod.post
        request.headers = tokenHeaders
        request.parameters = params
        request.perform(withSuccess: { (responseModel) in
            
            completionHandler(responseModel, nil)
            self.accessToken = responseModel.accessToken!
            UserDefaults.standard.set(accessToken, forKey: "accessToken")
        }) { (error) in
            completionHandler(nil, error)
            
            if let userDefaultsAccessToken = UserDefaults.standard.value(forKey: "accessToken") {
                accessToken = userDefaultsAccessToken as! String
                
            }
            
        }
        
    }
    
//    static func getActivities(completionHandler: @escaping (ResponseModel?, APIError<ErrorModel>?) -> Swift.Void) {
//        let request: APIRequest<ResponseModel, ErrorModel> = tron.swiftyJSON.request("")
//        request.method = HTTPMethod.get
//        
//        request.perform(withSuccess: { (responseModel) in
//            completionHandler(responseModel, nil)
//            
//            print("success \(responseModel)")
//                        
//        }) { (error) in
//            completionHandler(nil, error)
//            print("error \(error)")
//        }
//        
//    }
    
    
    static func getRSDetails(completionHandler: @escaping (ResponseModel?, APIError<ErrorModel>?) -> Swift.Void) {
        
        let request: APIRequest<ResponseModel, ErrorModel> = tron1.swiftyJSON.request("")
        request.method = HTTPMethod.get
        request.perform(withSuccess: { (responseModel) in
            completionHandler(responseModel, nil)
            print("success tron2 \(responseModel)")
            
        }) { (error) in
            completionHandler(nil, error)
            print("error \(error)")
        }
        
    }
   
    
    
}


