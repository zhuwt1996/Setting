//
//  ThemeLayout.swift
//  Setting
//
//  Created by ZWT on 2019/10/14.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

let itemW: CGFloat = (SCREEN_WIDTH - 100) * 0.25

class ThemeLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        
        headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 40)
        itemSize = CGSize(width: itemW, height: itemW * 0.5)
        minimumLineSpacing = 15
        minimumInteritemSpacing = 20
        sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
    }
}
