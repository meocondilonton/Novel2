//
//  DetailInfoStoryHeaderCell.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/5/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class DetailInfoStoryHeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var lblNumRate: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    
    @IBOutlet weak var lblTitleStory: UILabel!
    
    @IBOutlet weak var lblAuthorStory: FRHyperLabel!
    
    @IBOutlet weak var lblCategoryStory: FRHyperLabel!
    
    @IBOutlet weak var lblStatusSory: FRHyperLabel!
    
    @IBOutlet weak var lblSeriesStory: FRHyperLabel!
    
    @IBOutlet weak var lblViewStory: UILabel!
    
    @IBOutlet weak var btnRead: UIButton!

    @IBOutlet weak var btnSave: UIButton!
    
    private var block:((Int)->())?
    
    func updateData(info:StoryFullInfoModel , block:((Int)->())?){
        self.block = block
         self.lblTitleStory.text = info.storyName
        let originalUrl = String(format: "%@%@", BaseUrl,info.storyImgUrl  ?? "")
        let imgCoverUrl = NSURL(string: originalUrl)
         self.imgCover.sd_setImageWithURL(imgCoverUrl, placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions.RetryFailed)
    
        let hyperTextColor = UIColor.blackColor()
        let hyperTextFont = UIFont.boldSystemFontOfSize(12)
        
        let nomalTextFont = UIFont.systemFontOfSize(12)
        
        let arrFont = [nomalTextFont, hyperTextFont]
        let arrColor = [hyperTextColor,hyperTextColor]
        
       
        
        let arrAuthor:NSArray =  NSArray(arrayLiteral: "Author: ", info.storyAuthor?.itemName ?? "")
        let arrSeries:NSArray =  NSArray(arrayLiteral: "Series: ", info.storySeries?.itemName ?? "")
        let arrStatus:NSArray =  NSArray(arrayLiteral: "Status: ", info.storyStatus?.itemName ?? "")
         let arrView:NSArray =  NSArray(arrayLiteral: "View: ", info.storyView  ?? "")
        
        let arrFontCategory = NSMutableArray()
        let arrColorCategory = NSMutableArray()
        let arrCategory = NSMutableArray()
         arrFontCategory.addObject(nomalTextFont)
         arrColorCategory.addObject(hyperTextColor)
         arrCategory.addObject("Category: ")
        if  info.storyCategory?.count > 0 {
        for item in info.storyCategory! {
            arrFontCategory.addObject(hyperTextFont)
            arrColorCategory.addObject(hyperTextColor)
            arrCategory.addObject(item.itemName ?? "")
        }
             self.lblCategoryStory.attributedText =  Utils.attributeStringForTexts(arrCategory, fonts: arrFontCategory as! [UIFont], colors: arrColorCategory as! [UIColor], separator: "")
        }
        self.lblAuthorStory.attributedText = Utils.attributeStringForTexts(arrAuthor, fonts: arrFont, colors: arrColor, separator: "")
        self.lblSeriesStory.attributedText =  Utils.attributeStringForTexts(arrSeries, fonts: arrFont, colors: arrColor, separator: "")
         self.lblStatusSory.attributedText =  Utils.attributeStringForTexts(arrStatus, fonts: arrFont, colors: arrColor, separator: "")
         self.lblViewStory.attributedText =  Utils.attributeStringForTexts(arrView, fonts: arrFont, colors: arrColor, separator: "")
        
        self.lblNumRate.text = info.storyRate ?? "0"
        self.lblNumRate.layer.cornerRadius = self.lblNumRate.frame.size.width/2
        self.lblNumRate.layer.borderWidth = 2
        self.lblNumRate.layer.borderColor = bgLightGrayColor.CGColor
        
        self.btnSave.layer.cornerRadius = 5
        self.btnSave.layer.masksToBounds = true
        
        self.btnRead.layer.cornerRadius = 5
        self.btnRead.layer.masksToBounds = true
        
    }
   
    @IBAction func btnReadTouch(sender: AnyObject) {
        if self.block != nil {
            self.block!(0)
        }
    }
    
    @IBAction func btnSaveTouch(sender: AnyObject) {
        if self.block != nil {
            self.block!(1)
        }
    }
    
    

}
