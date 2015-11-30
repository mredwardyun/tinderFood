//
//  GalleryTableViewCell.swift
//  tinderForFood
//
//  Created by Edward Yun on 11/21/15.
//  Copyright © 2015 Edward Yun. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        
    }
    
    //TODO - Change to UICollectionView
    
    func loadImages(rowHeight rowHeight: CGFloat, rowWidth: CGFloat, leftImage: String, centerImage: String, rightImage: String) {
        
        let leftLoadedImage = UIImage(named: leftImage)
        let centerLoadedImage = UIImage(named: centerImage)
        let rightLoadedImage = UIImage(named: rightImage)
        
        let leftImageView = UIImageView(image: leftLoadedImage)
        let centerImageView = UIImageView(image: centerLoadedImage)
        let rightImageView = UIImageView(image: rightLoadedImage)
        
        let spacing = (rowWidth - (rowHeight * 3))/2
        
        leftImageView.frame = CGRect(x: 0, y: 0, width: rowHeight, height: rowHeight)
        centerImageView.frame = CGRect(x: rowHeight + spacing, y: 0, width: rowHeight, height: rowHeight)
        rightImageView.frame = CGRect(x: (rowHeight + spacing)*2, y: 0, width: rowHeight, height: rowHeight)
        
        self.addSubview(leftImageView)
        self.addSubview(centerImageView)
        self.addSubview(rightImageView)

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
