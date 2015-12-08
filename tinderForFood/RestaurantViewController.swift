//
//  RestaurantViewController.swift
//  tinderForFood
//
//  Created by Edward Yun on 12/1/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class RestaurantViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    let metersToMiles = 1609.34
    
    var restaurantId:String?
    var fromCardView: Bool?
    var matchSegue = "restaurantToMatchesSegue"
    var cardSegue = "restaurantToCardsSegue"
    var backButtonSegue: String!
    
    let accessToken = NSUserDefaults.standardUserDefaults().objectForKey("access_token") as? String
    let loginViewController = LoginViewController()
    
    let locationManager = CLLocationManager()
    var location: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        if let bool = fromCardView {
            if bool {
                backButtonSegue = cardSegue
            } else {
                backButtonSegue = matchSegue
            }
        } else {
            backButtonSegue = matchSegue
        }

        getRestaurantDetail(restaurantId)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.location == nil {
            self.location = locations[0] as CLLocation
        }
    }
    
    @IBAction func didTapBackButton(sender: AnyObject) {
        performSegueWithIdentifier(backButtonSegue, sender: sender)
    }
    
    func getRestaurantDetail(restuarantId: String?) {
        if let token = accessToken  {
            if let id = restuarantId {
                let parameters = ["access_token" : token, "restaurantid": id]
                loginViewController.makeJsonCall("users/getRestaurant", params: parameters) {responseCode, responseJson, error in
                    print("getMatches results")
                    print(responseCode)
                    //                    print("JSON: \(responseJson)")
                    print(error)
                    if let image_url = responseJson["image_url"].string {
                        if let imgURL = NSURL(string: image_url.stringByReplacingOccurrencesOfString("ms.jpg", withString: "o.jpg")) {
                            self.imageView?.image = UIImage(named: "Blank52")
                            let session = NSURLSession.sharedSession()
                            let request: NSURLRequest = NSURLRequest(URL: imgURL)
                            let dataTask = session.dataTaskWithRequest(request) {
                                (data: NSData?, response: NSURLResponse?, error: NSError?)
                                -> Void in
                                if error == nil && data != nil {
                                    let image = UIImage(data: data!)
                                    dispatch_async(dispatch_get_main_queue(), {
                                            self.imageView?.image = image
                                    })
                                }
                                else {
                                    print("Error: \(error!.localizedDescription)")
                                }
                            }
                            dataTask.resume()
                            
                        }
                        
                    }
                    if let name = responseJson["name"].string {
                        self.restaurantLabel.text = name
                    }
                    if let location = responseJson["location"].dictionary {
                        if let address = location["display_address"] {
                            self.addressLabel.text = "\(address[0])"
                        }
                        if let coords = location["coordinate"] {
                            if let restaurantLat = coords["latitude"].double, restaurantLong = coords["longitude"].double {
                                if let coordinates = self.location.coordinate as? CLLocationCoordinate2D {
                                    let fromLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                                    let toLocation = CLLocation(latitude: restaurantLat, longitude: restaurantLong)
                                    let distance = Double(round(fromLocation.distanceFromLocation(toLocation) / self.metersToMiles * 10) / 10)
                                    self.distanceLabel.text = "\(distance) mi. away"
                                }
                            }
                        }
                        
                    }
                    
                    if let isClosed = responseJson["is_closed"].bool {
                        if isClosed {
                            self.hoursLabel.text = "Closed"
                            self.hoursLabel.textColor = UIColor.redColor()
                        } else {
                            self.hoursLabel.text = "Open!"
                            self.hoursLabel.textColor = UIColor.greenColor()
                        }
                    }
                }
            } else {
                print("Error: No restaurant id")
            }
        } else {
            print("Error: No access token")
        }
    }
}
