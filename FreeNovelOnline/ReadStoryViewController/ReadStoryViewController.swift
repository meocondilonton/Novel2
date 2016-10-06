//
//  ViewController.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 8/18/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import MJRefresh
import MFSideMenu



class ReadStoryViewController: BaseViewController {
    //setting
    
    @IBOutlet weak var contraitTopSetting: NSLayoutConstraint!
    @IBOutlet weak var btnIncreaseText: UIButton!
    @IBOutlet weak var btnDecreaseText: UIButton!
    @IBOutlet weak var lblFontSizeText: UILabel!
    
    @IBOutlet weak var btnThemeLight: UIButton!
    @IBOutlet weak var btnThemeBlack: UIButton!
    
    @IBOutlet weak var slideLight: UISlider!
    
    @IBOutlet weak var vSetting: UIView!
    @IBOutlet weak var vTouch: UIView!
    //end
    
    @IBOutlet weak var webView: UIWebView!
    
    
    var dicSetting:NSMutableDictionary!
    var currentFonSize:Int = 100
    var currentTheme:Int = ThemeStyle.White.rawValue
    var currentLight:Float = 1
    var chapterIndex = 0
    var storyFullInfo:StoryFullInfoModel!
    var chapterOffset:Double = 0

  
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSetting()
        
        self.chapterOffset = self.storyFullInfo.chapterOffset
        self.chapterIndex = self.storyFullInfo.currentChapter
        
        self.webView.backgroundColor = UIColor.clearColor()
        self.webView.opaque = false
        self.webView.delegate = self
        
        self.setupLoadMoreAndPullRefresh()
        print(storyFullInfo.storyChapter![self.chapterIndex].itemUrl)
        self.loadChapterData(String(format:"%@%@",BaseUrl,storyFullInfo.storyChapter![self.chapterIndex].itemUrl!) )
        
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ReadStoryViewController.menuStateEventOccurred), name: MFSideMenuStateNotificationEvent, object: nil)
        
         let tap = UITapGestureRecognizer(target: self, action:#selector(ReadStoryViewController.hideNavigation))
        tap.delegate = self
        self.webView.addGestureRecognizer(tap)
        
     
  
    }
    
    func hideNavigation(){
        self.navigationController?.setNavigationBarHidden( !(self.navigationController?.navigationBarHidden ?? true), animated: true)

    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer.isKindOfClass(UITapGestureRecognizer.self) {
            otherGestureRecognizer.requireGestureRecognizerToFail(gestureRecognizer)
        }
        return true
    }
    
    func menuStateEventOccurred(noti:NSNotification){
        let event:UInt32 = UInt32(noti.userInfo!["eventType"]?.intValue ?? 0)
        if event == MFSideMenuStateEventMenuWillOpen.rawValue {
            (self.menuContainerViewController.leftMenuViewController!.childViewControllers[0] as! ChapterStoryViewController).updateChapter(self.storyFullInfo.storyChapter, chapSelected:self.chapterIndex) {[weak self] (index) in
                if index < self?.storyFullInfo?.storyChapter?.count {
                    self?.chapterIndex = index
                    self?.chapterOffset = 0
                    self?.loadChapterData(String(format:"%@%@",BaseUrl,(self?.storyFullInfo?.storyChapter![self?.chapterIndex ?? 0].itemUrl)!))
                }
            }
        }
        
    }
    
    func loadChapterData(page:String )  {
        
        let param = NSMutableDictionary()
       
        param.setValue(page, forKey: keyUrl)
        BaseWebservice.shareInstance().getData(param, isShowIndicator: true, block: { [weak self](result) in
            do {
                let doc = TFHpple(HTMLData: result)
                
                let elements = doc.searchWithXPathQuery("//div[@class='contents-comic']")
 
                var content = ""
                if elements.count > 0 {
                    let e = elements[0]
                    let childs = e.children
                     
                    for childE in childs {
                        let childEle = childE as! TFHppleElement
                        print(childEle.attributes["class"])
 
                        if childEle.attributes["class"]?.isEqualToString("adsmobiletop") == true  ||  childEle.attributes["class"]?.isEqualToString("adsfooter") == true {
                          
                        }else{
                            if  let raw = childEle.raw    {
                                content +=  raw
                                
                            }else{
                                if  let ct = childEle.content    {
                                    content +=  ct
                                    
                                }
                            }
                        }
 
                        
                    }
                    
                    let titleStory =  self?.storyFullInfo.storyChapter?[self?.chapterIndex ?? 0].itemName ?? ""
                    self?.navigationItem.title = titleStory
                    
//                    print(content)
                     let htmlString = String(format: "%@%@",   content,"<br><br> <br><br> <br><br> <br><br> <br><br> <br><br> <br><br> <br><br>  ")
                    self?.webView.loadHTMLString(htmlString, baseURL: nil)
                }
                
            }catch {
                print(error)
            }
            })
        
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
          NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}

