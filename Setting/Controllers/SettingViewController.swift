//
//  SettingViewController.swift
//  Setting
//
//  Created by ZWT on 2019/10/10.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // 搜索控制器
    var searchController: UISearchController!
    
    //定义数据源,字典型数组
    var dataSource : Dictionary<Int,[[String:String]]>!

    //分组头标题
    var themeHeaders:[String]!
    
    var  tableView : UITableView!
    
    //搜索过滤后的结果集
    var searchArray:[String] = [String](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        self.view.backgroundColor = UIColor.white
        
        
        // 初始化搜索控制器
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0.0
        self.themeHeaders = [
            "关于本机",
            "网络和连接",
            "个人"
        ]
        //初始化数据
        self.dataSource =  [
            0:[[String:String]]([
                ["icon":"MyDevice","title":"我的设备"]
            ]),
            1:[[String:String]]([
                ["icon":"Net","title":"双卡和移动网络"],
                ["icon":"WIFI","title":"WLAN"],
                ["icon":"BlueTooth","title":"蓝牙"],
                ["icon":"HotPoint","title":"个人热点"],
                ["icon":"VPN","title":"VPN"],
                ["icon":"Situation","title":"流量使用情况"],
                ["icon":"MoreConnect","title":"更多连接方式"],
                ]),
            2:[[String:String]]([
                ["icon":"Apperance","title":"显示"],
                ["icon":"WallPaper","title":"壁纸"],
                ["icon":"Theme","title":"主题"]
                ])
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        
         view.addSubview(tableView)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //导航栏的背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        //消除横线
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}


extension SettingViewController{
    
    //section的个数
    public func numberOfSections(in tableView: UITableView) -> Int {
        return themeHeaders.count
    }
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.dataSource[section]
        return data!.count
    }
    
    //返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "SettingID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? SettingTableViewCell
        if cell == nil {
            cell = SettingTableViewCell(style: .default, reuseIdentifier: cellID)
        }
        //右侧箭头
        cell?.accessoryType = .disclosureIndicator
        
        var data = self.dataSource[indexPath.section]
        let dict = data![indexPath.row]
        cell?.iconImv.image = UIImage(named: dict["icon"]!)
        cell?.titleLabel.text = dict["title"]
        
        return cell!
    }
    
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //header title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.themeHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension SettingViewController: UISearchResultsUpdating {
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
//        self.searchArray = self.dataSource.filter { (school) -> Bool in
////            return school.contains(searchController.searchBar.text!)
//            return true
//        }
    }
}

extension UINavigationController {
    
    
}
