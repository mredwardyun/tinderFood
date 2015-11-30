//
//  MatchesViewController.swift
//  tinderForFood
//
//  Created by Edward Yun on 11/19/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit

class MatchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Matches"
        let nib = UINib(nibName: "GalleryTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "galleryCell")

    }
    
    //MARK: TableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //TODO: Create table with multiple selections
    func tableView(tableView: UITableView, numberOfSectionsInTableView section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: GalleryTableViewCell = tableView.dequeueReusableCellWithIdentifier("galleryCell", forIndexPath: indexPath) as! GalleryTableViewCell
        let height = cell.bounds.height
        let width = cell.bounds.width
        cell.loadImages(rowHeight: height, rowWidth: width, leftImage: "cards_1", centerImage: "cards_2", rightImage: "cards_3")
        
        return cell
        
    }
    
    //MARK: TableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("You selected cell #\(indexPath.row)!")
        
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
