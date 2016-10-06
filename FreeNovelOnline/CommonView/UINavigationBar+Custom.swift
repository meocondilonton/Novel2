//
//  UINavigationBar+Custom.swift
//  TravelSmart
//
//  Created by Nguyen Phi Long on 8/17/15.
//  Copyright (c) 2015 Long Ngo Huynh. All rights reserved.
//

import UIKit

extension  UINavigationBar {
    
    enum State {
        case Empty
        case Back
        case Edit
        case BackAndDelete
        case BackAndSave
        case BackAndAdd
        case LeftMenuAndSettingClosed
        case BackTranparent
        case DissmissAndSave
    }
    
    func setDefault (state : State, vc :UIViewController) {
        
        self.translucent = false
        self.setBackgroundImage(UIImage(named: "icon-head"), forBarMetrics: .Default)
//        self.backgroundColor = bgNaColor
//        self.barTintColor = bgNaColor
        let textAttributes = NSMutableDictionary(capacity:1)
        textAttributes.setObject(UIColor.whiteColor(), forKey: NSForegroundColorAttributeName)
       
        textAttributes.setObject(UIFont.systemFontOfSize(20) , forKey: NSFontAttributeName)
        self.titleTextAttributes = textAttributes.mutableCopy() as? [String : AnyObject]
        self.setTitleVerticalPositionAdjustment(4, forBarMetrics: UIBarMetrics.Default)
        //TODO:
        switch state
        {
        case State.Empty :
            let buttonBack = UIButton(frame: CGRectMake(0, 0, 50, 40))
            buttonBack.setImage(UIImage(named: ""), forState: UIControlState.Normal)
            buttonBack.contentEdgeInsets = UIEdgeInsetsMake(0, -37, -5, 0);
            let backBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
            vc.navigationItem.setLeftBarButtonItem(backBarButtonItemEdit, animated: false)
           
            break
        case State.Back :
            let buttonBack = UIButton(frame: CGRectMake(0, 0, 50, 40))
            buttonBack.setImage(UIImage(named: "btn_back"), forState: UIControlState.Normal)
            buttonBack.addTarget(vc, action: #selector(BaseViewController.btnBackTouch) , forControlEvents:  UIControlEvents.TouchUpInside)
            buttonBack.contentEdgeInsets = UIEdgeInsetsMake(0, -37, -5, 0);
            let backBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
            vc.navigationItem.setLeftBarButtonItem(backBarButtonItemEdit, animated: false)
             break
        case State.Edit :
            let buttonBack = UIButton(frame: CGRectMake(0, 0, 50, 40))
            buttonBack.setImage(UIImage(named: ""), forState: UIControlState.Normal)
            buttonBack.contentEdgeInsets = UIEdgeInsetsMake(0, -37, -5, 0);
            let backBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
            vc.navigationItem.setLeftBarButtonItem(backBarButtonItemEdit, animated: false)
            
            
            let buttonSave = UIButton(frame: CGRectMake(0, 0, 35, 35))
            buttonSave.contentEdgeInsets = UIEdgeInsetsMake(0, 0, -5, 0)
            buttonSave.setImage(UIImage(named: "ic_menu_settings"), forState: UIControlState.Normal)
            buttonSave.addTarget(vc, action: #selector(BaseViewController.btnEditTouch) , forControlEvents:  UIControlEvents.TouchUpInside)
            let shareBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonSave)
            vc.navigationItem.setRightBarButtonItem(shareBarButtonItemEdit, animated: false)
            break
        case State.BackAndSave :
            let buttonBack = UIButton(frame: CGRectMake(0, 0, 30, 40))
            buttonBack.setImage(UIImage(named: "btn_back"), forState: UIControlState.Normal)
            buttonBack.addTarget(vc, action: #selector(BaseViewController.btnBackTouch) , forControlEvents:  UIControlEvents.TouchUpInside)
            buttonBack.contentEdgeInsets = UIEdgeInsetsMake(0, -17, -5, 0)
            let backBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
            vc.navigationItem.setLeftBarButtonItem(backBarButtonItemEdit, animated: false)
            
            let buttonSave = UIButton(frame: CGRectMake(0, 0, 15, 12))
            buttonSave.contentEdgeInsets = UIEdgeInsetsMake(0, 0, -5, 0)
            buttonSave.setImage(UIImage(named: "icon-check_navi"), forState: UIControlState.Normal)
             buttonSave.addTarget(vc, action: #selector(BaseViewController.btnSaveTouch) , forControlEvents:  UIControlEvents.TouchUpInside)
            let shareBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonSave)
            vc.navigationItem.setRightBarButtonItem(shareBarButtonItemEdit, animated: false)
             break
            
        case State.BackAndDelete :
            let buttonBack = UIButton(frame: CGRectMake(0, 0, 30, 40))
            buttonBack.setImage(UIImage(named: "btn_back"), forState: UIControlState.Normal)
            buttonBack.addTarget(vc, action: #selector(BaseViewController.btnBackTouch) , forControlEvents:  UIControlEvents.TouchUpInside)
            buttonBack.contentEdgeInsets = UIEdgeInsetsMake(0, -17, -5, 0)
            let backBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
            vc.navigationItem.setLeftBarButtonItem(backBarButtonItemEdit, animated: false)
            
            let buttonSave = UIButton(frame: CGRectMake(0, 0, 15, 12))
            buttonSave.contentEdgeInsets = UIEdgeInsetsMake(0, 0, -5, 0)
            buttonSave.setImage(UIImage(named: "icon_delete"), forState: UIControlState.Normal)
            buttonSave.addTarget(vc, action: #selector(BaseViewController.btnDeleteTouch) , forControlEvents:  UIControlEvents.TouchUpInside)
            let shareBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonSave)
            vc.navigationItem.setRightBarButtonItem(shareBarButtonItemEdit, animated: false)
            break
        case State.BackAndAdd :
            let buttonBack = UIButton(frame: CGRectMake(0, 0, 50, 40))
            buttonBack.setImage(UIImage(named: "btn_back"), forState: UIControlState.Normal)
              buttonBack.addTarget(vc, action: #selector(BaseViewController.btnBackTouch) , forControlEvents:  UIControlEvents.TouchUpInside)
            buttonBack.contentEdgeInsets = UIEdgeInsetsMake(0, -37, -5, 0)
            let backBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
            vc.navigationItem.setLeftBarButtonItem(backBarButtonItemEdit, animated: false)
            
            let buttonAdd = UIButton(frame: CGRectMake(0, 0, 14, 14))
            buttonAdd.contentEdgeInsets = UIEdgeInsetsMake(0, 0, -5, 0)
            buttonAdd.setImage(UIImage(named: "icon-plus"), forState: UIControlState.Normal)
             buttonAdd.addTarget(vc, action: #selector(BaseViewController.btnAddTouch) , forControlEvents: UIControlEvents.TouchUpInside)
            let shareBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonAdd)
            vc.navigationItem.setRightBarButtonItem(shareBarButtonItemEdit, animated: false)
             break
        case State.LeftMenuAndSettingClosed :
            let buttonBack = UIButton(frame: CGRectMake(0, 0, 50, 40))
            buttonBack.setImage(UIImage(named: "menu-icon"), forState: UIControlState.Normal)
            buttonBack.addTarget(vc, action: "btnLeftMenu", forControlEvents: UIControlEvents.TouchUpInside)
            buttonBack.contentEdgeInsets = UIEdgeInsetsMake(0, -28, -5, 0);
            let backBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
            
            let buttonAdd = UIButton(frame: CGRectMake(0, 0, 40, 40))
            buttonAdd.contentEdgeInsets = UIEdgeInsetsMake(0, 20, -5, 0)
            buttonAdd.setImage(UIImage(named: "icon-close"), forState: UIControlState.Normal)
            buttonAdd.addTarget(vc, action: #selector(BaseViewController.btnClosedTouch) , forControlEvents: UIControlEvents.TouchUpInside)
            let shareBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonAdd)
            
            let buttonSetting = UIButton(frame: CGRectMake(0, 0, 10, 15))
            buttonSetting.contentEdgeInsets = UIEdgeInsetsMake(0,  0, -5, -10)
            buttonSetting.setImage(UIImage(named: "icon-setting"), forState: UIControlState.Normal)
            buttonSetting.addTarget(vc, action: #selector(BaseViewController.btnSettingTouch) , forControlEvents: UIControlEvents.TouchUpInside)
            let settingBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonSetting)
            
             vc.navigationItem.setRightBarButtonItems([ shareBarButtonItemEdit ,settingBarButtonItemEdit], animated: false)
            

            vc.navigationItem.setLeftBarButtonItem(backBarButtonItemEdit, animated: false)
             self.translucent = false
            break
        case State.BackTranparent :
            let buttonBack = UIButton(frame: CGRectMake(0, 0, 50, 40))
            buttonBack.setImage(UIImage(named: "btn_back"), forState: UIControlState.Normal)
              buttonBack.addTarget(vc, action: #selector(BaseViewController.btnBackTouch) , forControlEvents:  UIControlEvents.TouchUpInside)
            buttonBack.contentEdgeInsets = UIEdgeInsetsMake(0, -37, -5, 0);
            let backBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
            vc.navigationItem.setLeftBarButtonItem(backBarButtonItemEdit, animated: false)
            self.translucent = true
            self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            self.shadowImage = UIImage()
             break
        case State.DissmissAndSave:
            let buttonBack = UIButton(frame: CGRectMake(0, 0, 30, 40))
            buttonBack.setImage(UIImage(named: "icon-close"), forState: UIControlState.Normal)
              buttonBack.addTarget(vc, action: #selector(BaseViewController.btnBackTouch) , forControlEvents:  UIControlEvents.TouchUpInside)
            buttonBack.contentEdgeInsets = UIEdgeInsetsMake(0, -17, -5, 0)
            let backBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
            vc.navigationItem.setLeftBarButtonItem(backBarButtonItemEdit, animated: false)
            
            let buttonSave = UIButton(frame: CGRectMake(0, 0, 15, 12))
            buttonSave.contentEdgeInsets = UIEdgeInsetsMake(0, 0, -5, 0)
            buttonSave.setImage(UIImage(named: "icon-check_navi"), forState: UIControlState.Normal)
//            buttonSave.addTarget(vc, action: "btnSaveTouch", forControlEvents: UIControlEvents.TouchUpInside)
            buttonSave.addTarget(vc, action: #selector(BaseViewController.btnSaveTouch), forControlEvents: UIControlEvents.TouchUpInside)
            let shareBarButtonItemEdit: UIBarButtonItem = UIBarButtonItem(customView: buttonSave)
            vc.navigationItem.setRightBarButtonItem(shareBarButtonItemEdit, animated: false)
            break
        }
    }
    
 
}
