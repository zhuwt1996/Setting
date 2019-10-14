//
//  MuteTableViewCell.swift
//  Setting
//
//  Created by ZWT on 2019/10/12.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class MuteTableView: UIView {

    var s1V : Float?

    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "静音/勿扰"
        return label
    }()
    
    lazy var alarmTitle: UILabel = {
        let label = UILabel()
        label.text = "铃声音量"
        label.font = UIFont.systemFont(ofSize: 13 * SCALE_WIDTH, weight: UIFont.Weight.light)
        return label
    }()
    
    //UISlider不灵敏：改变slider的高度即可
    lazy var slider1: UISlider = {
        let slider = UISlider()
        slider.center = self.center
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumValueImage = UIImage(named:"ring")  //左边图标
        slider.setValue(UserDefaults.standard.float(forKey: "s1V"), animated: true)
        slider.isContinuous = true
        return slider
    }()
    
    lazy var ringTitle: UILabel = {
        let label = UILabel()
        label.text = "闹钟音量"
        label.font = UIFont.systemFont(ofSize: 13 * SCALE_WIDTH, weight: UIFont.Weight.light)
        return label
    }()
    
    lazy var slider2: UISlider = {
        let slider = UISlider()
        slider.center = self.center
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = UserDefaults.standard.float(forKey: "s2V")
        slider.minimumValueImage = UIImage(named:"alarm")  //左边图标
        return slider
    }()
    
    lazy var mediaTitle: UILabel = {
        let label = UILabel()
        label.text = "媒体音量"
        label.font = UIFont.systemFont(ofSize: 13 * SCALE_WIDTH, weight: UIFont.Weight.light)
        return label
    }()
    
    lazy var slider3: UISlider = {
        let slider = UISlider()
        slider.center = self.center
        slider.minimumValue = 0  //最小值
        slider.maximumValue = 1  //最大值
        slider.value = UserDefaults.standard.float(forKey: "s3V")
        slider.minimumValueImage = UIImage(named:"media")  //左边图标
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(10 * SCALE_WIDTH)
            make.left.equalTo(20 * SCALE_WIDTH)
            make.width.equalTo(80 * SCALE_WIDTH)
            make.height.equalTo(13 * SCALE_WIDTH)
        }
        
        self.addSubview(alarmTitle)
        alarmTitle.snp.makeConstraints { (make) in
            make.top.equalTo(50 * SCALE_WIDTH)
            make.left.equalTo(40 * SCALE_WIDTH)
            make.height.equalTo(10 * SCALE_WIDTH)
            make.width.equalTo(80 * SCALE_WIDTH)
        }
        
        self.addSubview(slider1)
        slider1.snp.makeConstraints { (make) in
            make.top.equalTo(80 * SCALE_WIDTH)
            make.left.equalTo(12 * SCALE_WIDTH)
            make.right.equalTo(-40 * SCALE_WIDTH)
            make.height.equalTo(10 * SCALE_WIDTH)
        }
        
        self.addSubview(ringTitle)
        ringTitle.snp.makeConstraints { (make) in
            make.top.equalTo(110 * SCALE_WIDTH)
            make.left.equalTo(40 * SCALE_WIDTH)
            make.height.equalTo(10 * SCALE_WIDTH)
            make.width.equalTo(80 * SCALE_WIDTH)
        }
        
        self.addSubview(slider2)
        slider2.snp.makeConstraints { (make) in
            make.top.equalTo(140 * SCALE_WIDTH)
            make.left.equalTo(12 * SCALE_WIDTH)
            make.right.equalTo(-40 * SCALE_WIDTH)
            make.height.equalTo(10 * SCALE_WIDTH)
        }
        
        self.addSubview(mediaTitle)
        mediaTitle.snp.makeConstraints { (make) in
            make.top.equalTo(170 * SCALE_WIDTH)
            make.left.equalTo(40 * SCALE_WIDTH)
            make.height.equalTo(10 * SCALE_WIDTH)
            make.width.equalTo(80 * SCALE_WIDTH)
        }
        
        self.addSubview(slider3)
        slider3.snp.makeConstraints { (make) in
            make.top.equalTo(200 * SCALE_WIDTH)
            make.left.equalTo(12 * SCALE_WIDTH)
            make.right.equalTo(-40 * SCALE_WIDTH)
            make.height.equalTo(10 * SCALE_WIDTH)
        }
    }
    
    func saveValue(){
        UserDefaults.standard.set(slider1.value, forKey: "s1V")
        UserDefaults.standard.set(slider2.value, forKey: "s2V")
        UserDefaults.standard.set(slider3.value, forKey: "s3V")
    }
}
