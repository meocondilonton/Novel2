//
//  DiscoverNavigationBarCustom.swift
//  Clicks
//
//  Created by NguyenPhiLong on 4/5/16.
//  Copyright © 2016 Nexle Corporation. All rights reserved.
//

import UIKit

class DiscoverNavigationBarCustom: UINavigationBar {

    var customView:CommonMainNavigationView?
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var naviBarSize = super.sizeThatFits(size)
        let subViewSize  = self.customView?.sizeThatFits(CGSizeMake(size.width, 0))
        naviBarSize.height = subViewSize?.height ?? 44
        return naviBarSize
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
         let subViewSize  = self.customView?.sizeThatFits(CGSizeMake(self.bounds.size.width, 0))
         self.customView?.frame = CGRectMake(0, 0, self.bounds.size.width, subViewSize?.height ?? 44)
 
    }
    
    func setCustomSubView(customView:CommonMainNavigationView) {
        if self.customView != nil {
            self.customView!.removeFromSuperview()
        }
        self.customView = customView
        self.addSubview(self.customView!)
        self.invalidateIntrinsicContentSize()
        self.setNeedsLayout()
    }
}
