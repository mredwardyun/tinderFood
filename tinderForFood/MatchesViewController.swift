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
    
    private let images = ["monell1", "monell2", "monell3", "monell4", "monell5", ]
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Matches"

    }
    
    func photoForIndexPath(indexPath: NSIndexPath) -> UIImage? {
        
        
        if let image = UIImage(named: "monell\(indexPath.row + 1)") {
            return image
        }
        
        return nil
        
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
        print(photo?.size)
        cell.backgroundColor = UIColor.blackColor()
        cell.imageView.image = photo
        
        print("created cell")
        
        return cell

    }
    
    //MARK: Delegate
    
    
    //MARK: FlowLayoutDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
}
