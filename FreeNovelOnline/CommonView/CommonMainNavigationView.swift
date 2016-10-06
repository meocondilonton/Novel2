//
//  FakeNavigation.swift
//  Clicks
//
//  Created by NguyenPhiLong on 3/24/16.
//  Copyright © 2016 Nexle Corporation. All rights reserved.
//

import UIKit
import Masonry

let kFakeNavigationHeight:CGFloat = 98
enum NaviButtonClickType {
    case LeftFirst
    case LeftSecond
    case RightFirst
    case RightSecond
    
}

typealias NaviButtonHandleBlock = (type: NaviButtonClickType) -> ()
class CommonMainNavigationView: UIView {

    private var bgImage:UIImageView!
    private var leftBtn1:UIButton!
    private var rightBtn1:UIButton!
    private var rightBtn2:UIButton!
    
    var lblTitle:UILabel!
    private var lblDes:UILabel!
    var naviHandleBlock:NaviButtonHandleBlock?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.bgImage = UIImageView()
        self.bgImage.image = UIImage(named: "bg-head")
        self.addSubview(self.bgImage)
        
        self.bgImage.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self.mas_left).with().offset()(0)
            make.right.equalTo()(self.mas_right).with().offset()(0)
            make.top.equalTo()(self.mas_top).with().offset()(0)
            make.bottom.equalTo()(self.mas_bottom).with().offset()(0)
            
        }
         self.backgroundColor = bgNaColor
        
          self.styleDiscover()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
        self.bgImage = UIImageView()
        self.bgImage.image = UIImage(named: "bg-head")
        self.addSubview(self.bgImage)
        
        self.bgImage.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self.mas_left).with().offset()(0)
            make.right.equalTo()(self.mas_right).with().offset()(0)
            make.top.equalTo()(self.mas_top).with().offset()(0)
            make.bottom.equalTo()(self.mas_bottom).with().offset()(0)
            
        }
//        self.backgroundColor = bgNaColor
        
    }
    
    @IBInspectable var textType:Int = 0 {
        didSet {
            //0 : discover
            if textType == 0 {
                    self.styleDiscover()
                }
            }
        }
    
    var stringDes:String = "" {
        didSet {
            self.updateTextDes()
        }
    }
    
    func styleDiscover() {
        self.leftBtn1 = UIButton()
        self.leftBtn1.setImage(UIImage(named: "icon-filter" ), forState: UIControlState.Normal )
        self.leftBtn1.addTarget(self, action: #selector(CommonMainNavigationView.btnLeft1Touch), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.leftBtn1)
        
        
            self.leftBtn1.mas_makeConstraints { (make) -> Void in
                make.left.equalTo()(self.mas_left).with().offset()(11)
                make.top.equalTo()(self.mas_top).with().offset()(27)
                make.width.equalTo()(35)
                make.height.equalTo()(34)
                
            }
        
        self.rightBtn1 = UIButton()
        self.rightBtn1.setImage(UIImage(named: "icon-search_navi" ), forState: UIControlState.Normal )
        self.rightBtn1.addTarget(self, action: #selector(CommonMainNavigationView.btnRight1Touch), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.rightBtn1)
        
        
            self.rightBtn1.mas_makeConstraints { (make) -> Void in
                make.right.equalTo()(self.mas_right).with().offset()(-10)
                make.top.equalTo()(self.mas_top).with().offset()(27)
                make.width.equalTo()(32)
                make.height.equalTo()(32)
                
          
        }
        
        
        self.rightBtn2 = UIButton()
        self.rightBtn2.setImage(UIImage(named: "icon-filter" ), forState: UIControlState.Normal )
        self.rightBtn2.addTarget(self, action: #selector(CommonMainNavigationView.btnRight2Touch), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.rightBtn2)
       
            self.rightBtn2.mas_makeConstraints { (make) -> Void in
                make.right.equalTo()(self.rightBtn1.mas_left).with().offset()(-15)
                make.top.equalTo()(self.mas_top).with().offset()(27)
                make.width.equalTo()(32)
                make.height.equalTo()(32)
                
            }
       
         self.rightBtn2.hidden = true
        
        self.setUpTitle()
//        self.setUpLine()
//        self.setUpDes()
    }
    
    //setup layout
    private func setUpTitle() {
        self.lblTitle = UILabel()
        self.lblTitle.textColor = UIColor.whiteColor()
        
        self.lblTitle.font = UIFont.systemFontOfSize(20)
        self.lblTitle.textAlignment = NSTextAlignment.Center
        self.addSubview(self.lblTitle)
        
             self.lblTitle.mas_makeConstraints { (make) -> Void in
                make.top.equalTo()(self.mas_top).with().offset()(35)
                make.right.equalTo()(self.mas_right).with().offset()(-80)
                make.left.equalTo()(self.mas_left).with().offset()(80)
                make.height.equalTo()(22)
                
            }
        
        
    }

    
    private func setUpLine() {
        
            let lineLeft = UIImageView()
            lineLeft.image = UIImage(named: "line")
            self.addSubview(lineLeft)
            
            lineLeft.mas_makeConstraints { (make) -> Void in
                make.top.equalTo()(self.rightBtn2.mas_bottom).with().offset()(11)
                make.left.equalTo()(self.mas_left).with().offset()(15)
                make.height.equalTo()(1)
                make.right.equalTo()(self.mas_right).with().offset()(15)
                
            }
            
        
        
    }
    
    private func setUpDes() {
        self.lblDes = UILabel()
        self.lblDes.textColor = UIColor.whiteColor()
        
        self.lblDes.font =  UIFont.systemFontOfSize( 14)
        self.lblDes.textAlignment = NSTextAlignment.Left
        self.lblDes.numberOfLines = 1
        self.addSubview(self.lblDes)
        
        
            self.lblDes.mas_makeConstraints { (make) -> Void in
                make.top.equalTo()(self.mas_top).with().offset()(76)
                make.left.equalTo()(self.mas_left).with().offset()(15)
                make.right.equalTo()(self.mas_right).with().offset()(-15)
                make.height.equalTo()(16)
                
            }
        
    }
    
    func updateTextDes() {
        self.lblDes.text = self.stringDes

    }
    
     func runText() {
        let offset = self.lblDes.frame.size.width +  self.lblDes.frame.origin.x < 0 ? self.frame.size.width : self.lblDes.frame.origin.x - 2
        
      self.lblDes.mas_updateConstraints { (make) -> Void in
            make.left.equalTo()(self.mas_left).with().offset()(offset)
        }
        
         self.performSelector(#selector(CommonMainNavigationView.runText), withObject: self, afterDelay: 0.05)
    }
    
   //handle taget
    func btnLeft1Touch() {
        if self.naviHandleBlock != nil {
            self.naviHandleBlock!(type:NaviButtonClickType.LeftFirst)
        }
    }

    func btnRight1Touch() {
        if self.naviHandleBlock != nil {
            self.naviHandleBlock!(type:NaviButtonClickType.RightFirst)
        }
    }

    func btnRight2Touch() {
        if self.naviHandleBlock != nil {
            self.naviHandleBlock!(type:NaviButtonClickType.RightSecond)
        }
    }
    
    
    deinit {
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
    }
    
}
