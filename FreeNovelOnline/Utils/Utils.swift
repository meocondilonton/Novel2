//
//  Utils.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/7/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit
import SystemConfiguration

let keyFilterStory = "keyFilterStory"
let keySettingReader = "keySettingReader"
let keyFontSize = "keyFontSize"
let keyLight = "keyLight"
let keyTheme = "keyTheme"

class Utils: NSObject {

    class func attributeStringForTexts(texts:NSArray, fonts:[UIFont], colors:[UIColor], separator:String?)->NSMutableAttributedString
    {
        var tempSeparator   =   ""
        if let sepa =   separator
        {
            tempSeparator   =   sepa
        }
        
        let fullText:String =   texts.componentsJoinedByString(tempSeparator)
        let result:NSMutableAttributedString    =   NSMutableAttributedString(string:fullText as String)
        
        var numChar =   0
        for i:Int in 0 ..< texts.count
        {
            let text:String =   texts[i] as! String
            let range   =   NSMakeRange(numChar, text.characters.count)
            result.addAttribute(NSFontAttributeName, value: fonts[i], range: range)
            result.addAttribute(NSForegroundColorAttributeName, value: colors[i], range: range)
            numChar +=  (text.characters.count + tempSeparator.characters.count)
        }
        
        return result;
    }
    
    class func getFilterParams() -> NSMutableDictionary? {
        let userDefault = NSUserDefaults.standardUserDefaults()
        let dataget = userDefault.objectForKey(keyFilterStory) as? NSData ?? NSData()
        if let val = NSKeyedUnarchiver.unarchiveObjectWithData(dataget) as? NSMutableDictionary {
            return val
        }
        return nil
    }
    
    class func saveFilterParams(dic:NSMutableDictionary) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(dic)
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(data, forKey: keyFilterStory)
        userDefault.synchronize()
    }
    
    class func saveSettingReaderParam(dic:NSMutableDictionary) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(dic)
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(data, forKey: keySettingReader)
        userDefault.synchronize()
    }
    
    class func getSettingReader() -> NSMutableDictionary {
        let userDefault = NSUserDefaults.standardUserDefaults()
        let dataget = userDefault.objectForKey(keySettingReader) as? NSData ?? NSData()
        if let val = NSKeyedUnarchiver.unarchiveObjectWithData(dataget) as? NSMutableDictionary {
            return val
        }
        let defaultVal = NSMutableDictionary()
         defaultVal.setValue("100", forKey: keyFontSize)
         defaultVal.setValue("0", forKey: keyTheme) // 0 white , 1 black
         defaultVal.setValue("1", forKey: keyLight)
        return defaultVal
    }
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}
