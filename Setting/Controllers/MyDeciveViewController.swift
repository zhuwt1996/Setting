//
//  MyDeciveViewController.swift
//  Setting
//
//  Created by ZWT on 2019/10/11.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class MyDeciveViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //定义数据源,字典型数组
    var dataSource : [MyDeviceCell]!

    fileprivate lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        //垂直行距离
        layout.minimumLineSpacing = 1 * SCALE_WIDTH
        //水平行间距
        layout.minimumInteritemSpacing = 1 * SCALE_WIDTH
        //每个item的大小
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 3)/3, height: (SCREEN_WIDTH - 3)/3)
        //设置距离上 左 下 右
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0,bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        return layout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.frame.size.height - 64), collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.white
//        collectionView.contentInset = UIEdgeInsets.init(top: 41 * SCALE_WIDTH, left: 50 * SCALE_WIDTH, bottom: 69 * SCALE_WIDTH, right: 50 * SCALE_WIDTH)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.register(MyDeviceViewCell.self, forCellWithReuseIdentifier: "MyDevice")
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的设备"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(-50 * SCALE_WIDTH)
            make.bottom.left.right.equalToSuperview()
        }
        self.dataSource =
            [
               MyDeviceCell(deviceTitle: "处理器", des: "高通骁龙845", icon: "CLQ"),
               MyDeviceCell(deviceTitle: "电池容量", des: "3400mA(typ)", icon: "DCRL"),
               MyDeviceCell(deviceTitle: "后置摄像头", des: "12MP+12MP", icon: "HZSXT"),
               MyDeviceCell(deviceTitle: "屏幕尺寸", des: "6.21英寸", icon: "PMCC"),
               MyDeviceCell(deviceTitle: "分辨率", des: "2248*1080像素", icon: "FBL"),
               MyDeviceCell(deviceTitle: "运行内存", des: "6.00GB", icon: "YXNC")
            ]
    }
}

extension MyDeciveViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyDevice", for: indexPath) as! MyDeviceViewCell
        let myDeviceCell = dataSource[indexPath.row]
        cell.textLabel.text = myDeviceCell.des
        cell.titleLabel.text = myDeviceCell.deviceTitle
        cell.imageView.image = UIImage.init(named: myDeviceCell.icon!)
        return cell
    }
    
}
