//
//  ViewController.swift
//  tinderForFood
//
//  Created by Edward Yun on 11/12/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit
import Koloda
import pop
import Alamofire
import SwiftyJSON
import CoreLocation

private let numberOfCards: UInt = 5
private let frameAnimationSpringBounciness:CGFloat = 9
private let frameAnimationSpringSpeed:CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent:CGFloat = 0

private var consumerKey = "8HPpfMDPraCnvdfY1aBY-A"
private var consumerSecret = "1xtpMhhk--CQDDz5v72AwMM_K1k"
private var token = "ireJLoBsAiflg_HSScggpFpKTZ1giE8S"
private var tokenSecret = "0hmsBuZ2hGtFTm80Gt-iveENveI"


let accessToken = NSUserDefaults.standardUserDefaults().objectForKey("access_token") as? String


class FoodViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var kolodaView: CustomFoodView!
    let locationManager = CLLocationManager()
    var location: CLLocation!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(accessToken)
        
        
        // CoreLocation
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        findNearbyRestaurants()
        
        // Koloda set up
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations[0] as CLLocation
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    // MARK: Networking (Alamofire)
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
    
    func findNearbyRestaurants() {
//        if self.location != nil {
            if accessToken != nil {
//                let lat = String(location.coordinate.latitude)
//                let long = String(location.coordinate.longitude)
                var params = ["access_token": accessToken!, "latitude": "40.20", "longitude": "-79.5"]
                print("json params: \(params)")
                makeJsonCall("findrestaurants", params: params) { responseCode, responseJson, error in
                    print("response code is \(responseCode)")
                    print("response json is \(responseJson)")
                    print("response error is \(error)")
                }
            } else {
                print("accessToken is nil")
            }
//        } else {
//            print("locationManager.location is nil")
//        }
    }
    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Right)
        findNearbyRestaurants()
        
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    
    //MARK: KolodaViewDataSource
    func kolodaNumberOfCards(koloda: KolodaView) -> UInt {
        return numberOfCards
    }
    
    func kolodaViewForCardAtIndex(koloda: KolodaView, index: UInt) -> UIView {
        return UIImageView(image: UIImage(named: "cards_\(index + 1)"))
    }
    func kolodaViewForCardOverlayAtIndex(koloda: KolodaView, index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("CustomOverlayView",
            owner: self, options: nil)[0] as? OverlayView
    }
    
    //MARK: KolodaViewDelegate
    
    func kolodaDidSwipedCardAtIndex(koloda: KolodaView, index: UInt, direction: SwipeResultDirection) {
    }
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        //Example: reloading
        kolodaView.resetCurrentCardNumber()
    }
    
    func kolodaDidSelectCardAtIndex(koloda: KolodaView, index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yalantis.com/")!)
    }
    
    func kolodaShouldApplyAppearAnimation(koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaBackgroundCardAnimation(koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation.springBounciness = frameAnimationSpringBounciness
        animation.springSpeed = frameAnimationSpringSpeed
        return animation
    }
    
    
}

