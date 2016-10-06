//
//  DetailInfoStoryViewController.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/5/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import Foundation
import GoogleMobileAds

class DetailInfoStoryViewController: BaseViewController {
    
    @IBOutlet weak var contraiHeightAd: NSLayoutConstraint!
    @IBOutlet weak var adView: GADNativeExpressAdView!
    @IBOutlet weak var tbView: UITableView!
    
    var request:GADRequest!
    
    var storyFullInfo:StoryFullInfoModel!
    var header:DetailInfoStoryHeaderCell!
    var footer:DetailInfoStoryFootererCell!
    
    var downloadProcess:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
                 request = GADRequest()
//                request.testDevices = [ "d64ea21fa3a976826d5d573adf99ffc8" ]
 
        
        self.tbView.registerNib(UINib(nibName: "DetailInfoStoryHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailInfoStoryHeaderCell")
         self.tbView.registerNib(UINib(nibName: "DetailInfoStoryFootererCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailInfoStoryFootererCell")
        
      self.compareWithSavedDatabse()
        

       
    }
    
    func compareWithSavedDatabse(){
     
       let storySaved =  DatabaseHelper.shareInstall().getStoryFullInfo( (self.storyFullInfo?.storyName)!)
        if storySaved != nil {
            self.storyFullInfo = storySaved
        }
        if self.storyFullInfo.isSaved == false {
              self.loadData()
        }else{
            self.tbView.reloadData()
        }
    }
    
    
    func loadData(){
        let param = NSMutableDictionary()
        let url = String(format: "%@%@",BaseUrl,self.storyFullInfo.storyUrl ?? "")
        
        param.setValue(url , forKey: keyUrl)
        BaseWebservice.shareInstance().getData(param, isShowIndicator: true) {[weak self] (result) in
            
            let doc = TFHpple(HTMLData: result)
            
            //read top
            let elements = doc.searchWithXPathQuery("//div[@class='detail-top']")
            for eleItem in elements {
                let e = eleItem as! TFHppleElement
                
                var count = 0
                for item in e.children {
                    count += 1
                    
                    //author
                    if count == 6 {
                        if let temp =  item as? TFHppleElement {
                            if temp.children.count > 1 {
                                if let childItemTemp = temp.children[1] as? TFHppleElement {
                                    
                                    self?.storyFullInfo.storyAuthor = Item()
                                    let origin = childItemTemp.objectForKey("href") ?? ""
                                    let urlString :String = origin.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                                    self?.storyFullInfo.storyAuthor?.itemUrl = urlString
                                    self?.storyFullInfo.storyAuthor?.itemName = childItemTemp.objectForKey("title")
                                    
                                }
                            }
                        }
                    }else if ( count == 8){  //category
                        if let temp =  item as? TFHppleElement {
                            var iCount = 0
                            self?.storyFullInfo.storyCategory = [Item]()
                            for _ in temp.children  {
                                
                                if iCount % 2 == 1 {
                                    if let childItemTemp = temp.children[iCount] as? TFHppleElement {
                                        let itemModel = Item()
                                        itemModel.itemName = childItemTemp.objectForKey("title")
                                        let origin = childItemTemp.objectForKey("href") ?? ""
                                        let urlString :String = origin.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                                        itemModel.itemUrl =  urlString
                                        self?.storyFullInfo.storyCategory?.append(itemModel)
                                        
                                    }
                                }
                                iCount += 1
                            }
                            
                            
                        }
                    }else if ( count == 10){  //status
                        if let temp =  item as? TFHppleElement {
                            var iCount = 0
                            for _ in temp.children  {
                                
                                if iCount % 2 == 1 {
                                    if let childItemTemp = temp.children[iCount] as? TFHppleElement {
                                        self?.storyFullInfo.storyStatus = Item()
                                        let origin = childItemTemp.objectForKey("href") ?? ""
                                        let urlString :String = origin.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                                        self?.storyFullInfo.storyStatus?.itemUrl = urlString
                                        self?.storyFullInfo.storyStatus?.itemName = childItemTemp.objectForKey("title")
                                        
                                    }
                                }
                                iCount += 1
                            }
                            
                            
                        }
                    }else if ( count == 12){  //series
                        if let temp =  item as? TFHppleElement {
                            var iCount = 0
                            for _ in temp.children  {
                                
                                if iCount % 2 == 1 {
                                    if let childItemTemp = temp.children[iCount] as? TFHppleElement {
                                        self?.storyFullInfo.storySeries = Item()
                                        let origin = childItemTemp.objectForKey("href") ?? ""
                                        let urlString :String = origin.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                                        self?.storyFullInfo.storySeries?.itemUrl = urlString
                                        self?.storyFullInfo.storySeries?.itemName = childItemTemp.objectForKey("title")
                                        
                                    }
                                }
                                iCount += 1
                            }
                            
                            
                        }
                    }else if ( count == 14){  //views
                        if let temp =  item as? TFHppleElement {
                            var iCount = 0
                            for _ in temp.children  {
                                
                                if iCount % 2 == 0 {
                                    if let childItemTemp = temp.children[iCount] as? TFHppleElement {
                                        let arr = childItemTemp.content.characters.split{$0 == " "}.map(String.init)
                                        
                                        let view: String? = arr.count > 1 ? arr[1] : nil
                                        self?.storyFullInfo.storyView = view
                                        
                                        
                                    }
                                }
                                iCount += 1
                            }
                            
                            
                        }
                    }
                    
                }
                
                
            }
            
            //read bot
            let elementsBot = doc.searchWithXPathQuery("//div[@class='detail-desc']")
            for eleItem in elementsBot {
                let e = eleItem as! TFHppleElement
                var info = ""
                for item in e.children {
                    if let temp =  item as? TFHppleElement {
                        
                        info.appendContentsOf(temp.content)
                        
                    }
                }
                self?.storyFullInfo.storyDescription = info
            }
            
            //read numrate
              let elementsRate = doc.searchWithXPathQuery("//span[@class='detail-rating-score']")
            
             for eleItem in elementsRate {
                  let e = eleItem as! TFHppleElement
                 self?.storyFullInfo.storyRate = e.content
                print(e.content)
            }
            self?.tbView.reloadData()
            
            //read chapter
            let elementsChap = doc.searchWithXPathQuery("//ul[@id='ztitle']")
            //            print(elementsChap)
            for eleItem in elementsChap {
                let e = eleItem as! TFHppleElement
                self?.storyFullInfo.storyChapter = [Item]()
                var count = 0
                for item in e.children {
                    if count % 2 == 1 {
                        if let temp =  item as? TFHppleElement {
                            for childItem in temp.children {
                                if let tempChild =  childItem as? TFHppleElement {
                                    let itemModel =  Item()
                                    itemModel.itemName = tempChild.objectForKey("title")
                                    let origin = tempChild.objectForKey("href") ?? ""
                                    let urlString :String = origin.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                                    itemModel.itemUrl = urlString
                                    self?.storyFullInfo.storyChapter?.append(itemModel)

                                }
                                
                            }
                            
                        }
                    }
                    count += 1
                }
                
            }
            
            
        }
        
    }
    
    func readStory(){
        if self.storyFullInfo.storyChapter == nil {
            return
        }
        self.storyFullInfo.timeSaved = NSDate().timeIntervalSince1970
        self.storyFullInfo.storyIsRead = true
        DatabaseHelper.shareInstall().inSertStoryFullInfoSaved(self.storyFullInfo)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ReadStoryViewController") as! ReadStoryViewController
         vc.storyFullInfo = self.storyFullInfo
          vc.navigationController?.hidesBarsOnTap = true
         vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func saveStory(){
        self.downloadProcess = 0
        if self.storyFullInfo.storyChapter == nil {
            return
        }
        self.storyFullInfo.isSaved = true
        DatabaseHelper.shareInstall().inSertStoryFullInfoSaved(self.storyFullInfo)
        
         
        let dispatch_group = dispatch_group_create()
        
        SVProgressHUD.showProgress(0, status: "Loading" ,maskType:.Gradient )
        var i:Float = 0
        for item in self.storyFullInfo.storyChapter! {
            i += 1
            dispatch_group_enter(dispatch_group)
            let param = NSMutableDictionary()
            
            let url = String(format: "%@%@",BaseUrl,item.itemUrl ?? "")
            param.setValue(url , forKey: keyUrl)
            param.setValue("\(i)" , forKey: "index")
            BaseWebservice().getData(param, isShowIndicator: false, block: {[weak self] (result) in
                dispatch_group_leave(dispatch_group)
                if let owner = self {
                 owner.downloadProcess += Float(( 1 / Float(owner.storyFullInfo.storyChapter!.count))   )
                print( owner.downloadProcess)
               
                SVProgressHUD.showProgress( owner.downloadProcess, status: "Loading" ,maskType:.Gradient)
                }
            })
        }
        
 
        dispatch_group_notify(dispatch_group, dispatch_get_main_queue()) { 
            SVProgressHUD.dismiss()
            self.header?.btnSave.hidden = true
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DetailInfoStoryViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        navigationController?.navigationBar.setDefault(UINavigationBar.State.Back, vc: self)
        let titleStory = self.storyFullInfo.storyName ?? ""
        navigationItem.title = titleStory
        
    }
}

extension DetailInfoStoryViewController :UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        return self.view.frame.size.width
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.header = self.tbView.dequeueReusableHeaderFooterViewWithIdentifier("DetailInfoStoryHeaderCell") as! DetailInfoStoryHeaderCell
        if self.storyFullInfo.isSaved {
            header?.btnSave.hidden = true
        }
        header?.updateData(self.storyFullInfo) { [weak self](type) in
            if type == 0 {
                self?.readStory()
            }else{
                self?.saveStory()
            }
        }
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        self.footer = self.tbView.dequeueReusableHeaderFooterViewWithIdentifier("DetailInfoStoryFootererCell") as! DetailInfoStoryFootererCell
         self.footer.adView.adUnitID = adUnitLarge
         self.footer.adView.rootViewController = self
         self.footer.adView.loadRequest(request)
        return footer
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailInfoStoryTableViewCell", forIndexPath: indexPath) as! DetailInfoStoryTableViewCell
        cell.updateData(self.storyFullInfo.storyDescription ?? "")
        return cell
    }
}





