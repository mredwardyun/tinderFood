//
//  LoginViewController.swift
//  tinderForFood
//
//  Created by Edward Yun on 12/3/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit
import Alamofire

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUsername("hello") { responseObject in
            print("response is \(responseObject)")
        }
        
        makeCall("checkEmail", params: ["email": "birdsong.me@gmail.com"]) { responseObject in
            print("call response is \(responseObject)")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* CHECKUSERNAME FUNCTION */
    func checkUsername(username: String, completionHandler: (Int) -> ()) {
        
        //Alamofire stuff with username passed
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/checkUsername", parameters: ["username": username], encoding: .JSON)
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
                
//                abc = Int(response.response?.statusCode)
                completionHandler(response.response!.statusCode as Int)
        }
    //Returns HTTP status code (404, etc)
    }
    
    func makeCall(apiCall: String, params: [String:String], completionHandler: (String) -> ()) {
        Alamofire.request(.POST, "https://tinder-for-food.herokuapp.com/api/\(apiCall)", parameters: params, encoding: .JSON)
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
                completionHandler(response.result.value! as String)
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
