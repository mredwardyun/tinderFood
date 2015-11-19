//
//  swiftyJsonViewController.swift
//  tinderForFood
//
//  Created by Nick Sparkman on 11/19/15.
//  Copyright (c) 2015 Edward Yun. All rights reserved.
//

import UIKit
import SwiftyJSON

class swiftyJsonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let json = JSON(data: dataFromNetworking)
        
        let json2 = JSON(jsonObject)
        
        if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
        }

        // Do any additional setup after loading the view.
    }

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
