//
//  AppGlobal.swift
//  Setting
//
//  Created by ZWT on 2019/10/11.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit


let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
let SCALE_HEIGHT = SCREEN_HEIGHT / 667.0
let SCALE_WIDTH = SCREEN_WIDTH / 375.0


extension UIColor{
    /// EZSE: init method with hex string and alpha(default: 1)
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)        } else {
            return nil
        }
    }
}
