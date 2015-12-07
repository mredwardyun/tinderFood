//
//  RestaurantViewController.swift
//  tinderForFood
//
//  Created by Edward Yun on 12/1/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit
import SwiftyJSON

class RestaurantViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var restaurantData = [String:String]()
    let accessToken = NSUserDefaults.standardUserDefaults().objectForKey("access_token")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantLabel.text = restaurantData["name"]
        addressLabel.text = restaurantData["address"]
        distanceLabel.text = restaurantData["distance"]
        hoursLabel.text = "Open until \(restaurantData["closingTime"]!) today"
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
