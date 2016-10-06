//
//  StoryInfoModel.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 8/31/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit

class StoryInfoModel: NSObject , NSCoding {
    
    var storyImgUrl:String?
    var storyName:String?
    var storyUrl:String?
    var isSaved:Bool = false
    var isSelect:Bool = false
    
    required init?(coder decoder:NSCoder) {
        super.init()
           self.storyUrl = decoder.decodeObjectForKey("storyUrl") as? String
           self.storyImgUrl = decoder.decodeObjectForKey("storyImgUrl") as? String
           self.storyName = decoder.decodeObjectForKey("storyName") as? String
        self.isSaved = decoder.decodeBoolForKey("isSaved")
    }
    
    required override init() {
        super.init()
    }

     func encodeWithCoder(aCoder: NSCoder) {

         aCoder.encodeObject(self.storyImgUrl, forKey: "storyImgUrl")
         aCoder.encodeObject(self.storyName, forKey: "storyName")
         aCoder.encodeObject(self.storyUrl, forKey: "storyUrl")
         aCoder.encodeBool(self.isSaved, forKey: "isSaved")
        
    }
    
}
