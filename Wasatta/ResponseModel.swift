//
//  ResponseModel.swift
//  Wasatta
//
//  Created by Said Abdulla on 10/8/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

class ResponseModel: NSObject , JSONDecodable {
    var ads: Array<RealEstateObject>!
    var realestatedetailsobject: Array<RealEstateDetailsObject>!
    var accessToken:String?
    required init(json: JSON) throws {
        self.ads = try? RealEstateObject.parseJson(json: json)
        self.realestatedetailsobject = try? RealEstateDetailsObject.parseJson(json: json)

        //self.accessToken = json["access_token"].string
        
        print(Array<RealEstateObject>?.self)
        print(Array<RealEstateDetailsObject>?.self)

    }
    
    
}
class ErrorModel: NSObject, JSONDecodable {
    var theError:String?
    required init(json: JSON) throws {
        theError = json.string
    }
}


