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
        
        Alamofire.request(.GET, "https://api.yelp.com/v2/search", parameters: ["term":"food", "location":"San Francisco", "limit":"1", "oauth_consumer_key": "8HPpfMDPraCnvdfY1aBY-A"], encoding: .JSON)
        .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
       /* Alamofire.request(.GET, "https://tinder-for-food.herokuapp.com/api/checkUsername", parameters: ["username": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }*/
        
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    /*func checkUsername(username: String) -> Int {
        //Alamofire stuff with username passed
        
        //Returns HTTP status code (404, etc)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
