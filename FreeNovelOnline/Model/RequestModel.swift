//
//  RequestModel.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/13/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit

//protocol Value {
//    typealias Datatype: Binding
//    class var declaredDatatype: String { get }
//    class func fromDatatypeValue(datatypeValue: Datatype) -> Self
//    var datatypeValue: Datatype { get }
//}

class RequestModel: NSObject {
    var _id:Int = 0
    var request:String?
    var result:NSData?
    

}

//extension NSData: Value {
//    class var declaredDatatype: String {
//        return Blob.declaredDatatype
//    }
//    class func fromDatatypeValue(blobValue: Blob) -> Self {
//        return self(bytes: blobValue.bytes, length: blobValue.length)
//    }
//    var datatypeValue: Blob {
//        return Blob(bytes: bytes, length: length)
//    }
//}