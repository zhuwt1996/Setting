//
//  MyDeciveViewController.swift
//  Setting
//
//  Created by ZWT on 2019/10/11.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class MyDeciveViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
   
    //定义数据源,字典型数组
    var deviceDataSource : [MyDeviceCell]!
    var infoDataSource : [MyDeviceCell]!

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
        
        return layout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.frame.size.height - 65), collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.init(hexString: "#CACACA")
//        collectionView.contentInset = UIEdgeInsets.init(top: 41 * SCALE_WIDTH, left: 50 * SCALE_WIDTH, bottom: 69 * SCALE_WIDTH, right: 50 * SCALE_WIDTH)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.register(MyDeviceViewCell.self, forCellWithReuseIdentifier: "MyDevice")
        
        return collectionView
    }()
    
    fileprivate lazy var header: MyDeviceHeaderView = {
        let view = MyDeviceHeaderView()
        return view
    }()
    
    fileprivate lazy var header2: MyDeviceHeaderView = {
        let view = MyDeviceHeaderView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的设备"
        
        setupUI()
        
        self.deviceDataSource =
            [
               MyDeviceCell(deviceTitle: "处理器", des: "高通骁龙845", icon: "CLQ"),
               MyDeviceCell(deviceTitle: "电池容量", des: "3400mA(typ)", icon: "DCRL"),
               MyDeviceCell(deviceTitle: "后置摄像头", des: "12MP+12MP", icon: "HZSXT"),
               MyDeviceCell(deviceTitle: "屏幕尺寸", des: "6.21英寸", icon: "PMCC"),
               MyDeviceCell(deviceTitle: "分辨率", des: "2248*1080像素", icon: "FBL"),
               MyDeviceCell(deviceTitle: "运行内存", des: "6.00GB", icon: "YXNC")
            ]
    }
    
    func setupUI(){
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(header)
        header.snp.makeConstraints { (make) in
            make.top.equalTo(-50 * SCALE_WIDTH)
            make.left.right.equalToSuperview()
            make.height.equalTo(80 * SCALE_WIDTH)
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(250 * SCALE_WIDTH)
        }
        view.addSubview(header2)
        header2.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(-1 * SCALE_WIDTH)
            make.left.right.equalToSuperview()
            make.height.equalTo(80 * SCALE_WIDTH)
        }
        
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
        let myDeviceCell = deviceDataSource[indexPath.row]
        cell.textLabel.text = myDeviceCell.des
        cell.titleLabel.text = myDeviceCell.deviceTitle
        cell.imageView.image = UIImage.init(named: myDeviceCell.icon!)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
}

extension MyDeciveViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
