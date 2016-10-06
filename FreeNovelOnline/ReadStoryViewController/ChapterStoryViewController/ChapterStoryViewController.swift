//
//  ChapterStoryViewController.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/8/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import MFSideMenu
import GoogleMobileAds

class ChapterStoryViewController: BaseViewController {

    @IBOutlet weak var tbView: UITableView!
    
    var block:((Int)->())?
    var arrChapter:[Item]?
    var chapSelected:Int = 0
    var numAd:Int = 0
    
    var request:GADRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        request = GADRequest()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func updateChapter(arrChapter:[Item]?,chapSelected:Int, block:((Int)->())?){
        self.chapSelected = chapSelected
        self.block = block
        self.arrChapter = arrChapter
        self.tbView.reloadData()
    }

}

extension ChapterStoryViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        navigationController?.navigationBar.setDefault(UINavigationBar.State.Empty, vc: self)
        let titleStory = "Chapters"
        navigationItem.title = titleStory
        
    }
}

extension ChapterStoryViewController :UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrChapter?.count ?? 0
        let count = self.arrChapter?.count ?? 0
        print("numbook: \(count)")
        numAd = count/12
        return (count + numAd) ?? 0
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row % 12 == 0  && indexPath.row > 0{
            return 80
        }
        return 50
    }
    
 
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let numAdCurrent =  indexPath.row/12
        if indexPath.row % 12 == 0 && indexPath.row > 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("AdTableViewCell", forIndexPath: indexPath) as! AdTableViewCell
             cell.nativeExpressAdView.rootViewController = self
             cell.nativeExpressAdView.adUnitID = adUnitSmall
             cell.nativeExpressAdView.loadRequest(request)
            return cell
            
        }else{
        let cell = tableView.dequeueReusableCellWithIdentifier("ChapterTableViewCell", forIndexPath: indexPath) as! ChapterTableViewCell
          let arrIndex = indexPath.row - numAdCurrent
            cell.updateData(self.arrChapter?[arrIndex])
            if indexPath.row ==  self.chapSelected {
                cell.setCellSelect(true )
            }else{
                cell.setCellSelect(false )
            }
         
        return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tbView.cellForRowAtIndexPath(indexPath)
        if cell != nil {
            if cell!.isKindOfClass(ChapterTableViewCell) {
                
                self.menuContainerViewController.setMenuState(MFSideMenuStateClosed) {
                }
                
                if indexPath.row < self.arrChapter?.count  &&   indexPath.row % 12 != 0  || indexPath.row == 0 {
                    let cell = tableView.cellForRowAtIndexPath(indexPath)  as! ChapterTableViewCell
                    
                    let oldIndexPath = NSIndexPath(forItem: self.chapSelected, inSection: 0)
                    let oldCell =  tableView.cellForRowAtIndexPath(oldIndexPath)  as? ChapterTableViewCell
                    if oldCell != nil {
                        oldCell?.setCellSelect(false)
                    }
                    let numAdCurrent =  indexPath.row/12
                    let arrIndex = indexPath.row - numAdCurrent
                    self.chapSelected = arrIndex
                    cell.setCellSelect(true )
                    
                    if block != nil {
                        self.block!(arrIndex)
                    }
                }
            }
        }
      
        
    }
}
