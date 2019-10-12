//
//  MuteTableViewCell.swift
//  Setting
//
//  Created by ZWT on 2019/10/12.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class MuteTableView: UIView {

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
    
    lazy var alarmImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "alarm")
        
        return imgView
    }()
    
    lazy var slider1: UISlider = {
        let slider = UISlider()
        slider.center = self.center
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        return slider
    }()
    
    lazy var ringTitle: UILabel = {
        let label = UILabel()
        label.text = "闹钟音量"
        label.font = UIFont.systemFont(ofSize: 13 * SCALE_WIDTH, weight: UIFont.Weight.light)
        return label
    }()
    
    lazy var ringImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "ring")
        
        return imgView
    }()
    
    lazy var slider2: UISlider = {
        let slider = UISlider()
        slider.center = self.center
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        return slider
    }()
    
    lazy var mediaTitle: UILabel = {
        let label = UILabel()
        label.text = "媒体音量"
        label.font = UIFont.systemFont(ofSize: 13 * SCALE_WIDTH, weight: UIFont.Weight.light)
        return label
    }()
    
    lazy var mediaImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "media")
        
        return imgView
    }()
    
    lazy var slider3: UISlider = {
        let slider = UISlider()
        slider.center = self.center
        slider.minimumValue = 0  //最小值
        slider.maximumValue = 1  //最大值
        slider.value = 0 //当前默认值
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
        self.addSubview(ringImg)
        ringImg.snp.makeConstraints { (make) in
            make.top.equalTo(65 * SCALE_WIDTH)
            make.left.equalTo(12 * SCALE_WIDTH)
            make.height.equalTo(30 * SCALE_WIDTH)
            make.width.equalTo(30 * SCALE_WIDTH)
        }
        self.addSubview(slider1)
        slider1.snp.makeConstraints { (make) in
            make.top.equalTo(80 * SCALE_WIDTH)
            make.left.equalTo(40 * SCALE_WIDTH)
            make.right.equalTo(-40 * SCALE_WIDTH)
            make.height.equalTo(1 * SCALE_WIDTH)
        }
        
        self.addSubview(ringTitle)
        ringTitle.snp.makeConstraints { (make) in
            make.top.equalTo(110 * SCALE_WIDTH)
            make.left.equalTo(40 * SCALE_WIDTH)
            make.height.equalTo(10 * SCALE_WIDTH)
            make.width.equalTo(80 * SCALE_WIDTH)
        }
        self.addSubview(alarmImg)
        alarmImg.snp.makeConstraints { (make) in
            make.top.equalTo(125 * SCALE_WIDTH)
            make.left.equalTo(12 * SCALE_WIDTH)
            make.height.equalTo(30 * SCALE_WIDTH)
            make.width.equalTo(30 * SCALE_WIDTH)
        }
        self.addSubview(slider2)
        slider2.snp.makeConstraints { (make) in
            make.top.equalTo(140 * SCALE_WIDTH)
            make.left.equalTo(40 * SCALE_WIDTH)
            make.right.equalTo(-40 * SCALE_WIDTH)
            make.height.equalTo(1 * SCALE_WIDTH)
        }
        
        self.addSubview(mediaTitle)
        mediaTitle.snp.makeConstraints { (make) in
            make.top.equalTo(170 * SCALE_WIDTH)
            make.left.equalTo(40 * SCALE_WIDTH)
            make.height.equalTo(10 * SCALE_WIDTH)
            make.width.equalTo(80 * SCALE_WIDTH)
        }
        self.addSubview(mediaImg)
        mediaImg.snp.makeConstraints { (make) in
            make.top.equalTo(185 * SCALE_WIDTH)
            make.left.equalTo(12 * SCALE_WIDTH)
            make.height.equalTo(30 * SCALE_WIDTH)
            make.width.equalTo(30 * SCALE_WIDTH)
        }
        self.addSubview(slider3)
        slider3.snp.makeConstraints { (make) in
            make.top.equalTo(200 * SCALE_WIDTH)
            make.left.equalTo(40 * SCALE_WIDTH)
            make.right.equalTo(-40 * SCALE_WIDTH)
            make.height.equalTo(1 * SCALE_WIDTH)
        }
        
        
    }

}
