//
//  SliderInfo.swift
//  Setting
//
//  Created by ZWT on 2019/10/14.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class SliderInfo: NSObject {
    
    var s1V : Float = 0.5
    var s2V : Float?
    var s3V : Float?
    
    override init() {
        super.init()
    }

    init(s1V : Float,s2V : Float,s3V : Float) {
        self.s1V = s1V
        self.s2V = s2V
        self.s3V = s3V
    }
    
    

}
