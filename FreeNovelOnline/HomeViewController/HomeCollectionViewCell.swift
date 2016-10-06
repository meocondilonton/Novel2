//
//  HomeCollectionViewCell.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 8/31/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vBlur: UIView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    var isEdit:Bool = false
    
    func updateData(data:StoryInfoModel){
        btnCheck.layer.cornerRadius = btnCheck.frame.size.width/2
        btnCheck.clipsToBounds = true
        btnCheck.layer.masksToBounds = true
        btnCheck.hidden = !isEdit
        vBlur.hidden = !isEdit
        
        if let imgUrl = data.storyImgUrl {
            let originalUrl = String(format: "%@%@", BaseUrl,imgUrl)
       
            let imgCoverUrl = NSURL(string: originalUrl)
        self.imgView.sd_setImageWithURL(imgCoverUrl, placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions.RetryFailed)
        }
         self.lblDetail.text =  data.storyName ?? ""
    }
    
    func selectToDelete(isDelete:Bool){
        isEdit = isDelete
        btnCheck.layer.cornerRadius = btnCheck.frame.size.width/2
        btnCheck.clipsToBounds = true
        btnCheck.layer.masksToBounds = true
        btnCheck.hidden = !isEdit
        vBlur.hidden = !isEdit
    }
    
}
