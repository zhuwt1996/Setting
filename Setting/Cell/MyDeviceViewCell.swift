//
//  MyDeviceViewCell.swift
//  Setting
//
//  Created by ZWT on 2019/10/11.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit
import SnapKit

class MyDeviceViewCell: UICollectionViewCell {
    //图标
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12 * SCALE_WIDTH, weight: UIFont.Weight.light)
        label.textColor = UIColor.init(hexString: "#666666")
        label.textAlignment = NSTextAlignment.center
        
        return label
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14 * SCALE_WIDTH, weight: UIFont.Weight.black)
        label.textColor = UIColor.init(hexString: "#666666")
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        contentView.addSubview(titleLabel)
        imageView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(10 * SCALE_WIDTH)
            make.width.equalTo(40 * SCALE_WIDTH)
            make.height.equalTo(40 * SCALE_WIDTH)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(3 * SCALE_WIDTH)
        }
        
        

    }
    
}
