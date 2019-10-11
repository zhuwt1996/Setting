//
//  MyDeviceCell.swift
//  Setting
//
//  Created by ZWT on 2019/10/11.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class MyDeviceCell: NSObject {
    var deviceTitle : String?   //标题
    var des : String?   //描述
    var icon : String?  // 图片
    
    init(deviceTitle:String,des:String,icon:String)
    {
        self.deviceTitle = deviceTitle
        self.des = des
        self.icon = icon
    }
}
