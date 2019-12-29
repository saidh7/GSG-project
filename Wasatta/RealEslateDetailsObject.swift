//
//  RealEslateDetailsObject.swift
//  Wasatta
//
//  Created by Said Abdulla on 11/20/18.
//  Copyright © 2018 Said Abdulla. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON
import Alamofire
class RealEstateDetailsObject: NSObject {
    var imgsSlider = [String]()
    var property_type: String?
    var property_class: String?
    var country: String?
    var city: String?
    var phone: String?
    var email: String?
    var room: String?
    var sleeping_room: String?
    var bathroom: String?
    var price: Int?
    var priceValue: String?
    var space: Int?
    var spaceValue: String?
    var floor_number: Int?
    var floor_number_Value: String?
    var flat_nofloor: String?
    var build_age: String?
    var furniture: Bool?
    var heating: Bool?
    var insert_date: String?
    var isOffer: Bool?
    var active: Bool?
    var porch: Bool?
    var internet: Bool?
    var cleaning: Bool?
    var pool: Bool?
    var elevator: Bool?
    var parking: Bool?
    var entertainment: Bool?
    var hall = false
    var usage_status: String?
    var who_owner_ads: String?
    var latMap: String?
    var lngMap: String?
    var zoomMap: Int?
    var zoomMapValue: String?
    
    
    func parse(jsonObject: JSON) {
        guard jsonObject != nil else { return }
        
        
        if jsonObject["mainImageURL"].arrayObject != nil{
            self.imgsSlider = jsonObject["mainImageURL"].arrayObject as! [String]
        }
        self.property_type = jsonObject["propertyType"].string
        self.property_class = jsonObject["propertyClass"].string
        self.country = jsonObject["country"].string
        self.city = jsonObject["city"].string
        self.phone = jsonObject["phone"].string
        self.email = jsonObject["email"].string
        self.room = jsonObject["room"].string
        self.sleeping_room = jsonObject["sleepingRoom"].string
        self.bathroom = jsonObject["bathRoom"].string
        //Price convert to String
        self.price = jsonObject["price"].int
        let priceValue : Int = price!
        self.priceValue = String(priceValue)        
        //Zoom map convert to String
//        self.zoomMap = jsonObject["zoom"].int
//        let zoomMapValue : Int = zoomMap!
//        self.zoomMapValue = String(zoomMapValue)
    
        //Space convert to String
        self.space = jsonObject["sizeBuild"].int
        let spaceValue : Int = space!
        self.spaceValue = String(spaceValue)
        //Floor number convert to String
       // self.floor_number = jsonObject["floorsNumber"].int
        //let floor_number_Value : Int = floor_number!
        //self.floor_number_Value = String(floor_number_Value)
        self.flat_nofloor = jsonObject["floor"].string
        self.build_age = jsonObject["buildAge"].string
    //    self.furniture = jsonObject["furniture"].bool!
      //  self.heating = jsonObject["heating"].bool!
        self.insert_date = jsonObject["insertDate"].string
      //  self.isOffer = jsonObject["isOffer"].bool!
       // self.active = jsonObject["active"].bool!
       // self.porch = jsonObject["porch"].bool!
       // self.internet = jsonObject["internet"].bool!
    //    self.cleaning = jsonObject["cleaning"].bool!
    //    self.pool = jsonObject["pool"].bool!
      //  self.elevator = jsonObject["elevator"].bool!
      //  self.parking = jsonObject["parking"].bool!
      //  self.entertainment = jsonObject["entertainment"].bool!
       // self.hall = jsonObject["hall"].bool!
        self.usage_status = jsonObject["usageStatus"].string
        self.who_owner_ads = jsonObject["whoOwnerAds"].string
        self.latMap = jsonObject["latMap"].string
        self.lngMap = jsonObject["lngMap"].string
 

    }
    
    static func parseJson(json: JSON) throws -> [RealEstateDetailsObject]  {
        guard let jsonArray = json.array else { return [] }
        
        var objects = Array<RealEstateDetailsObject>()
        for jsonObject in jsonArray {
            let obj = RealEstateDetailsObject()
            obj.parse(jsonObject: jsonObject)
            objects.append(obj)
            
        }
        
        return objects
    }
    

}

