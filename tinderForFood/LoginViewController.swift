//
//  LoginViewController.swift
//  tinderForFood
//
//  Created by Edward Yun on 12/3/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    private var consumerKey = "8HPpfMDPraCnvdfY1aBY-A"
    private var consumerSecret = "1xtpMhhk--CQDDz5v72AwMM_K1k"
    private var token = "ireJLoBsAiflg_HSScggpFpKTZ1giE8S"
    private var tokenSecret = "0hmsBuZ2hGtFTm80Gt-iveENveI"
    
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var confirmTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    private var loginBool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        print("this should be 422: \(checkUsername("edward1"))")
        //        print("this should be 200: \(checkUsername("mySuperMan"))")
        
        
        //        makeCall("register", params: ["username": "edward3", "email": "edward3@gmail.com", "password": "myPassword"]) { responseObject in
        //            print("call response is \(responseObject)")
        //            print("data is \(responseObject["access_token"].stringValue)")
        //        }
        
        // Do any additional setup after loading the view.
    }
    
//    func checkUsername() -> Bool {
//        var flag = false
//        makeCall("checkUsername", params: ["username": "edward123"]) { responseObject, error in
//            print("response is \(responseObject); error is \(error)")
//            if responseObject == 200 {
//                flag = true
//            }
//        }
//        return flag
//    }
    
    /* CHECKUSERNAME FUNCTION */
    //    func checkUsername(username: String, completionHandler: (Int) -> ()) {
    //
    //        //Alamofire stuff with username passed
    //        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/checkUsername", parameters: ["username": username], encoding: .JSON)
    //            .responseString { response in
    //                print(response.request)  // original URL request
    //                print(response.response) // URL response
    //                print(response.data)     // server data
    //                print(response.result)   // result of response serialization
    //
    //                if response.response?.statusCode == 200 {
    //                    print("success-checkUsername")
    //                } else if response.response?.statusCode == 422 {
    //                    print("invalid username")
    //                } else {
    //                    print("server error-checkUsername")
    //                }
    //
    ////                abc = Int(response.response?.statusCode)
    //                completionHandler(response.response!.statusCode as Int)
    //        }
    //    //Returns HTTP status code (404, etc)
    //    }
    
    //    func makeCall(apiCall: String, params: [String:String], completionHandler: (NSString, NSError) -> ()) {
    func makeCall(apiCall: String, params: [String: String], completionHandler: (Int, JSON, NSError?) -> ()) {
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/\(apiCall)", parameters: params, encoding: .JSON)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)
                
                let json = JSON(response.data!)
                
                
                if let accessToken = json["access_token"].string {
                    print("printing \(accessToken)")
                } else {
                    print(json["access_token"].error)
                }

                
                completionHandler(response.response!.statusCode, json, response.result.error)
                
        }
    }
    
    
    //MARK: Storyboard
    
    @IBAction func loginButtonClicked(sender: AnyObject) {
        if loginBool {
            checkThis()
        } else {
            signup()
        }
    }
    
    func login() {
        let parameters = ["username": "edward3", "email": "edward3@gmail.com", "password": "password"]
        makeCall("login", params: parameters) { responseCode, responseJson, error in
            print(responseCode)
            print(responseJson)
        }
    }
    
    func signup() {
        let parameters = ["username": "edward22", "email": "edward22@gmail.com", "password": "password"]
        makeCall("register", params: parameters) { responseCode, responseJson, error in
            print(responseCode)
            print(responseJson)
        }
    }
    
    func checkThis() {
        let parameters = ["username": "avery"]
        makeCall("checkUsername", params: parameters) { responseCode, responseJson, error in
            print(responseCode)
        }
    }
    
    @IBAction func segmentChanged(sender: AnyObject) {
        switch loginSegmentedControl.selectedSegmentIndex {
            case 0:
                loginSelected()
            case 1:
                signupSelected()
            default:
                break
        }
    }
    
    func loginSelected() {
        print("login")
        confirmLabel.hidden = false
        confirmTextField.hidden = false
        loginButton.setTitle("Login", forState: .Normal)
        loginBool = true
    }
    func signupSelected() {
        print("signup")
        confirmLabel.hidden = true
        confirmTextField.hidden = true
        loginButton.setTitle("Signup", forState: .Normal)
        loginBool = false

    }
    
}
