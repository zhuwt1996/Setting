//
//  SoundViewController.swift
//  Setting
//
//  Created by ZWT on 2019/10/12.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit
//使用UISlider实现进度条的拖动
class SoundViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //数据源
    var dataSource : Dictionary<Int,[String]>!
    //分组头标题
    var themeHeaders:[String]!
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: view.bounds,style: .grouped)
        //解决最后一项无法显示的bug
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 0.0
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    fileprivate lazy var muteView: MuteTableView = {
        let view = MuteTableView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "声音和振动"
        
        
        self.themeHeaders = ["声音","铃声","振动"]
        self.dataSource = [0:["静音/勿扰"],1:["电话铃声","短信铃声","日历铃声","来电秀","其他通知提醒"],2:["响铃时振动","静音时振动"]]
        
        setupUI()
    }

    fileprivate func setupUI(){
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(-48 * SCALE_WIDTH)
            make.bottom.left.right.equalToSuperview()
        }
    }
}

extension SoundViewController{
    
    //section的个数
    public func numberOfSections(in tableView: UITableView) -> Int {
        return themeHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "SoundId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        switch indexPath.section {
        case 0:
            cell?.addSubview(muteView)
            muteView.snp.makeConstraints({(make) in
                make.top.bottom.left.right.equalToSuperview()
            })
            cell?.selectionStyle = .none
        default:
            let cells = dataSource[indexPath.section]
            cell?.textLabel?.text = cells?[indexPath.row]
            //右侧箭头
            cell?.accessoryType = .disclosureIndicator
            //点击灰色
            cell?.selectionStyle = .blue
        }
        
        return cell!
    }
    
}

extension SoundViewController{
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            //静音/勿扰
            return 270
        default:
            return 60
        }
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
        label.font = UIFont.systemFont(ofSize: 12 * SCALE_WIDTH, weight: UIFont.Weight.light)
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
