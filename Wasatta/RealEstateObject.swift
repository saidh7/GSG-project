//
//  RealEstateObject.swift
//  Wasatta
//
//  Created by Said Abdulla on 10/8/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//


import UIKit
import TRON
import SwiftyJSON
import Alamofire
class RealEstateObject: NSObject {
    var mainimg :String?
    var title:String?
    var proptyp:String?
    var propclass:String?
    var contry:String?
    var city:String?
    var phone:String?
    var room:String?
    var broom:String?
    var price:Int?
    var priceValue:String?
    var buildingSize:Int?
    var buildingSizeValue:String?
    var nuOfFloor:String?
    //var isDelete = false
  //  var active = false
    
    func parse(jsonObject: JSON) {
        guard jsonObject != nil else { return }
        
        
        self.mainimg = jsonObject["mainImageURL"].string

        self.proptyp = jsonObject["propertyType"].string
        self.propclass = jsonObject["propertyClass"].string
        
        self.title = proptyp! + " " + propclass!

        self.contry = jsonObject["country"].string
        self.city = jsonObject["city"].string
        self.phone = jsonObject["phone"].string
        self.room = jsonObject["room"].string

        self.broom = jsonObject["bathRoom"].string
        self.price = jsonObject["price"].int
        let priceValue : Int = price!
        self.priceValue = String(priceValue)
        self.buildingSize = jsonObject["sizeBuild"].int
        let buildingSizeValue : Int = buildingSize!
        self.buildingSizeValue = String(buildingSizeValue)
        self.nuOfFloor = jsonObject["floorsNumber"].string
 
    }
    
    static func parseJson(json: JSON) throws -> [RealEstateObject]  {
        guard let jsonArray = json.array else { return [] }
        
        var objects = Array<RealEstateObject>()
        for jsonObject in jsonArray {
            let obj = RealEstateObject()
            obj.parse(jsonObject: jsonObject)
                objects.append(obj)
                
        }
        
        return objects
    }
}

