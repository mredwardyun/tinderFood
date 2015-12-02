//
//  swiftyJsonViewController.swift
//  tinderForFood
//
//  Created by Nick Sparkman on 11/19/15.
//  Copyright (c) 2015 Edward Yun. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class swiftyJsonViewController: UIViewController {

    var consumerKey = "8HPpfMDPraCnvdfY1aBY-A"
    var consumerSecret = "1xtpMhhk--CQDDz5v72AwMM_K1k"
    var token = "ireJLoBsAiflg_HSScggpFpKTZ1giE8S"
    var tokenSecret = "0hmsBuZ2hGtFTm80Gt-iveENveI" 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*Alamofire.request(.GET, "https://api.yelp.com/v2/search", parameters: ["term":"food", "location":"San Francisco", "limit":"1", "oauth_consumer_key": "8HPpfMDPraCnvdfY1aBY-A"], encoding: .JSON)
        .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }*/
        
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/checkUsername", parameters: ["username": "bar123"], encoding:.JSON)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                
                if response.response?.statusCode == 200 {
                    print("success")
                } else if response.response?.statusCode == 422 {
                    print("invalid username")
                } else {
                    print("server error-checkUsername")
                }
                
                /*switch response.result {
                case .Success:
                    print("Validation Success")
                case .Failure(let error):
                    print(error)*/
        
        }
        
        
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/users/addRestaurant", parameters: ["access_token": "accesstoken", "restaurantid": "restaurantid"], encoding: .JSON)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)
                
                if response.response?.statusCode == 200 {
                    print("success")
                } else if response.response?.statusCode == 401 {
                    print("user doesn't exist or incorrect credentials")
                } else {
                    print("server error-addRestaurant")
                }
        }
        
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/users/deleteRestaurant", parameters: ["access_token": "accesstoken", "restaurantid": "restaurantid"], encoding: .JSON)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)
                
                if response.response?.statusCode == 200 {
                    print("successfully deleted")
                } else if response.response?.statusCode == 401 {
                    print("user doesn't exist or incorrect credentials")
                } else {
                    print("server error-deleteRestaurant")
                }
        }
    
    Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/users/getRestaurant", parameters: ["access_token": "accesstoken"], encoding: .JSON)
        .responseString { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)
            
            if response.response?.statusCode == 200 {
                print("successfully deleted")
                // ADD SWIFTYJSON HERE
            } else if response.response?.statusCode == 401 {
                print("user doesn't exist or incorrect credentials")
            } else {
                print("server error-deleteRestaurant")
            }
        }




        // Do any additional setup after loading the view.
    }


    /* CHECKUSERNAME FUNCTION */
    /*func checkUsername(username: String) -> Int {
        //Alamofire stuff with username passed
        Alamofire.request(.GET, "https://tinder-for-food.herokuapp.com/api/", parameters: ["username": username], encoding: .JSON)
        .responseString { response in
            return response.response?.statusCode
        //Returns HTTP status code (404, etc)
    }*/
    
    /* ADD RESTAURANT FUNCTION */
    /*func addRestaurant(accesstoken: String, restaurantid: String) -> Int {
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/users/addRestaurant", parameters: ["access_token": accesstoken, "restaurantid": restaurantid], encoding: .JSON)
        .responseString { response in

            return response.response?.statusCode

            }
        }
*/


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}
