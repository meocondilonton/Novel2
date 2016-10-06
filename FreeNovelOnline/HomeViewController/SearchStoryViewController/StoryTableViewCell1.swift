//
//  StoryTableViewCell.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/11/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class StoryTableViewCell1: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgCover: UIImageView!
    
    @IBOutlet weak var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func uodateData( data:StoryInfoModel ) {
        if let imgUrl = data.storyImgUrl {
            let originalUrl = String(format: "%@%@", BaseUrl,imgUrl)
            let imgCoverUrl = NSURL(string: originalUrl)
            self.imgCover.sd_setImageWithURL(imgCoverUrl, placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions.RetryFailed)
        }
        self.lblContent.text =  data.storyName ?? ""
        
    }
}