extension ReadStoryViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.hidesBarsOnTap = false
         appdelegate.slideMenuController.menuContainerViewController.panMode = MFSideMenuPanModeDefault
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        navigationController?.navigationBar.setDefault(UINavigationBar.State.LeftMenuAndSettingClosed, vc: self)
        let titleStory =  storyFullInfo.storyChapter?[self.chapterIndex].itemName ?? ""
        navigationItem.title = titleStory
      
        
    }
    
   override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//          self.navigationController?.hidesBarsOnTap = false
    }
    
   override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

         appdelegate.slideMenuController.menuContainerViewController.panMode = MFSideMenuPanModeNone
    }
    
    override func btnLeftMenu() {
        super.btnLeftMenu()
        self.menuContainerViewController.setMenuState(MFSideMenuStateLeftMenuOpen) {
            
        }
       
        
    }
    
    override func btnClosedTouch() {
        super.btnClosedTouch()
        self.navigationController?.popViewControllerAnimated(true)
        self.storyFullInfo.currentChapter = self.chapterIndex
        self.storyFullInfo.chapterOffset = Double(self.webView.scrollView.contentOffset.y)
        DatabaseHelper.shareInstall().inSertStoryFullInfoSaved(self.storyFullInfo)
        
        self.dicSetting.setValue("\(self.currentFonSize)", forKey: keyFontSize)
        self.dicSetting.setValue("\(self.currentLight)", forKey: keyLight)
        self.dicSetting.setValue("\(self.currentTheme)", forKey: keyTheme)
        Utils.saveSettingReaderParam(self.dicSetting)
        let rand =  arc4random_uniform(10)
        if rand >= 5 {
            appdelegate.showInteristitial()
        }
    }
    
    override func btnSettingTouch() {
        super.btnSettingTouch()
        self.showSetting()
    }
}

extension ReadStoryViewController : UIWebViewDelegate {
    func setupLoadMoreAndPullRefresh() {
        
        let header = MJRefreshNormalHeader(refreshingBlock: {[weak self] () -> Void in
            if self?.chapterIndex > 0 {
                self?.chapterIndex -= 1
            }
            self?.chapterOffset = 0
            self?.loadChapterData(String(format:"%@%@",BaseUrl,(self?.storyFullInfo?.storyChapter![self?.chapterIndex ?? 0].itemUrl)!))
            })
        header.lastUpdatedTimeLabel!.hidden = true
        header.setTitle("Release To Load", forState: MJRefreshState.Pulling)
        header.setTitle("Load Previous Chapter...", forState: MJRefreshState.Refreshing)
        header.setTitle("Pull To Load Previous Chapter", forState: MJRefreshState.Idle)
        self.webView.scrollView.mj_header = header
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] () -> Void in
            if self?.chapterIndex < self?.storyFullInfo?.storyChapter?.count {
                self?.chapterIndex += 1
            }
            self?.chapterOffset = 0
            self?.loadChapterData( String(format:"%@%@",BaseUrl,(self?.storyFullInfo?.storyChapter![self?.chapterIndex ?? 0].itemUrl)!))
            })
        
        footer.setTitle("Loading New Chapter...", forState: MJRefreshState.Refreshing)
        footer.setTitle("No More Data...", forState: MJRefreshState.NoMoreData)
        footer.setTitle(" ", forState: MJRefreshState.Idle)
        
       
        self.webView.scrollView.mj_footer = footer
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear)
        
    }
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
        if self.webView.scrollView.mj_header.isRefreshing() == true {
            self.webView.scrollView.mj_header.endRefreshing()
        }
        if self.webView.scrollView.mj_footer.isRefreshing() == true {
            self.webView.scrollView.mj_footer.endRefreshing()
        }
          self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(self.currentFonSize)%%'")
         self.setTheme()
         self.webView.scrollView.contentOffset = CGPoint(x: 0, y: CGFloat(self.chapterOffset))
        
    }
    
    
}

