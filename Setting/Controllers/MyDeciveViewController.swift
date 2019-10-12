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
    var infoDataSource : [String]!

    
    fileprivate lazy var header: MyDeviceHeaderView = {
        let view = MyDeviceHeaderView()
        return view
    }()
    
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
    
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: view.bounds,style: .plain)
        //解决最后一项无法显示的bug
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0.0
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
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
        
        self.infoDataSource = ["手机型号","手机名称","机身储存","全部参数","小米商城","预置应用","法律信息","重要安全信息","认证信息"]
    }
    
    func setupUI(){
        
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
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(-1 * SCALE_WIDTH)
            make.left.right.bottom.equalToSuperview()
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
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "DeviceID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = infoDataSource[indexPath.row]
        //右侧箭头
        cell?.accessoryType = .disclosureIndicator
        //点击灰色
        cell?.selectionStyle = .blue
        return cell!
        
    }
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
