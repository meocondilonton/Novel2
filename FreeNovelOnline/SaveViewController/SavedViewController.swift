//
//  SavedViewController.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 8/29/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import MJRefresh
import GoogleMobileAds


class SavedViewController: BaseViewController {
    
    @IBOutlet weak var vEmpty: UIView!
    @IBOutlet weak var collectionViewStory: UICollectionView!
    @IBOutlet weak var btnGotoBook: UIButton!
    
    
     var arrStory:[StoryFullInfoModel]? = [StoryFullInfoModel]()
     var request:GADRequest!
     var numAd:Int = 0
    var editMode:Bool = false
    var numSelect:Int = 0
    
    @IBAction func btnGoToBookTouch(sender: AnyObject) {
        appdelegate.tabbar.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !editMode {
             self.setupLoadMoreAndPullRefresh()
        }
       
       
        
        self.collectionViewStory.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    
    
    func getDefaultData(){
        self.arrStory?.removeAll()
        self.arrStory = DatabaseHelper.shareInstall().getAllStoryFullInfoSaved()
        if self.arrStory?.count <= 0 {
            self.vEmpty.hidden = false
        }else{
            self.vEmpty.hidden = true
        }
        
         if !editMode {
        self.collectionViewStory.mj_header.endRefreshing()
        self.collectionViewStory.reloadData()
        }
    }
    
}


extension SavedViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
         self.getDefaultData()
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        if editMode {
            navigationController?.navigationBar.setDefault(UINavigationBar.State.BackAndDelete, vc: self)
            navigationItem.title = "Select Story"
        }else{
            navigationController?.navigationBar.setDefault(UINavigationBar.State.Edit, vc: self)
            navigationItem.title = "Saved"
        }
        
        
    }
    
    override func btnDeleteTouch() {
        super.btnDeleteTouch()
        for item in self.arrStory! {
            if item.isSelect == true {
                DatabaseHelper.shareInstall().removeStorySaved(item)
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
   override func btnEditTouch() {
        super.btnEditTouch()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewControllerWithIdentifier("SavedViewController") as! SavedViewController
    vc.editMode = true
    self.navigationController?.pushViewController(vc, animated: true)
    
    }
}

extension SavedViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func setupLoadMoreAndPullRefresh() {
        
        let header = MJRefreshNormalHeader(refreshingBlock: {[weak self] () -> Void in
                        self?.getDefaultData()
            })
        header.lastUpdatedTimeLabel!.hidden = true
        header.setTitle("Release To Refresh", forState: MJRefreshState.Pulling)
        header.setTitle("Refreshing Data...", forState: MJRefreshState.Refreshing)
        header.setTitle("Pull To Refresh", forState: MJRefreshState.Idle)
        self.collectionViewStory.mj_header = header
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.arrStory?.count ?? 0
 
        return count
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
 
            return CGSizeMake(self.view.frame.size.width/3 - 20, self.view.frame.size.width*1.25/3.0)
 
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.collectionViewStory.cellForItemAtIndexPath(indexPath) as! HomeCollectionViewCell
        if editMode == true {
            if self.arrStory![indexPath.item].isSelect == true {
                numSelect -= 1
            }else{
                numSelect += 1
            }
            navigationItem.title = "\(numSelect) selected"
            self.arrStory![indexPath.item].isSelect = !self.arrStory![indexPath.item].isSelect
            cell.selectToDelete(self.arrStory![indexPath.item].isSelect)
          
        }else{

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("DetailInfoStoryViewController") as! DetailInfoStoryViewController
 
                let arrIndex = indexPath.item // - numAdCurrent
                let storyInfo = self.arrStory![arrIndex]
            
            vc.storyFullInfo = StoryFullInfoModel()
            vc.storyFullInfo.storyImgUrl = storyInfo.storyImgUrl
            vc.storyFullInfo.storyName = storyInfo.storyName
            vc.storyFullInfo.storyUrl = storyInfo.storyUrl
            
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
         
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeCollectionViewCell", forIndexPath: indexPath) as! HomeCollectionViewCell
        let arrIndex = indexPath.item
            cell.isEdit = self.arrStory![indexPath.item].isSelect
            cell.updateData(self.arrStory![arrIndex])
        
        return cell
 
    }
}
