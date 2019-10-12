//
//  MyDeviceHeader.swift
//  Setting
//
//  Created by ZWT on 2019/10/11.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class MyDeviceHeaderView: UIView {

    lazy var img: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "MIUI10")
        
        return imgView
    }()
    
    lazy var title : UILabel = {
        let label = UILabel()
        label.text = "MIUI版本"
        label.font = UIFont.systemFont(ofSize: 16 * SCALE_WIDTH)
        return label
    }()
    
    lazy var subTitle : UILabel = {
        let label = UILabel()
        label.text = "MIUI10.3.6 | 稳定版"
        label.font = UIFont.systemFont(ofSize: 12 * SCALE_WIDTH, weight: UIFont.Weight.light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(img)
        self.addSubview(title)
        self.addSubview(subTitle)
        
        img.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(20 * SCALE_WIDTH)
            make.width.equalTo(80 * SCALE_WIDTH)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(20 * SCALE_WIDTH)
            make.left.equalTo(img.snp.right).offset(20 * SCALE_WIDTH)
            make.width.equalTo(80 * SCALE_WIDTH)
            make.height.equalTo(14 * SCALE_WIDTH)
        }
        
        subTitle.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(10 * SCALE_WIDTH)
            make.left.equalTo(title.snp.left)
            make.width.equalTo(150 * SCALE_WIDTH)
            make.height.equalTo(14 * SCALE_WIDTH)
        }
    }
    
}
