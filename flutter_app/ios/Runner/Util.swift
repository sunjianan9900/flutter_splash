//
//  Util.swift
//  Runner
//
//  Created by 孙嘉楠 on 2019/12/16.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//
 
import UIKit

class Util: NSObject {
    class public func isIphoneX() -> Bool {
        return UIScreen.main.nativeBounds.size.height-2436 == 0 ? true : false
    }
    class public func isSmallIphone() -> Bool {
        return UIScreen.main.bounds.size.height == 480 ? true : false
    }
}
