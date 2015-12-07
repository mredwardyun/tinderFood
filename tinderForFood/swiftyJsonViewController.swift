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
        
        //addRestaurant()
        deleteRestaurant()
        getRestaurants()
        
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
        
        /*Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/checkUsername", parameters: ["username": "bar123"], encoding:.JSON)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                
                if response.response?.statusCode == 200 {
                    print("success-checkUsername")
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
        
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/checkEmail", parameters: ["email": "birdsong.me@gmail.com"], encoding: .JSON)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)
                
                if response.response?.statusCode == 200 {
                    print("success-checkEmail")
                } else if response.response?.statusCode == 423 {
                    print("email is taken or is invalid")
                } else {
                    print("server error-checkEmail")
                }
        }
        
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/register", parameters: ["username": "bsedjgosj", "email": "nicksparkman0@gmail.com", "password": "password"], encoding: .JSON)
            .responseJSON { response in
                
                //MARK: Can't handle error
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result.value)
                
                if response.response?.statusCode == 200 {
                    let swiftyJsonVar = JSON(response.result.value!)
                    let accessToken = swiftyJsonVar["access_token"].stringValue
                    print(accessToken)//return and save as variable because it is needed for other calls
                    print("success-register")
                    
                } else if response.response?.statusCode == 422 {
                    print("invalid username")
                } else if response.response?.statusCode == 423 {
                    print("email is invalid")
                } else {
                    print("server error-register")
                }
        }
        
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/login", parameters: ["username": "bar123", "password": "password"], encoding: .JSON)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)
                
                if response.response?.statusCode == 200 {
                    print("success-login")
                } else if response.response?.statusCode == 401 {
                    print("invalid login")
                } else {
                    print("server error-login")
                }
        }
        
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/users/addRestaurant", parameters: ["access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyaWQiOjEyLCJpYXQiOjE0NDkwOTU1ODMsImV4cCI6MTQ2NDY0NzU4MywiaXNzIjoidGluZGVyLWZvci1mb29kIn0.DtUYkZ0gr9ZDuXJ8QvbkO5llVJgRCZlTIg4YMJe00xk", "restaurantid": "bamboo-bistro-nashville"], encoding: .JSON)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)
                
                if response.response?.statusCode == 200 {
                    print("success-addRestaurant")
                } else if response.response?.statusCode == 401 {
                    print("user doesn't exist or incorrect credentials")
                } else {
                    print("server error-addRestaurant")
                }
        }
        
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/users/deleteRestaurant", parameters: ["access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyaWQiOjEyLCJpYXQiOjE0NDkwOTU1ODMsImV4cCI6MTQ2NDY0NzU4MywiaXNzIjoidGluZGVyLWZvci1mb29kIn0.DtUYkZ0gr9ZDuXJ8QvbkO5llVJgRCZlTIg4YMJe00xk", "restaurantid": "bamboo-bistro-nashville"], encoding: .JSON)
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
        
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/users/getRestaurants", parameters: ["access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyaWQiOjEyLCJpYXQiOjE0NDkwOTU1ODMsImV4cCI6MTQ2NDY0NzU4MywiaXNzIjoidGluZGVyLWZvci1mb29kIn0.DtUYkZ0gr9ZDuXJ8QvbkO5llVJgRCZlTIg4YMJe00xk"], encoding: .JSON)
            .responseString { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)
                
                if response.response?.statusCode == 200 {
                    print("successfully got matches")
                    // ADD SWIFTYJSON HERE
                } else if response.response?.statusCode == 401 {
                    print("user doesn't exist or incorrect credentials")
                } else {
                    print("server error-getRestaurant")
                }
        }*/
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func makeJsonCall(apiCall: String, params: [String: String], completionHandler: (Int, JSON, NSError?) -> ()) {
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/users/\(apiCall)", parameters: params, encoding: .JSON).responseJSON { response in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling POST on /api/users/\(apiCall)")
                print(response.result.error!)
                return
            }
            
            if let value: AnyObject = response.result.value {
                // handle the results as JSON, without a bunch of nested if loops
                let responseJson = JSON(value)
                
                completionHandler(response.response!.statusCode, responseJson, response.result.error)
            }
            
        }
    }
    
    func getRestaurants() {
        let accesstoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyaWQiOjEyLCJpYXQiOjE0NDkwOTU1ODMsImV4cCI6MTQ2NDY0NzU4MywiaXNzIjoidGluZGVyLWZvci1mb29kIn0.DtUYkZ0gr9ZDuXJ8QvbkO5llVJgRCZlTIg4YMJe00xk"
        let parameters = ["access_token":accesstoken]
        
        makeJsonCall("getRestaurants", params: parameters) { responseCode, responseJson, error in
            print(responseCode)
            print(responseJson)
            print(error)
            
        }
    }
    
    func addRestaurant() {
        let accesstoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyaWQiOjEyLCJpYXQiOjE0NDkwOTU1ODMsImV4cCI6MTQ2NDY0NzU4MywiaXNzIjoidGluZGVyLWZvci1mb29kIn0.DtUYkZ0gr9ZDuXJ8QvbkO5llVJgRCZlTIg4YMJe00xk"
        let restaurantid = "bamboo-bistro-nashville"
        let parameters = ["access_token": accesstoken, "restaurantid": restaurantid]
        
        makeJsonCall("addRestaurant", params:parameters) {responseCode, responseJson, error in
            print(responseCode)
            print(responseJson)
            print(error)
        }
    }
    
    func deleteRestaurant() {
        let accesstoken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyaWQiOjEyLCJpYXQiOjE0NDkwOTU1ODMsImV4cCI6MTQ2NDY0NzU4MywiaXNzIjoidGluZGVyLWZvci1mb29kIn0.DtUYkZ0gr9ZDuXJ8QvbkO5llVJgRCZlTIg4YMJe00xk"
        let restaurantid = "bamboo-bistro-nashville"
        let parameters = ["access_token": accesstoken, "restaurantid": restaurantid]
        makeJsonCall( "deleteRestaurant", params: parameters) {responseCode, responseJson, error in
            print(responseCode)
            print(responseJson)
            print(error)
        }
    }
    
    
    /* CHECKUSERNAME FUNCTION */
    /*func checkUsername(username: String) -> Int {
    //Alamofire stuff with username passed
    Alamofire.request(.GET, "https://tinder-for-food.herokuapp.com/api/", parameters: ["username": username], encoding: .JSON)
    .responseString { response in
    return response.response?.statusCode
    //Returns HTTP status code (404, etc)
    }*/
    
    
    /* CHECKEMAIL FUNCTION */
    /*func checkEmail(email: String) -> Int {
    //Alamofire stuff with email passed
    Alamofire.request(.GET, "https://tinder-for-food.herokuapp.com/api/users/addEmail", parameters: ["username": username], encoding: .JSON)
    .responseString { response in
    return response.response?.statusCode
    //Returns HTTP status code (404, etc)
    }*/
    
    
    /* REGISTER FUNCTION */
    /*func register(accesstoken: String, username: String, email: String, password: String) -> Int {
    //Alamofire stuff
    Alamofire.request(.GET, "https://tinder-for-food.herokuapp.com/api/users/register", parameters: ["access_token": "accesstoken", "username": "bar123", "email": "email", "password": "password"], encoding: .JSON)
    .responseString { response in
    return response.response?.statusCode
    //Returns HTTP status code (404, etc)
    }*/
    
    /* LOGIN FUNCTION */
    /*func register(accesstoken: String, username: String, password: String) -> Int {
    //Alamofire stuff
    Alamofire.request(.GET, "https://tinder-for-food.herokuapp.com/api/users/login", parameters: ["access_token": "accesstoken", "username": "bar123", "password": "password"], encoding: .JSON)
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