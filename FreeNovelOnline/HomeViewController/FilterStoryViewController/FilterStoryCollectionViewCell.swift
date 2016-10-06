//
//  FilterStoryCollectionViewCell.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/12/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class FilterStoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    
    func updateData(data:StoryInfoModel){
       
     
        self.imgView.image = UIImage(named: data.storyImgUrl!)
        self.lblDetail.text =  data.storyName ?? ""
        self.imgView.layer.cornerRadius = 10
        self.imgView.layer.masksToBounds = true
        self.imgView.superview?.layer.cornerRadius = 10
        self.imgView.superview?.layer.masksToBounds = true
    
    }
    
}
