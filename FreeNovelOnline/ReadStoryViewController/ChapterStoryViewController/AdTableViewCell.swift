//
//  AdTableViewCell.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/27/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdTableViewCell: UITableViewCell {

    @IBOutlet weak var nativeExpressAdView: GADNativeExpressAdView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
