//
//  MatchesViewController.swift
//  tinderForFood
//
//  Created by Edward Yun on 11/19/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit
import SwiftyJSON

class MatchesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    private let reuseIdentifier = "matchCell"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let segueIdentifer = "restaurantSegue"
    
    let loginViewController = LoginViewController()
    let foodViewController = FoodViewController()
    var accessToken: String?
    
    var width:CGFloat = 0.0
    
    var matches: [Business] = []
    var imageCache = [String : UIImage]()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Matches"
        
        accessToken = NSUserDefaults.standardUserDefaults().objectForKey("access_token") as? String
        
        getRestaurants()
        
    }
    
    // MARK: Emma's stuff
    func getRestaurants() {
        if let token = accessToken {
            let parameters = ["access_token": token]
            loginViewController.makeJsonCall("users/getRestaurants", params: parameters) { responseCode, responseJson, error in
                print(responseCode)
                print(responseJson)
                print(error)
                self.loadMatches(responseJson)
            }
        } else {
            print("Error: No access token")
        }
        print(matches)
        
    }
    
    func getRestaurantDetail(restuarantId: String) {
        if let token = accessToken  {
            let parameters = ["access_token" : token, "restaurantid": restuarantId]
            loginViewController.makeJsonCall("users/getRestaurant", params: parameters) {responseCode, responseJson, error in
                print("getMatches results")
                print(responseCode)
                print(responseJson)
                print(error)
            }
        } else {
            print("Error: No access token")
        }
    }
    
    func loadMatches(restaurants: JSON) {
        if let businesses = restaurants.array {
            var counter:Int = 0
            for business in businesses {
                matches.append(Business(json: business))
                counter++
            }
        }
        self.collectionView.reloadData()
        
    }
    
    func downloadMatchImages(url: NSURL, index: Int) {
        //        print("Download Started")
        //        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        foodViewController.getDataFromUrl(url) { (data, response, error)  in
            // TODO: Change to HTTPS (and fix Info.plist)
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                //                print(response?.suggestedFilename ?? "")
                //                print("Download Finished")
                let image = UIImage(data: data)
                self.matches[index].image = image
                // SELF RELOAD
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueIdentifer {
            let svc = segue.destinationViewController as! RestaurantViewController
            svc.restaurantData = ["name": "Monell's", "address": "1234 Hello St", "distance": "1.2 mi away", "closingTime": "10pm"]
            
        }
    }
    
    //MARK: DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GalleryPhotoCell
        
        if let rowData: Business = self.matches[indexPath.row],
            urlString = rowData.image_url,
            imgURL = NSURL(string: urlString) {
                cell.imageView?.image = UIImage(named: "Blank52")
                if let img = imageCache[urlString] {
                    cell.imageView?.image = img
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
                                if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? GalleryPhotoCell {
                                    cellToUpdate.imageView?.image = image
                                }
                            })
                        }
                        else {
                            print("Error: \(error!.localizedDescription)")
                        }
                    }
                    dataTask.resume()
                    
                }
        }
        return cell

    }
    
        //MARK: Delegate
        func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
                performSegueWithIdentifier(segueIdentifer, sender: cell)
            }
            
        }
        
        
        //MARK: FlowLayoutDelegate
        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            
            return CGSize(width: 110, height: 110)
            
        }
        
        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
        }
        
        
}
