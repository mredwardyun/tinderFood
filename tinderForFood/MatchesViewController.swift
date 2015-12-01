//
//  MatchesViewController.swift
//  tinderForFood
//
//  Created by Edward Yun on 11/19/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit

class MatchesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet var collectionView: UICollectionView!
    
    private let reuseIdentifier = "matchCell"
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let segueIdentifer = "restaurantSegue"
    
    var width:CGFloat = 0.0
    
    private let images = ["monell1", "monell2", "monell3", "monell4", "monell5", ]
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Matches"

    }
    
    func photoForIndexPath(indexPath: NSIndexPath) -> UIImage? {
        
        if let image = UIImage(named: "monell1") {
//        if let image = UIImage(named: "monell\(indexPath.row + 1)") {
            return image
        }
        return nil
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
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GalleryPhotoCell
        let photo = photoForIndexPath(indexPath)
        cell.backgroundColor = UIColor.blackColor()
        cell.imageView.image = photo
        
        
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
