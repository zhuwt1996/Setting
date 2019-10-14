//
//  ThemeContentViewCell.swift
//  Setting
//
//  Created by ZWT on 2019/10/14.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class ThemeContentViewCell: UICollectionViewCell {
    var edite = true {
        didSet {
            
            imageView.isHidden = !edite
        }
    }
    
    var text: String? {
        
        didSet {
            
            label.text = text
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        contentView.addSubview(label)
        label.addSubview(imageView)
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    private lazy var label: UILabel = {
        
        let label = UILabel(frame: self.bounds)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        
        let image = UIImageView(frame: CGRect(x: 2, y: 2, width: 10, height: 10))
        image.image = UIImage(named: "close")
        image.isHidden = true
        return image
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
