//
//  ViewController.swift
//  tinderForFood
//
//  Created by Edward Yun on 11/12/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit
import pop
import Koloda
import SwiftyJSON

private let numberOfCards: UInt = 5
private let frameAnimationSpringBounciness:CGFloat = 9
private let frameAnimationSpringSpeed:CGFloat = 16
private let kolodaCountOfVisibleCards = 2
private let kolodaAlphaValueSemiTransparent:CGFloat = 0.1

class FoodViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate {
    
    @IBOutlet weak var kolodaView: KolodaView!

    @IBOutlet weak var myLabel: UILabel!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
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

