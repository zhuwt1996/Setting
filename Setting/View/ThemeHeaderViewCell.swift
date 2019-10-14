//
//  ThemeHeaderViewCell.swift
//  Setting
//
//  Created by ZWT on 2019/10/14.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class ThemeHeaderViewCell: UICollectionViewCell {
    var clickCallback: (() -> ())?
    
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
        
        addSubview(label)
        addSubview(button)
        backgroundColor = UIColor.groupTableViewBackground
    }
    
    @objc func buttonClick() {
        
        if (clickCallback != nil) { clickCallback!() }
    }
    
    
    private lazy var label: UILabel = {
        
        let label = UILabel(frame: self.bounds)
        label.frame.origin.x = 20
        return label
    }()
    
    lazy var button: UIButton = {
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("编辑", for: .normal)
        btn.setTitle("完成", for: .selected)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.frame = CGRect(x: SCREEN_WIDTH - 80, y: 0, width: 80, height: self.frame.height)
        btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return btn
        
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
