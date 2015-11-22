//
//  GalleryTableViewCell.swift
//  tinderForFood
//
//  Created by Edward Yun on 11/21/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        
    }
    
    func loadImage(title title: String, image: String) {
        
        let loadedImage = UIImage(named: image)
        backgroundImageView.image = loadedImage
        titleLabel.text = title
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
