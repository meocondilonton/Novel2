//
//  BaseWebservice.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/5/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
 

let keyUrl = "url"

class BaseWebservice: NSObject , NSURLConnectionDelegate{
    static var instance:BaseWebservice?
    var block:((NSData?)->())?
    var dataVal:NSMutableData!
    var isLoadFromCache:Bool = false
    var requestStr:String?
    var isShowIndicator:Bool = false
    
    class func shareInstance()-> BaseWebservice {
        if instance == nil {
            instance = BaseWebservice()
        }
        return instance!
    }
    
    func loadCache(requestStr:String)->Bool{
       let result =  DatabaseHelper.shareInstall().getRequest(requestStr)
        if result == nil {
            self.isLoadFromCache = false
              return false
        }
        
        if self.block != nil {
            self.isLoadFromCache = true
            self.block!(result?.result)
            SVProgressHUD.dismiss()
        }
        return true
    }
    
    func getData(param:NSDictionary,isShowIndicator:Bool , block:((NSData?)->())?)  {
        self.isShowIndicator = isShowIndicator
        if isShowIndicator {
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Gradient)
           
 
        }
         self.block = block
        self.requestStr = param.valueForKey(keyUrl) as! String
          self.loadCache(self.requestStr ?? "")
        
        do {
           
            dataVal = NSMutableData()
            let url: NSURL = NSURL(string:  self.requestStr ?? "")!
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.timeoutInterval = 30
            let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
            connection.start()
            
            
            
        }catch {
            print(error)
        }
        
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        dataVal.appendData(data)
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!)
    {
        if self.isShowIndicator {
            SVProgressHUD.dismiss()
        }
        if self.block != nil && self.isLoadFromCache == false{
            self.block!(dataVal)
        }
       let item = RequestModel()
        item.request = self.requestStr
        item.result = dataVal
        DatabaseHelper.shareInstall().insertOrUpdateRequest(item)
        
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        if self.isShowIndicator {
            SVProgressHUD.dismiss()
        }
        if self.block != nil && self.isLoadFromCache == false{
            self.block!(nil)
        }
    }

}
