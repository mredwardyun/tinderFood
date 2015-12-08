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

let loginViewController = LoginViewController()


class FoodViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var kolodaView: CustomFoodView!
    let locationManager = CLLocationManager()
    var location: CLLocation!
    
    var loadedBusinesses: [Business] = []
    var accessToken: String?
    var imageCache = [String : UIImage]()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        accessToken = NSUserDefaults.standardUserDefaults().objectForKey("access_token") as? String
        print(accessToken)
        
        // CoreLocation
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        // TODO: Callbacks
        //        addRestaurant()
        //        deleteRestaurant()
        //        getRestaurants()
        
        // Koloda set up
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.location == nil {
            self.location = locations[0] as CLLocation
            findNearbyRestaurants()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    // MARK: Networking (Alamofire)
    func findNearbyRestaurants() {
        if self.location != nil {
            if accessToken != nil {
                let lat = String(location.coordinate.latitude)
                let long = String(location.coordinate.longitude)
                let params = ["access_token": accessToken!, "latitude": lat, "longitude": long]
                print("json params: \(params)")
                loginViewController.makeJsonCall("users/findrestaurants", params: params) { responseCode, responseJson, error in
                    print("response code is \(responseCode)")
                    //print("response json is \(responseJson)")
                    print("response error is \(error)")
                    self.loadRestaurants(responseJson)
                }
            } else {
                print("accessToken is nil")
            }
        } else {
            print("locationManager.location is nil: \(self.location)")
        }
    }
    
    func loadRestaurants(restaurants: JSON) {
        if let businesses = restaurants.array {
            var counter:Int = 0
            for business in businesses {
                let myBusiness = Business(json: business)
                if let string = myBusiness.image_url {
                    if let url = NSURL(string: string.stringByReplacingOccurrencesOfString("ms.jpg", withString: "ls.jpg")) {
                        downloadImage(url, index: counter)
                    } else {
                        print("Url invalid: \(NSURL(string: string))")
                    }
                } else {
                    print ("String invalid: \(myBusiness.image_url)")
                }
                loadedBusinesses.append(Business(json: business))
                counter++
            }
            self.kolodaView.reloadData()
            print("loadedBusinesses: \(loadedBusinesses)")
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL, index: Int) {
//        print("Download Started")
//        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        getDataFromUrl(url) { (data, response, error)  in
            // TODO: Change to HTTPS (and fix Info.plist)
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
//                print(response?.suggestedFilename ?? "")
//                print("Download Finished")
                let image = UIImage(data: data)
                self.loadedBusinesses[index].image = image
            }
        }
    }
    
    // MARK: EMMA'S STUFF
    func addRestaurant(index: Int) {
        let restaurantId = loadedBusinesses[index].id!
        let parameters = ["access_token": accessToken!, "restaurantid": restaurantId]
        
        loginViewController.makeCall("users/addRestaurant", params: parameters) {responseCode, error in
            print("AddRestaurant results")
            print(responseCode)
            print(error)
        }
    }
    
    func deleteRestaurant(index: Int) {
        let restaurantId = loadedBusinesses[index].id!
        let parameters = ["access_token": accessToken!, "restaurantid": restaurantId]
        loginViewController.makeCall( "users/deleteRestaurant", params: parameters) {responseCode, error in
            print("DeleteRestaurant results")
            print(responseCode)
            print(error)
        }
    }

    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    
    //MARK: KolodaViewDataSource
    func kolodaNumberOfCards(koloda: KolodaView) -> UInt {
        return UInt(loadedBusinesses.count)
    }
    
    func kolodaViewForCardAtIndex(koloda: KolodaView, index: UInt) -> UIView {
//        let imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
////        if Int(index) < loadedBusinesses.count {
//            if let image = loadedBusinesses[Int(index)].image {
//                imageView.image = image
//                print("loading this business: \(loadedBusinesses[Int(index)].name) with image: \(loadedBusinesses[Int(index)].image_url)")
//            }
////        }
//        return imageView
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        if let rowData: Business = self.loadedBusinesses[Int(index)],
            urlString = rowData.image_url,
            imgURL = NSURL(string: urlString) {
                imageView.image = UIImage(named: "Blank52")
                if let img = imageCache[urlString] {
                    print("CACHED")
//                    imageView.image = img
                    kolodaView?.swipe(SwipeResultDirection.Right)
                }
                else {
                    let session = NSURLSession.sharedSession()
                    let request: NSURLRequest = NSURLRequest(URL: imgURL)
                    let dataTask = session.dataTaskWithRequest(request) {
                        (data: NSData?, response: NSURLResponse?, error: NSError?)
                        -> Void in
                        if error == nil && data != nil {
                            let image = UIImage(data: data!)
                            self.imageCache[urlString] = image
                            dispatch_async(dispatch_get_main_queue(), {
                                imageView.image = image
                            })
                        }
                        else {
                            print("Error: \(error!.localizedDescription)")
                        }
                    }
                    dataTask.resume()
                    
                }
        }
        return imageView
    }
    func kolodaViewForCardOverlayAtIndex(koloda: KolodaView, index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("CustomOverlayView",
            owner: self, options: nil)[0] as? OverlayView
    }
    
    //MARK: KolodaViewDelegate
    
    func kolodaDidSwipedCardAtIndex(koloda: KolodaView, index: UInt, direction: SwipeResultDirection) {
        print("adding restuarant: \(loadedBusinesses[Int(index)].name)")
        addRestaurant(Int(index))
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

extension UIImageView {
    
}

