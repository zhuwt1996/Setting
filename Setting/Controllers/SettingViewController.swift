//
//  SettingViewController.swift
//  Setting
//
//  Created by ZWT on 2019/10/10.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit


let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
let SCALE_HEIGHT = SCREEN_HEIGHT / 667.0
let SCALE_WIDTH = SCREEN_WIDTH / 375.0
class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    // 搜索控制器
    var searchController: UISearchController!
    
    //定义数据源,字典型数组
    var dataSource : Dictionary<Int,[SettingCell]>!
    //定义一个原始的cell数组
    var originalArray = [SettingCell]()
    //定义一个过滤的cell数组
    var filteredCells = [SettingCell]()
    //定义一个Dict数组，用于存放系统设置项，即Dictionary中的title和icon
    var titleArray : [String]!

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
        //指向一个 UISearchResultsUpdating 协议。
        self.searchController.searchResultsUpdater = self
        //如果使用一个新的vc来展示搜索结果，那么默认点击搜索会模糊背景
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        self.searchController.searchBar.placeholder = "搜索系统设置项"
        
        self.navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        //确保当 UISearchController 为活跃状态时，用户导航到了新的 ViewController（如从搜索结果）， 搜索栏还在屏幕最上方。
        self.definesPresentationContext = true
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        //解决最后一项无法显示的bug
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0.0
        self.themeHeaders = [
            "",
            "网络和连接",
            "个人",
            "系统和设备",
            "账号",
            "应用设置和管理"
        ]
        
        self.dataSource = [
            0:[
                SettingCell(settingTitle: "我的设备", icon: "MyDevice")
            ],
            1:[
                SettingCell(settingTitle: "双卡和移动网络", icon: "Net"),
                SettingCell(settingTitle: "WLAN", icon: "WIFI"),
                SettingCell(settingTitle: "蓝牙", icon: "BlueTooth"),
                SettingCell(settingTitle: "个人热点", icon: "HotPoint"),
                SettingCell(settingTitle: "VPN", icon: "VPN"),
                SettingCell(settingTitle: "流量使用情况", icon: "Situation"),
                SettingCell(settingTitle: "更多连接方式", icon: "MoreConnect")
            ],
            2:[
                SettingCell(settingTitle: "显示", icon: "Apperance"),
                SettingCell(settingTitle: "壁纸", icon: "WallPaper"),
                SettingCell(settingTitle: "个性主题", icon: "Theme"),
                SettingCell(settingTitle: "声音和振动", icon: "Sound")
            ],
            3:[
                SettingCell(settingTitle: "锁屏、密码和指纹", icon: "Lock"),
                SettingCell(settingTitle: "通知和状态栏", icon: "Noti"),
                SettingCell(settingTitle: "桌面与最近任务", icon: "Task"),
                SettingCell(settingTitle: "全面屏", icon: "FullScreen"),
                SettingCell(settingTitle: "小爱同学", icon: "XiaoAi"),
                SettingCell(settingTitle: "手机分身", icon: "OtherPhone"),
                SettingCell(settingTitle: "电量和性能", icon: "Ele"),
                SettingCell(settingTitle: "存储空间", icon: "Save"),
                SettingCell(settingTitle: "SOS紧急求助", icon: "SOS"),
                SettingCell(settingTitle: "MIUI实验室", icon: "MIUI"),
                SettingCell(settingTitle: "更多设置", icon: "MoreSetting")
            ],
            4:[
                SettingCell(settingTitle: "小米账号", icon: "Mi"),
                SettingCell(settingTitle: "同步", icon: "Syn")
            ],
            5:[
                SettingCell(settingTitle: "系统应用设置", icon: "App"),
                SettingCell(settingTitle: "应用管理", icon: "AppManage"),
                SettingCell(settingTitle: "应用双开", icon: "DoubleApp"),
                SettingCell(settingTitle: "授权管理", icon: "Manage"),
                SettingCell(settingTitle: "应用锁", icon: "AppLock"),
                SettingCell(settingTitle: "用户手册", icon: "UserBook"),
                SettingCell(settingTitle: "问题反馈", icon: "Ques"),
                SettingCell(settingTitle: "小米服务", icon: "Service")
            ]
        ]
        for (_,cells) in dataSource{
            for cell in cells{
                self.originalArray.append(cell)
            }
        }

        
        tableView.delegate = self
        tableView.dataSource = self
        
         view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        if isFiltering() {
            return 1
        }
        return themeHeaders.count
    }
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filteredCells.count
        }

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
        
//        var data = self.dataSource[indexPath.section]
//        let dict = data![indexPath.row]
//        cell?.iconImv.image = UIImage(named: dict["icon"]!)
//        cell?.titleLabel.text = dict["title"]
        
        if isFiltering() {
            let cellModel = filteredCells[indexPath.row]
            cell?.iconImv.image = UIImage(named: cellModel.icon!)
            cell?.titleLabel.text = cellModel.settingTitle
            return cell!
        }
        
        var data = self.dataSource[indexPath.section]
        let mysetting = data![indexPath.row]
        cell?.iconImv.image = UIImage(named: mysetting.icon!)
        cell?.titleLabel.text = mysetting.settingTitle
        return cell!
        
        
    }
    
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //消除footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }

    //设置header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let label = UILabel(frame: CGRect(x: 20, y: 10, width: 150, height: 5))
        label.text = self.themeHeaders[section]
        label.font = UIFont.systemFont(ofSize: 13 * SCALE_WIDTH)
        view.addSubview(label)
        
        return view
    }
    
    //消除第一个section的header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.01
        }
        return 30
    }
}

extension SettingViewController: UISearchResultsUpdating {
    //实时进行搜索
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    //过滤出搜索项
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCells = originalArray.filter({( myCell) -> Bool in
            return myCell.settingTitle?.lowercased().contains(searchText.lowercased()) ?? false
        })
        
        tableView.reloadData()
    }
    
    //判断searchbar是否为空
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //是否开启搜索
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
