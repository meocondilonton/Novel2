//
//  TabbarViewController.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 8/29/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       self.setUpTabbarItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TabbarViewController {
    func setUpTabbarItems() {
        self.viewControllers = self.getListScreens()
        self.tabBar.barTintColor = UIColor.whiteColor()
        self.tabBar.translucent = false
 
        let itemWidth:CGFloat = tabBar.frame.width / CGFloat(tabBar.items!.count)
        
        for index in 1...tabBar.items!.count {
            let separate = UIView(frame:CGRectMake( itemWidth * CGFloat(index) , 15, 1, 26))
            separate.backgroundColor = UIColor(red: 143.0/255.0, green: 166.0/255.0, blue: 198.0/255.0, alpha: 0.2)
            tabBar.addSubview(separate)
        }
    }
    
    func getListScreens() -> [UIViewController]! {
        func getVc(sotyboardName:String!, titleName: String!,className: String! , imageName:String , imageActive:String) -> UINavigationController {
            
            let storyboard = UIStoryboard(name: sotyboardName, bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier(className)
            let nav = UINavigationController(rootViewController: vc)
            
            nav.navigationBar.translucent = false
            nav.tabBarItem.title = titleName
            nav.tabBarItem.selectedImage = UIImage(named: imageActive)
                //?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            nav.tabBarItem.image = UIImage(named: imageName)
            nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3)
 
            
            return nav
        }
      
        
        let home = getVc("Main", titleName: "Discover" ,className: "HomeViewController" ,imageName:"discover" ,imageActive:"discover")
      
        let recent = getVc("Main", titleName: "Recent", className: "RecentViewController",imageName:"icon_save" ,imageActive:"icon_save")
        
        let saved = getVc("Main", titleName: "Saved", className: "SavedViewController",imageName:"community" ,imageActive:"community")
        
        
        
        
//        self.tabBar.backgroundImage = UIImage(named: "bg-menubar")
        self.tabBar.backgroundColor = bgLightGrayColor
        
        
        return [home, recent, saved]
    }
    
    
}
