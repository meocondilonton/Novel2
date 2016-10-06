//
//  BaseViewController.swift
//  Clicks
//
//  Created by HLongNgo on 1/5/16.
//  Copyright © 2016 Nexle Corporation. All rights reserved.
//

import UIKit



typealias PushCompletedBlock =  (BaseViewController)-> ()

class BaseViewController: UIViewController , UIGestureRecognizerDelegate {
    
    var pushCompleted: PushCompletedBlock?
    var data: AnyObject? {
        didSet {
            self.dataDidSet(self.data)
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        return true
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
}

//MARK: - Life cycle

extension BaseViewController {
    override func viewDidAppear(animated: Bool) {
        print("----------------------------viewDidAppear:", self.classForCoder);
        super.viewDidAppear(animated)
       
        self.disableMutitouch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.setTextIntoComponents()
        self.setUpnotification()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.localize()
        if let pushCompleted = self.pushCompleted {
            pushCompleted(self)
        }
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if nil != self.pushCompleted {
            self.pushCompleted = nil
        }
    }
    
}

extension BaseViewController {
    func setUpnotification() {
        
    }
    
    func dismisKeyboard(){
        self.view.endEditing(true)
    }
    
    func disableMutitouch() {
        
        
        self.view.exclusiveTouch = true
        self.view.multipleTouchEnabled = false
        
        for v in self.view.subviews {
            v.exclusiveTouch = true
            v.multipleTouchEnabled = false
        }
    }
    
    func dataDidSet(data:AnyObject!) {
        
    }
    
    func setTextIntoComponents()
    {
        
    }
    
    func setUpNavigationBar() {
        
        
    }
    
    func btnBackTouch() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func btnSaveTouch() {
        
    }
    
    func btnDeleteTouch() {
        
    }
    
    func btnEditTouch() {
        
    }
    
    func btnLeftMenu() {
        
    }
    
    func localize(){
        
    }
    
    func btnAddTouch() {
        
    }
    
    func btnClosedTouch() {
        
    }
    
    func btnSettingTouch() {
        
    }
}

//MARK: - Utility func

extension BaseViewController {
    func getViewController(storyboardName storyboardName: String!, className: String!) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(className)
        return vc
    }
    
    func pushToViewController(storyboardName storyboardName: String!, className: String!, animation: Bool!, completed: PushCompletedBlock? = nil) {
        assert(storyboardName.characters.count > 0, "storyboard name cannot null")
        let vc = self.getViewController(storyboardName: storyboardName, className: className)
        self.pushCompleted = completed
        
        if let vctemp = self.navigationController?.viewControllers.last {
            if vctemp.isKindOfClass(NSClassFromString("Click."+className)!) {
                return
            }
        }
        if let vct = vc {
            vct.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vct , animated: animation)
        }
        
    }
    
    func parentPushToViewController(toVC: UIViewController?, animation: Bool!, completed: PushCompletedBlock? = nil) {
        self.pushCompleted = completed
        if let vct = toVC {
            vct.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vct , animated: animation)
        }
        
    }
    
    func getViewControllerInStackNavigation(classType: AnyClass) -> UIViewController? {
        var viewController: UIViewController!
        if let navigation = self.navigationController {
            for vc in navigation.viewControllers.reverse() {
                if vc.isKindOfClass(classType) {
                    viewController = vc
                    break
                }
            }
        }
        
        return viewController
    }
    
    
    
    @IBAction func dismissKeyBoardAction(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
 
}

 
