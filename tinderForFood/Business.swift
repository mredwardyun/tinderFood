////
////  Business.swift
////  tinderForFood
////
////  Created by Edward Yun on 12/7/15.
////  Copyright © 2015 Edward Yun. All rights reserved.
////

import CoreLocation
import Foundation
import SwiftyJSON

class Business: CustomStringConvertible {
    
    var phone: String?
    var id: String?
    var image_url: String?
    var image: UIImage?
    var display_phone: String?
    var location: JSON?
    var isClosed: Bool?
    var distance: Double?
    var name: String?
    var category: JSON?
    var rating: Int?
    
    init(json: JSON) {
        if let phone = json["phone"].string {
            self.phone = phone
        }
        if let id = json["id"].string {
            self.id = id
        }
        if let image_url = json["image_url"].string {
            self.image_url = image_url.stringByReplacingOccurrencesOfString("ms.jpg", withString: "o.jpg")
        }
        if let display_phone = json["display_phone"].string {
            self.display_phone = display_phone
        }
        if let location = json["location"] as? JSON {
            self.location = location
        }
        if let isClosed = json["is_closed"].bool {
            self.isClosed = isClosed
        }
        if let distance = json["distance"].double {
            self.distance = distance
        }
        if let name = json["name"].string {
            self.name = name
        }
        if let category = json["category"] as? JSON {
            self.category = category
        }
        if let rating = json["rating"].int {
            self.rating = rating
        }
    }
    
    var description: String {
        return "restaraunt: \(name)"
    }
    
}

