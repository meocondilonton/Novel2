//
//  StoryFullInfoModel.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/5/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit

let keyStoryCategory = "storyCategory"
let keyStoryAuthor = "storyAuthor"
let keyStoryStatus = "storyStatus"
let keyStorySeries = "storySeries"
let keyStoryChapter = "storyChapter"

class StoryFullInfoModel: StoryInfoModel {
    var storyAuthor:Item?
    var storyCategory:[Item]?
    var storyStatus:Item?
    var storySeries:Item?
    var storyView:String?
    var storyDescription:String?
    var storyChapter:[Item]?
    var storyCurrentIndex:Int = 0
    var timeSaved:Double = 0
    var currentChapter:Int = 0
    var chapterOffset:Double = 0
    var storyRate:String?
    var storyIsRead:Bool = false
}
