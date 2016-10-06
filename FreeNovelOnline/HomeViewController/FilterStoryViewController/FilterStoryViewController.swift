//
//  FilterStoryViewController.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/11/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit

class FilterStoryViewController: BaseViewController {

    @IBOutlet weak var collectionViewType: UICollectionView!
    var arrType:[StoryInfoModel]!
    var block:((StoryInfoModel)->())?
    @IBOutlet weak var collectionStory: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

extension FilterStoryViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrType.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(self.view.frame.size.width/2 - 20, self.view.frame.size.width / 3.0)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item <= self.arrType.count {
            if block != nil {
                block!(self.arrType[indexPath.item])
            }
             self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterStoryCollectionViewCell", forIndexPath: indexPath) as! FilterStoryCollectionViewCell
        if indexPath.item <= self.arrType.count {
            cell.updateData(self.arrType[indexPath.item])
        }
        return cell
    }
}

extension FilterStoryViewController {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        navigationController?.navigationBar.setDefault(UINavigationBar.State.Back, vc: self)
       
        navigationItem.title = "Filter Story"
        self.navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.hidesBarsOnTap = false
}

}


