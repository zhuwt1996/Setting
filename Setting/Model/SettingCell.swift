//
//  SettingCell.swift
//  Setting
//
//  Created by ZWT on 2019/10/11.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

struct SettingCell {

    var settingTitle : String?   //标题
    
    var icon : String?  // 图片
    
    init(settingTitle:String, icon:String)
    {
        self.settingTitle = settingTitle
        self.icon = icon
    }
}
