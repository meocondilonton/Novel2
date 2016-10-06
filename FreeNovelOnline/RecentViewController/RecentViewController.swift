//
//  RecentViewController.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 8/29/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import MJRefresh


class RecentViewController: BaseViewController {
  var arrStory:[StoryFullInfoModel]? = [StoryFullInfoModel]()
    
    @IBOutlet weak var vEmpty: UIView!
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tbView.tableFooterView = UIView()
        self.setupLoadMoreAndPullRefresh()
     
    }
    
    @IBAction func btnGoToBookTouch(sender: AnyObject) {
        appdelegate.tabbar.selectedIndex = 0
    }
    
    
    func getDefaultData() {
        self.arrStory = DatabaseHelper.shareInstall().getAllRecentStoryFullInfoSaved()
        if self.arrStory?.count <= 0 {
            self.vEmpty.hidden = false
        }else{
            self.vEmpty.hidden = true
        }
        self.tbView.mj_header.endRefreshing()
        self.tbView.reloadData()
    }
    
    func setupLoadMoreAndPullRefresh() {
        
        let header = MJRefreshNormalHeader(refreshingBlock: {[weak self] () -> Void in
                        self?.getDefaultData()
            })
        header.lastUpdatedTimeLabel!.hidden = true
        header.setTitle("Release To Refresh", forState: MJRefreshState.Pulling)
        header.setTitle("Refreshing Data...", forState: MJRefreshState.Refreshing)
        header.setTitle("Pull To Refresh", forState: MJRefreshState.Idle)
        self.tbView.mj_header = header
    
    }
    
}

extension RecentViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
           self.getDefaultData()
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        navigationController?.navigationBar.setDefault(UINavigationBar.State.Empty, vc: self)
        
        navigationItem.title = "Recent"
        
    }
}

extension RecentViewController :UITableViewDelegate , UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("StoryTableViewCell2", forIndexPath: indexPath) as! StoryTableViewCell2
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
