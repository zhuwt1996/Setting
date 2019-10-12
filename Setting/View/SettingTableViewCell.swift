//
//  SettingTableViewCell.swift
//  Setting
//
//  Created by ZWT on 2019/10/10.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    //定义每个cell的宽度
    let width = UIScreen.main.bounds.width
    var titleLabel:UILabel!      // title
    var iconImv:UIImageView!    // 图片
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    fileprivate func setupUI(){
        titleLabel = UILabel(frame: CGRect(x: 75, y: 25, width: 150, height: 12))
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        
        iconImv = UIImageView(frame: CGRect(x: 20, y: 12, width: 44, height: 40))
        iconImv.layer.masksToBounds = true
        iconImv.layer.cornerRadius = 22.0
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(iconImv)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
