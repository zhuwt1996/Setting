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
    
    fileprivate lazy var selectBtn1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "unselected"), for: .normal)
        button.setImage(UIImage(named: "selected"), for: .selected)
        button.addTarget(self, action: #selector(changeBtn1State), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var selectBtn2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "unselected"), for: .normal)
        button.setImage(UIImage(named: "selected"), for: .selected)
        button.addTarget(self, action: #selector(changeBtn2State), for: .touchUpInside)
        return button
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
    
    @objc fileprivate func changeBtn1State(){
        selectBtn1.isSelected = !selectBtn1.isSelected
    }
    @objc fileprivate func changeBtn2State(){
        selectBtn2.isSelected = !selectBtn2.isSelected
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
        let sec = indexPath.section
        let row = indexPath.row
        if sec == 0{
            cell?.addSubview(muteView)
            muteView.snp.makeConstraints({(make) in
                make.top.bottom.left.right.equalToSuperview()
            })
            cell?.selectionStyle = .none
        }else{
            let cells = dataSource[indexPath.section]
            cell?.textLabel?.text = cells?[indexPath.row]
            //右侧箭头
            cell?.accessoryType = .disclosureIndicator
            //点击灰色
            cell?.selectionStyle = .blue
            if sec == 2{
                if row == 0{
                    cell?.addSubview(selectBtn1)
                    selectBtn1.snp.makeConstraints({(make) in
                        make.centerY.equalToSuperview()
                        make.right.equalTo(-10 * SCALE_WIDTH)
                        make.width.equalTo(85 * SCALE_WIDTH)
                        make.height.equalTo(45 * SCALE_WIDTH)
                    })
                }else if row == 1{
                    cell?.addSubview(selectBtn2)
                    selectBtn2.snp.makeConstraints({(make) in
                        make.centerY.equalToSuperview()
                        make.right.equalTo(-10 * SCALE_WIDTH)
                        make.width.equalTo(85 * SCALE_WIDTH)
                        make.height.equalTo(45 * SCALE_WIDTH)
                    })
                }
            }
        }
        
        
//        switch indexPath.section {
//            //声音
//            case 0:
//                cell?.addSubview(muteView)
//                muteView.snp.makeConstraints({(make) in
//                    make.top.bottom.left.right.equalToSuperview()
//                })
//                cell?.selectionStyle = .none
//            //振动
////            case 2:
////                switch indexPath.row {
////                     //响铃
////                    case 0:
////                       cell?.addSubview(selectBtn)
////                       muteView.snp.makeConstraints({(make) in
////                        make.top.bottom.equalToSuperview()
////                        make.right.equalTo(-20 * SCALE_WIDTH)
////                       })
////                    //静音
////                    case 1:
////
////                        break
////                    default:
////                        break
////                }
//        default:
//            let cells = dataSource[indexPath.section]
//            cell?.textLabel?.text = cells?[indexPath.row]
//            //右侧箭头
//            cell?.accessoryType = .disclosureIndicator
//            //点击灰色
//            cell?.selectionStyle = .blue
//
//        }
        
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
