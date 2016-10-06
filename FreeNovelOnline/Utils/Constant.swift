//
//  Constant.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/11/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit

let bgLightGreen =  UIColor(red: 218.0 / 255.0, green: 237.0 / 255.0, blue: 193.0 / 255.0, alpha: 255.0 / 255.0)
let bgHeaveyGreen =  UIColor(red: 122.0 / 255.0, green: 166.0 / 255.0, blue: 65.0 / 255.0, alpha: 255.0 / 255.0)
let bgNaColor =   UIColor(red: 57.0 / 255.0, green: 62.0 / 255.0, blue: 73.0 / 255.0, alpha: 255.0 / 255.0)  // UIColor(red: 245.0 / 255.0, green: 120.0 / 255.0, blue: 0.0 / 255.0, alpha: 255.0 / 255.0) //UIColor(red: 34.0 / 255.0, green: 139.0 / 255.0, blue: 34.0 / 255.0, alpha: 255.0 / 255.0) // UIColor(red: 0.0 / 255.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
let bgOrangeColor =   UIColor(red: 248.0 / 255.0, green: 90.0 / 255.0, blue: 46.0 / 255.0, alpha: 1)
let textWhiteColor =   UIColor(red: 245.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 255.0 / 255.0)
let textWhiteBlurColor =   UIColor(red: 172.0 / 255.0, green: 173.0 / 255.0, blue: 174.0 / 255.0, alpha: 255.0 / 255.0)
let textGrayColor =   UIColor(red: 136.0 / 255.0, green: 139.0 / 255.0, blue: 140.0 / 255.0, alpha: 255.0 / 255.0)
let textBoldColor =   UIColor(red: 63.0 / 255.0, green: 69.0 / 255.0, blue: 81.0 / 255.0, alpha: 255.0 / 255.0)
let textBoldColorHL =   UIColor(red: 63.0 / 255.0, green: 69.0 / 255.0, blue: 81.0 / 255.0, alpha: 0.5)
let textLightGreenColor =   UIColor(red: 143.0 / 255.0, green: 166.0 / 255.0, blue: 198.0 / 255.0, alpha: 255.0 / 255.0)
let textLightGreenColorHL =   UIColor(red: 143.0 / 255.0, green: 166.0 / 255.0, blue: 198.0 / 255.0, alpha: 0.5)
let textGreenColor =   UIColor(red: 36.0 / 255.0, green: 203.0 / 255.0, blue: 107.0 / 255.0, alpha: 255.0 / 255.0)
let bgNavigationColor =   UIColor(red: 143.0 / 255.0, green: 166.0 / 255.0, blue: 198.0 / 255.0, alpha: 255.0 / 255.0)
let bgHeaderColor =   UIColor(red: 228.0 / 255.0, green: 229.0 / 255.0, blue: 229.0 / 255.0, alpha: 255.0 / 255.0)
let bgLightGrayColor =   UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 237.0 / 255.0, alpha: 255.0 / 255.0)
let textRedColor =   UIColor(red: 242.0 / 255.0, green: 100.0 / 255.0, blue: 90.0 / 255.0, alpha: 255.0 / 255.0)
let textRedColorHL =   UIColor(red: 242.0 / 255.0, green: 100.0 / 255.0, blue: 90.0 / 255.0, alpha: 0.5)

let hightlightColorTex = UIColor(red: 120/255.0, green: 144/255.0, blue: 182/255.0, alpha: 1.0)
let textColor = UIColor(red: 63/255.0, green: 69/255.0, blue: 81/255.0, alpha: 1.0)


let IS_IPAD = UIDevice.currentDevice().userInterfaceIdiom == .Pad
let IS_IPHONE = UIDevice.currentDevice().userInterfaceIdiom == .Phone
let IS_RETINA = UIScreen.mainScreen().scale >= 2.0

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_5_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

enum ThemeStyle:Int {
     case White = 0
     case Black
}



