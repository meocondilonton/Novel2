//
//  DatabaseHelper.swift
//  ALTP2016
//
//  Created by long nguyen on 8/3/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import SQLite

class DatabaseHelper: NSObject {
    
    static var install:DatabaseHelper?
    var db:Connection!
    
    static func shareInstall() -> DatabaseHelper {
        if install == nil {
            install = DatabaseHelper()
        }
        return install!
    }
    
    override init() {
        super.init()
        DatabaseHelper.copyDatabase()
        let path = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true
            ).first!
        print("path: \(path) ")
        
        do {
            db = try Connection("\(path)/altp_tet.sqlite3")
            
        } catch {
            print(" failed: \(error)")
        }
        
    }
    
    class func copyDatabase(){
        
        let fileManager = NSFileManager.defaultManager()
        
        let dbPath = getDBPath()
        let success = fileManager.fileExistsAtPath(dbPath)
        
        if(!success) {
            if let defaultDBPath = NSBundle.mainBundle().pathForResource("altp_tet", ofType: "sqlite3"){
                
                do {
                    try fileManager.copyItemAtPath(defaultDBPath, toPath: dbPath )
                }catch{
                    print("copy fail")
                }
                
                
            }else{
                print("Cannot Find File In NSBundle")
            }
        }else{
            print("File Already Exist At:\(dbPath)")
        }
    }
    
    
    class func getDBPath()->String
    {
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDir = paths[0]
        let databasePath = documentsDir.stringByAppendingPathComponent("altp_tet.sqlite3")
        return databasePath;
    }
    
    func removeStorySaved(storyRemove:StoryFullInfoModel){
        let storyFullInfoSaved = Table("storyfullinfosaved")
        let storyName = Expression<String>("storyName")
        let isSaved = Expression<Int>("isSaved")
        let query  = storyFullInfoSaved.filter(storyName == storyRemove.storyName ?? "").limit(1)
        do {
           if  try db.run(query.update(isSaved <- 0)) > 0 {
                print("update delete save")
            }else{
                 print("update delete save fail")
            }
        } catch {
                print(" failed: \(error)")
            }
        
    }
    
    func getAllRecentStoryFullInfoSaved() -> [StoryFullInfoModel] { //50 items newset
        
        let storyFullInfoSaved = Table("storyfullinfosaved")
        
        let id = Expression<Int>("_id")
        let storyImgUrl = Expression<String>("storyImgUrl")
        let storyName = Expression<String>("storyName")
        let storyUrl = Expression<String>("storyUrl")
        let isSaved = Expression<Int>("isSaved")
        let storyView = Expression<String>("storyView")
        let storyCurrentIndex = Expression<Int>("storyCurrentIndex")
        let storyDescription = Expression<String>("storyDescription")
        let timeSaved = Expression<Double>("timeSaved")
        let currentChapter =  Expression<Int>("currentChapter")
        let chapterOffset = Expression<Double>("chapterOffset")
        let storyRate =  Expression<String>("storyRate")
        let storyIsRead = Expression<Int>("storyIsRead")
        
        var arrStory =  [StoryFullInfoModel] ()
        let query  = storyFullInfoSaved.filter(storyIsRead == 1).order(timeSaved.desc).limit(50)
        do {
            for item in try db.prepare(query) {
                print("Xid: \(item[id]) ")
                
                let itemStory = StoryFullInfoModel()
                itemStory.storyImgUrl = item[storyImgUrl]
                itemStory.storyName = item[storyName]
                itemStory.storyUrl = item[storyUrl]
                itemStory.storyView = item[storyView]
                itemStory.isSaved = item[isSaved] > 0 ? true : false
                itemStory.storyIsRead = item[storyIsRead] > 0 ? true : false
                itemStory.storyCurrentIndex = item[storyCurrentIndex]
                itemStory.storyDescription = item[storyDescription]
                itemStory.timeSaved = item[timeSaved]
                itemStory.currentChapter = item[currentChapter]
                itemStory.chapterOffset = item[chapterOffset]
                itemStory.storyRate = item[storyRate]
                
                arrStory.append(itemStory)
                
            }
        } catch {
            print(" failed: \(error)")
        }
        
        return arrStory
    }
    
    func getAllStoryFullInfoSaved() -> [StoryFullInfoModel] {
        
        let storyFullInfoSaved = Table("storyfullinfosaved")
        
         let id = Expression<Int>("_id")
         let storyImgUrl = Expression<String>("storyImgUrl")
         let storyName = Expression<String>("storyName")
          let storyUrl = Expression<String>("storyUrl")
          let isSaved = Expression<Int>("isSaved")
         let storyIsRead = Expression<Int>("storyIsRead")
          let storyView = Expression<String>("storyView")
          let storyCurrentIndex = Expression<Int>("storyCurrentIndex")
          let storyDescription = Expression<String>("storyDescription")
          let timeSaved = Expression<Double>("timeSaved")
          let currentChapter =  Expression<Int>("currentChapter")
          let chapterOffset = Expression<Double>("chapterOffset")
          let storyRate =  Expression<String>("storyRate")
        
        var arrStory =  [StoryFullInfoModel] ()
         let query  = storyFullInfoSaved.filter(  isSaved == 1)
        do {
            for item in try db.prepare(query) {
                print("Xid: \(item[id]) ")
               
                let itemStory = StoryFullInfoModel()
                itemStory.storyImgUrl = item[storyImgUrl]
                itemStory.storyName = item[storyName]
                itemStory.storyUrl = item[storyUrl]
                itemStory.storyView = item[storyView]
                itemStory.isSaved = item[isSaved] > 0 ? true : false
                itemStory.storyIsRead = item[storyIsRead] > 0 ? true : false
                itemStory.storyCurrentIndex = item[storyCurrentIndex]
                itemStory.storyDescription = item[storyDescription]
                itemStory.timeSaved = item[timeSaved]
                itemStory.currentChapter = item[currentChapter]
                itemStory.chapterOffset = item[chapterOffset]
                itemStory.storyRate = item[storyRate]
                
                arrStory.append(itemStory)
                
            }
        } catch {
            print(" failed: \(error)")
        }
        
      return arrStory
    }
    
    func getStoryFullInfo(storyNameStr:String) -> StoryFullInfoModel?{
        let storyFullInfoSaved = Table("storyfullinfosaved")
        
        let id = Expression<Int>("_id")
        let storyImgUrl = Expression<String>("storyImgUrl")
        let storyName = Expression<String>("storyName")
        let storyUrl = Expression<String>("storyUrl")
        let isSaved = Expression<Int>("isSaved")
         let storyIsRead = Expression<Int>("storyIsRead")
        let storyView = Expression<String>("storyView")
        let storyCurrentIndex = Expression<Int>("storyCurrentIndex")
        let storyDescription = Expression<String>("storyDescription")
         let timeSaved = Expression<Double>("timeSaved")
        let currentChapter =  Expression<Int>("currentChapter")
        let chapterOffset = Expression<Double>("chapterOffset")
          let storyRate =  Expression<String>("storyRate")
        
        let query  = storyFullInfoSaved.filter(  storyName == storyNameStr)
            .limit(1)
        
        do {
            for item in try db.prepare(query) {
                print("Xid: \(item[id]) ")
                
                let itemStory = StoryFullInfoModel()
                itemStory.storyImgUrl = item[storyImgUrl]
                itemStory.storyName = item[storyName]
                itemStory.storyUrl = item[storyUrl]
                itemStory.storyView = item[storyView]
                itemStory.isSaved = item[isSaved] > 0 ? true : false
                itemStory.storyIsRead = item[storyIsRead] > 0 ? true : false
                itemStory.storyCurrentIndex = item[storyCurrentIndex]
                itemStory.storyDescription = item[storyDescription]
                itemStory.timeSaved = item[timeSaved]
                itemStory.currentChapter = item[currentChapter]
                itemStory.chapterOffset = item[chapterOffset]
                itemStory.storyRate = item[storyRate]
                
                let id = item[id]
                
                let keyCategory = String(format:"%@%d",keyStoryCategory,id )
               let arrCategory = self.getListItem(keyCategory)
                itemStory.storyCategory = arrCategory
                
                let keyChapter = String(format:"%@%d",keyStoryChapter,id )
                let arrChapter = self.getListItem(keyChapter)
                itemStory.storyChapter = arrChapter
                
                let keyAuthor = String(format:"%@%d",keyStoryAuthor,id )
                let arrAuthor = self.getListItem(keyAuthor)
                if arrAuthor.count > 0 {
                     itemStory.storyAuthor = arrAuthor[0]
                }
               
                let keyStatus = String(format:"%@%d",keyStoryStatus,id )
                let arrStatus = self.getListItem(keyStatus)
                if arrStatus.count > 0 {
                    itemStory.storyStatus = arrStatus[0]
                }
                
                let keySeries = String(format:"%@%d",keyStorySeries,id )
                let arrSeries = self.getListItem(keySeries)
                if arrSeries.count > 0 {
                    itemStory.storySeries = arrSeries[0]
                }
                
                 return itemStory
                
            }
        } catch {
            print(" failed: \(error)")
             return nil
        }
        
        return nil
    }
    
    func inSertStoryFullInfoSaved(storyModel:StoryFullInfoModel) {
        let storyTable = Table("storyfullinfosaved")
     
        let id = Expression<Int>("_id")
        let storyImgUrl = Expression<String>("storyImgUrl")
        let storyName = Expression<String>("storyName")
        let storyUrl = Expression<String>("storyUrl")
        let isSaved = Expression<Int>("isSaved")
        let storyIsRead = Expression<Int>("storyIsRead")
        let storyView = Expression<String>("storyView")
        let storyCurrentIndex = Expression<Int>("storyCurrentIndex")
        let storyDescription = Expression<String>("storyDescription")
        let timeSaved = Expression<Double>("timeSaved")
        let currentChapter =  Expression<Int>("currentChapter")
        let chapterOffset = Expression<Double>("chapterOffset")
        let storyRate =  Expression<String>("storyRate")
        
        let query  = storyTable.filter(  storyName == storyModel.storyName ?? "")
            .limit(1)
        do {
            var size = 0
            for _ in try db.prepare(query) {
                size += 1
                
            }
            if size > 0 {
               //update time
                 let isSave = storyModel.isSaved == true ? 1:0
                 let storyIsReaded = storyModel.storyIsRead == true ? 1:0
                if try db.run(query.update(timeSaved <- storyModel.timeSaved  ,isSaved <- isSave  ,storyIsRead <- storyIsReaded  , currentChapter <-  storyModel.currentChapter  ,chapterOffset <-  storyModel.chapterOffset, storyRate <-  (storyModel.storyRate ?? "0"))) > 0 {
                    print("updated row storyTable")
                } else {
                    print("row storyTable not found")
                }
                
            }else{
                let isSave = storyModel.isSaved == true ? 1:0
                let storyIsReaded = storyModel.storyIsRead == true ? 1:0
                let insert = storyTable.insert(storyImgUrl <- (storyModel.storyImgUrl ?? ""), storyName <- (storyModel.storyName ?? ""),storyUrl <- (storyModel.storyUrl ?? ""),isSaved <- isSave,storyIsRead <- storyIsReaded  ,storyView <- (storyModel.storyView ?? ""),storyCurrentIndex <- (storyModel.storyCurrentIndex ?? 0) , storyDescription <- (storyModel.storyDescription ?? "") ,timeSaved <-  storyModel.timeSaved  ,currentChapter <-  storyModel.currentChapter  ,chapterOffset <-  storyModel.chapterOffset, storyRate <-  (storyModel.storyRate ?? "0"))
                let rowId = try db.run(insert)
                
                if storyModel.storyAuthor != nil {
                     storyModel.storyAuthor!.itemKey  = String(format:"%@%d",keyStoryAuthor, rowId )
                    self.insertItem(storyModel.storyAuthor!)
                }
                
                if storyModel.storyStatus != nil {
                    storyModel.storyStatus!.itemKey  = String(format:"%@%d",keyStoryStatus, rowId )
                    self.insertItem(storyModel.storyStatus!)
                }
                
                if storyModel.storySeries != nil {
                    storyModel.storySeries!.itemKey  = String(format:"%@%d",keyStorySeries, rowId )
                    self.insertItem(storyModel.storySeries!)
                }
                
                if storyModel.storyChapter != nil {
                    for chapter in storyModel.storyChapter!{
                        chapter.itemKey  = String(format:"%@%d",keyStoryChapter, rowId )
                        self.insertItem(chapter)
                    }
                }
                
                if storyModel.storyCategory != nil {
                    for category in storyModel.storyCategory!{
                        category.itemKey  = String(format:"%@%d",keyStoryCategory, rowId )
                        self.insertItem(category)
                    }
                }
                
                print("insert row storyfullinfosaved \(rowId)")
            }
        } catch {
            print(" failed: \(error)")
        }
    }
    
    func insertItem(item:Item){
        let itemTable = Table("item")
        
        let id = Expression<Int>("_id")
        let itemName = Expression<String>("itemName")
        let itemUrl = Expression<String>("itemUrl")
        let itemKey = Expression<String>("itemKey")
 
        do {
 
                let insert = itemTable.insert(itemName <- (item.itemName ?? ""), itemUrl <- (item.itemUrl ?? ""),itemKey <- (item.itemKey ?? "")  )
                _ = try db.run(insert)
                print("insert row cacheRequest")
            
        } catch {
            print(" failed: \(error)")
        }
    }
    
    func getListItem(itemKeyStr:String) ->[Item] {
        let itemTable = Table("item")
        
        let id = Expression<Int>("_id")
        let itemName = Expression<String>("itemName")
        let itemUrl = Expression<String>("itemUrl")
        let itemKey = Expression<String>("itemKey")

        
        var arrItem =  [Item] ()
        
        let query  = itemTable.filter( itemKey == itemKeyStr)

        do {
            for item in try db.prepare(query) {
                print("Xid: \(item[id]) ")
                
                let itemModel = Item()
                 itemModel.itemKey = item[itemKey]
                 itemModel.itemUrl = item[itemUrl]
                 itemModel.itemName = item[itemName]
                
                
                arrItem.append(itemModel)
                
            }
        } catch {
            print(" failed: \(error)")
        }
        
        return arrItem
    }
    
    func getRequest( requestStr:String) -> RequestModel?   {
        let cacheRequest = Table("cacherequest")
        
        let id = Expression<Int>("_id")
        let request = Expression<String>("request")
        let result = Expression<NSData>("result")
      
        
        let resultRequest:RequestModel = RequestModel()
        
        let query  = cacheRequest.filter(  request == requestStr)
                .limit(1)
 
        
        do {
            for item in try db.prepare(query) {
                print("Xid: \(item[id]) ")
                print("id: \(item[request]) ")
                print("id: \(item[result]) ")
               
                resultRequest.request = item[request]
                resultRequest.result =  item[result]
                resultRequest._id = item[id]
                
                return resultRequest
            }
        } catch {
            print(" failed: \(error)")
        }
        
        return nil
    }
    
    
    func insertOrUpdateRequest(requestModel:RequestModel) {
        let cacheRequest = Table("cacherequest")
 
        let request = Expression<String>("request")
        let result = Expression<NSData>("result")
        
        let query  = cacheRequest.filter(  request == requestModel.request!)
            .limit(1)
        do {
             var size = 0
            for _ in try db.prepare(query) {
                 size += 1
  
            }
            if size > 0 {
                if try db.run(cacheRequest.update(request <- requestModel.request!,result <- requestModel.result! )) > 0 {
                    print("updated row cacheRequest")
                } else {
                    print("row cacheRequest not found")
                }
                
            }else{
                  let insert = cacheRequest.insert(request <- (requestModel.request ?? ""), result <- (requestModel.result )!)
                  _ = try db.run(insert)
                 print("insert row cacheRequest")
            }
        } catch {
            print(" failed: \(error)")
        }
   
    }
  
    
    
}

extension String {
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
}

