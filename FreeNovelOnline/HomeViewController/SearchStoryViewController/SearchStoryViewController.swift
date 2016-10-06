//
//  SearchStoryViewController.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/11/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit


class SearchStoryViewController: BaseViewController {

    @IBOutlet weak var vEmpty: UIView!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
      var arrStory:[StoryInfoModel]? = [StoryInfoModel]()
    var cancel:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tfSearch.becomeFirstResponder()
        self.setUpTextField()
        self.tbView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTextField() {
        self.tfSearch.attributedPlaceholder = NSAttributedString(string:"Search by title or author",
                                                                      attributes:[NSForegroundColorAttributeName: textWhiteBlurColor])
    }
    

}

extension SearchStoryViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
  
}

extension SearchStoryViewController {
    func searchStoryWithKey(key:String){
        let param = NSMutableDictionary()
        let originalUrl = NSString(format: "%@%@",UrlSearch,key)
        let urlString :String = originalUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        param.setValue(urlString, forKey: keyUrl)
        BaseWebservice.shareInstance().getData(param, isShowIndicator: true) { [weak self](result) in
            
            //test
            if appdelegate.isTest  == true {
                self?.arrStory?.removeAll()
                self?.arrStory = self?.arrTest()
                self?.tbView.reloadData()
                if self?.arrStory?.count > 0 {
                    self?.vEmpty.hidden = true
                }else{
                    self?.vEmpty.hidden = false
                }
                return
            }
            //
            let doc = TFHpple(HTMLData: result)
            let elements = doc.searchWithXPathQuery("//div[@class='game-medium']")
            
            self?.arrStory  = [StoryInfoModel]()
            
            for eleItem in elements {
                let e = eleItem as! TFHppleElement
                if e.children.count > 1 {
                    if let temp = e.children[1] as? TFHppleElement {
                        let itemStory = StoryInfoModel()
                        let origin = temp.objectForKey("href") ?? ""
                        let urlString :String = origin.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                        itemStory.storyUrl = urlString
                        
                        for item in temp.children {
                            
                            
                            itemStory.storyName = item.objectForKey("title")
                            let origin = item.objectForKey("src") ?? ""
                             let urlString :String = origin.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                            itemStory.storyImgUrl =   urlString.stringByReplacingOccurrencesOfString("..", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
 
                            
                        }
                        
                        self?.arrStory?.append(itemStory)
                        
                    }
                }
                
            }
            
            if self?.arrStory?.count > 0 {
                self?.vEmpty.hidden = true
            }else{
                 self?.vEmpty.hidden = false
            }
            self?.tbView.reloadData()
            
        }
    }
   
    func arrTest()->[StoryInfoModel]{
        var result = [StoryInfoModel]()
        
        let itemNew5 = StoryInfoModel()
        itemNew5.storyName = "Boy's Life"
        itemNew5.storyUrl = "/241659-boys-life.html"
        itemNew5.storyImgUrl = "/uploads/truyen/Boys-Life.jpg"
        result.append(itemNew5)
        
        let itemNew2 = StoryInfoModel()
        itemNew2.storyName = "The Historian"
        itemNew2.storyUrl = "/241337-the-historian.html"
        itemNew2.storyImgUrl = "/uploads/truyen/The-Historian.jpg"
        result.append(itemNew2)
        
        let itemNew = StoryInfoModel()
        itemNew.storyName = "Airport"
        itemNew.storyUrl = "/241269-airport.html"
        itemNew.storyImgUrl = "/uploads/truyen/Airport.jpg"
        result.append(itemNew)
        
       
        
        let itemNew3 = StoryInfoModel()
        itemNew3.storyName = "Teenage Mermaid"
        itemNew3.storyUrl = "/241217-teenage-mermaid.html"
        itemNew3.storyImgUrl = "/uploads/truyen/Teenage-Mermaid.jpg"
        result.append(itemNew3)
        
        let itemNew7 = StoryInfoModel()
        itemNew7.storyName = "Questing Beast"
        itemNew7.storyUrl = "/241519-questing-beast.html"
        itemNew7.storyImgUrl = "/uploads/truyen/Questing-Beast.jpg"
        result.append(itemNew7)
        
        let itemNew4 = StoryInfoModel()
        itemNew4.storyName = "Our Lady of Darkness"
        itemNew4.storyUrl = "/241960-our-lady-of-darkness.html"
        itemNew4.storyImgUrl = "/uploads/truyen/Our-Lady-of-Darkness.jpg"
        result.append(itemNew4)
       
        
        let itemNew6 = StoryInfoModel()
        itemNew6.storyName = "Of Swine and Roses"
        itemNew6.storyUrl = "/241518-of-swine-and-roses.html"
        itemNew6.storyImgUrl = "/uploads/truyen/Of-Swine-and-Roses.jpg"
        result.append(itemNew6)
        
        
        
        return result
    }
    
    
}


extension SearchStoryViewController : UITextFieldDelegate  {
   
    @IBAction func btnCancelTouch(sender: AnyObject) {
        self.cancel = true
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.tfSearch.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let search = textField.text ?? ""
        if search != "" && cancel == false{
            self.searchStoryWithKey(textField.text ?? "")
        }
    }
    
}

extension SearchStoryViewController :UITableViewDelegate , UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrStory?.count ?? 0
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StoryTableViewCell1", forIndexPath: indexPath) as! StoryTableViewCell1
        if indexPath.row < self.arrStory?.count {
            cell.uodateData(self.arrStory![indexPath.row])
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row <= self.arrStory?.count {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("DetailInfoStoryViewController") as! DetailInfoStoryViewController
            
            let storyInfo = self.arrStory![indexPath.item]
            
            vc.storyFullInfo = StoryFullInfoModel()
            vc.storyFullInfo.storyImgUrl = storyInfo.storyImgUrl
            vc.storyFullInfo.storyName = storyInfo.storyName
            vc.storyFullInfo.storyUrl = storyInfo.storyUrl
            
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
