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
    
    private var accessToken = ""
    
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var confirmTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    private var loginBool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    // MARK: Networking (Alamofire)
    func makeJsonCall(apiCall: String, params: [String: String], completionHandler: (Int, JSON, NSError?) -> ()) {
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/\(apiCall)", parameters: params, encoding: .JSON).responseJSON { response in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling POST on /api/\(apiCall)")
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
    
    func makeCall(apiCall: String, params: [String: String], completionHandler: (Int, NSError?) -> ()) {
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/\(apiCall)", parameters: params, encoding: .JSON).responseString { response in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling POST on /api/\(apiCall)")
                print(response.result.error!)
                return
            }
            
            if let value: Int = response.response!.statusCode {
                // handle the results as JSON, without a bunch of nested if loops
                completionHandler(value, response.result.error)
            }
            
        }
    }
    
    func checkUsername(username: String, completionHandler: (Int, NSError?) -> ()) {
        let parameters = ["username": username]
        makeCall("checkUsername", params: parameters) { responseCode, error in
            print(responseCode)
            print(error)
            completionHandler(responseCode, error)
        }
    }
    
    func checkEmail(email: String, completionHandler: (Int, NSError?) -> ()) {
        let parameters = ["email": email]
        makeCall("checkEmail", params: parameters) { responseCode, error in
            print(responseCode)
            print(error)
            completionHandler(responseCode, error)
        }
    }
    
    
    
    
    //MARK: Storyboard
    @IBAction func loginButtonClicked(sender: AnyObject) {
        if loginBool {
            login()
        } else {
            signup()
        }
    }
    
    func login() {
        let username = usernameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
//        let parameters = ["username": username, "email": email, "password": password]
//        makeJsonCall("login", params: parameters) { responseCode, responseJson, error in
//            print(responseCode)
//            self.accessToken = responseJson["access_token"].stringValue
//            print(self.accessToken)
//        }
        let parameters = ["username": username, "email": email, "password": password]
        print(parameters)
        makeJsonCall("login", params: parameters) { responseCode, responseJson, error in
            print(responseCode)
            self.accessToken = responseJson["access_token"].stringValue
            print(self.accessToken)
        }
    }
    
    func signup() {
        
        let email = emailTextField.text
        let username = usernameTextField.text
        let password = passwordTextField.text
        let confirm = confirmTextField.text
        
        if password != confirm  {
            let alertController = UIAlertController(title: "Oops", message:
                "Make sure your passwords match!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
        else if password?.characters.count < 5 {
            let alertController = UIAlertController(title: "Oops", message:
                "Password must be at least 5 characters", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
        else if username?.characters.count < 5 {
            let alertController = UIAlertController(title: "Oops", message:
                "Username must be at least 5 characters", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if email?.characters.count < 5 {
            let alertController = UIAlertController(title: "Oops", message:
                "Email must be at least 5 characters", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            checkUsername(username!) { responseCode, error in
                if responseCode == 200 {
                    self.checkEmail(email!) { responseCode, error in
                        if responseCode == 200 {
                            self.registerUser(username!, email: email!, password: password!)
                        }
                        else {
                            print(error)
                            let alertController = UIAlertController(title: "Oops", message:
                                "Email has already been used. Try a new one.", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                            self.presentViewController(alertController, animated: true, completion: nil)

                        }
                    }
                }
                else {
                    print(error)
                    let alertController = UIAlertController(title: "Oops", message:
                        "Username is already taken. Try something different.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    func registerUser(username: String, email: String, password: String) {
        let parameters = ["username": username, "email": email, "password": password]
        print(parameters)
        makeJsonCall("register", params: parameters) { responseCode, responseJson, error in
            print(responseCode)
            self.accessToken = responseJson["access_token"].stringValue
            print(self.accessToken)
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
        confirmLabel.hidden = true
        confirmTextField.hidden = true
        loginButton.setTitle("Login", forState: .Normal)
        loginBool = true
    }
    func signupSelected() {
        print("signup")
        confirmLabel.hidden = false
        confirmTextField.hidden = false
        loginButton.setTitle("Signup", forState: .Normal)
        loginBool = false
        
    }
    
}
