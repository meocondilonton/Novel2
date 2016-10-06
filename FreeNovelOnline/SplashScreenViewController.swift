//
//  SplashScreenViewController.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 10/3/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import MFSideMenu

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if Utils.isConnectedToNetwork() == false {
            self.switchMainScreen()
            return
        }
        let myURLString = "http://philong1.esy.es/freenovel.php"
        guard let myURL = NSURL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
             self.switchMainScreen()
            return
        }
        
        do {
            let myHTMLString:String = try String(contentsOfURL: myURL)
          let trimmed = myHTMLString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if trimmed == "true" {
                appdelegate.isTest = true
                  print("HTML : \(myHTMLString)")
            }
            self.switchMainScreen()
        } catch let error as NSError {
            print("Error: \(error)")
             self.switchMainScreen()
        }
    }
    
    func switchMainScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("ChapterStoryViewController") as! ChapterStoryViewController
        let leftNav = UINavigationController(rootViewController: leftViewController)
        
     appdelegate.tabbar = storyboard.instantiateViewControllerWithIdentifier("TabbarViewController") as! TabbarViewController
        
        appdelegate.slideMenuController = MFSideMenuContainerViewController.containerWithCenterViewController(appdelegate.tabbar, leftMenuViewController: leftNav, rightMenuViewController: nil)
        appdelegate.slideMenuController.menuContainerViewController.panMode = MFSideMenuPanModeNone
        if IS_IPHONE_5_OR_LESS {
            appdelegate.slideMenuController.leftMenuWidth = CGFloat(280)
        }
        appdelegate.window?.rootViewController = appdelegate.slideMenuController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
