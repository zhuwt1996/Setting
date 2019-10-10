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
        //解决最后一项无法显示的bug
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0.0
        self.themeHeaders = [
            "关于本机",
            "网络和连接",
            "个人",
            "系统和设备",
            "应用设置和管理"
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
                ["icon":"Theme","title":"个性主题"],
                ["icon":"Sound","title":"声音和振动"]
                ]),
            3:[[String:String]]([
                ["icon":"Lock","title":"锁屏、密码和指纹"],
                ["icon":"Noti","title":"通知和状态栏"],
                ["icon":"Task","title":"桌面与最近任务"],
                ["icon":"FullScreen","title":"全面屏"],
                ["icon":"XiaoAi","title":"小爱同学"],
                ["icon":"OtherPhone","title":"手机分身"],
                ["icon":"Ele","title":"电量和性能"],
                ["icon":"Save","title":"存储空间"],
                ["icon":"SOS","title":"SOS紧急求助"],
                ["icon":"MIUI","title":"MIUI实验室"],
                ["icon":"MoreSetting","title":"更多设置"]
                ]),
            4:[[String:String]]([
                ["icon":"Mi","title":"小米账号"],
                ["icon":"Syn","title":"同步"],
                ["icon":"App","title":"系统应用设置"],
                ["icon":"AppManage","title":"应用管理"],
                ["icon":"DoubleApp","title":"应用双开"],
                ["icon":"Manage","title":"授权管理"],
                ["icon":"AppLock","title":"应用锁"],
                ["icon":"UserBook","title":"用户手册"],
                ["icon":"Ques","title":"问题反馈"],
                ["icon":"Service","title":"小米服务"]
                ])
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        
         view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if #available(iOS 11.0, *) {
//            navigationItem.hidesSearchBarWhenScrolling = false
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //导航栏的背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.white
//        if #available(iOS 11.0, *) {
//            navigationItem.hidesSearchBarWhenScrolling = true
//        }
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
        //点击灰色
        cell?.selectionStyle = .blue
        
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
