//
//  SettingViewController.swift
//  Setting
//
//  Created by ZWT on 2019/10/10.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    //定义数据源,字典型数组
    var dataSource = [[String:String]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        self.view.backgroundColor = UIColor.white
        
        let  tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dataSource = [["theme":"","icon":"MyDevice","title":"我的设备"],
                      ["theme":"网络和连接","icon":"Net","title":"双卡和移动网络"],
                      ["theme":"网络和连接","icon":"WIFI","title":"WLAN"],
                      ["theme":"网络和连接","icon":"BlueTooth","title":"蓝牙"],
                      ["theme":"网络和连接","icon":"HotPoint","title":"个人热点"],
                      ["theme":"网络和连接","icon":"VPN","title":"VPN"],
                      ["theme":"网络和连接","icon":"Situation","title":"流量使用情况"],
                      ["theme":"网络和连接","icon":"MoreConnect","title":"更多连接方式"],
                      ["theme":"个人","icon":"Apperance","title":"显示"],
                      ["theme":"个人","icon":"WallPaper","title":"壁纸"],
                      ["theme":"个人","icon":"Theme","title":"主题"],]
        
        tableView.reloadData()
        
    }


}


extension SettingViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "SettingID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? SettingTableViewCell
        if cell == nil {
            cell = SettingTableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        let dict = dataSource[indexPath.row]
        cell?.iconImv.image = UIImage(named: dict["icon"]!)
        cell?.titleLabel.text = dict["title"]
        
        return cell!
    }
    
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