//setting
extension ReadStoryViewController {
    func setupSetting(){
        let tap = UITapGestureRecognizer(target: self, action:#selector(ReadStoryViewController.hideSetting))
        
        self.vTouch.addGestureRecognizer(tap)
        self.dicSetting = Utils.getSettingReader()
        self.currentFonSize = Int(self.dicSetting.valueForKey(keyFontSize) as! String)!
        self.currentTheme = Int(self.dicSetting.valueForKey(keyTheme) as! String)!
        self.currentLight =  Float(self.dicSetting.valueForKey(keyLight) as! String)!
        
        self.lblFontSizeText.text = "\(self.currentFonSize)"
        self.slideLight.value = self.currentLight
        self.slideLight.addTarget(self, action: #selector(ReadStoryViewController.sliderChangeValue), forControlEvents: UIControlEvents.ValueChanged)
          UIScreen.mainScreen().brightness = CGFloat(self.currentLight)
        
        self.btnThemeLight.layer.borderWidth = 2
        self.btnThemeBlack.layer.borderWidth = 2
       
        self.setTheme()
        
    }
    
    func sliderChangeValue(sender:UISlider){
        self.currentLight = sender.value
        UIScreen.mainScreen().brightness = CGFloat(sender.value)
        
    }
    
    func hideSetting(){
        
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
             self.vSetting.superview?.alpha = 0.0
            }) { (result) in
             self.vSetting.superview?.hidden = true
        }
    }
    
    func showSetting(){
        if  self.vSetting.superview?.hidden == true {
         self.vSetting.superview?.hidden = false
        self.vSetting.superview?.alpha = 0.0
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.vSetting.superview?.alpha = 1
        }) { (result) in
            
        }
        }else{
           self.hideSetting()
        }
    }
    
    
    @IBAction func btnThemeBlackTouch(sender: AnyObject) {
        print("black")
        self.currentTheme = ThemeStyle.Black.rawValue
        self.setTheme()
    }
    
    @IBAction func btnThemeLightTouch(sender: AnyObject) {
         print("light")
           self.currentTheme = ThemeStyle.White.rawValue
         self.setTheme()
    }
    func setTheme() {
        if  self.currentTheme == ThemeStyle.Black.rawValue {
            self.btnThemeBlack.layer.borderColor = bgOrangeColor.CGColor
            self.btnThemeLight.layer.borderColor = UIColor.clearColor().CGColor
            self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.color =\"#F5F5F5\"")
//            self.webView.stringByEvaluatingJavaScriptFromString("document.body.style.backgroundColor = \"black\"")
            self.webView.backgroundColor = textColor
            self.vSetting.backgroundColor =  textColor
            self.lblFontSizeText.textColor = textWhiteColor
        }else{
            self.btnThemeBlack.layer.borderColor = UIColor.clearColor().CGColor
            self.btnThemeLight.layer.borderColor = bgOrangeColor.CGColor
 
            self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.color =\"#000000\"")
 
            self.webView.backgroundColor = UIColor.whiteColor()
           self.vSetting.backgroundColor =   textWhiteColor
           self.lblFontSizeText.textColor = textColor
        }
        
        
    }
    
    @IBAction func btnDecreaseTextTouch(sender: AnyObject) {
       
        if self.currentFonSize >= 50 {
            self.currentFonSize -= 25
            self.lblFontSizeText.text = "\(self.currentFonSize)"
            self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(self.currentFonSize)%%'")
 
        }
    }
    
    @IBAction func btnIncreaseTextTouch(sender: AnyObject) {
        if self.currentFonSize < 300 {
            self.currentFonSize += 25
            self.lblFontSizeText.text = "\(self.currentFonSize)"
             self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(self.currentFonSize)%%'")
 
        }
        
    }
    
}






