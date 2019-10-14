//
//  DiyThemeViewController.swift
//  Setting
//
//  Created by ZWT on 2019/10/14.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit
/**
 手势学习
 */

class DiyThemeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    var isEdite = false
    
    //数据源
    var headerArr = [["切换主题","点击添加更多主题"],["长按拖动排序","点击添加更多主题"]]
    var selectedArr = ["推荐","河北","财经","娱乐","体育","社会","NBA","视频","汽车","图片","科技","军事","国际","数码","星座","电影","时尚","文化","游戏","教育","动漫","政务","纪录片","房产","佛学","股票","理财"]
    
    var recommendArr = ["有声","家居","电竞","美容","电视剧","搏击","健康","摄影","生活","旅游","韩流","探索","综艺","美食","育儿"]
    
    //定义一个UICollectionView
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: self.view.frame, collectionViewLayout: ThemeLayout())
        
        //添加长按手势
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(press(_:)))
        view.addGestureRecognizer(longPressGesture)
        
        //添加头cell
        view.register(ThemeHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ThemeHeader")
        //添加内容cell
        view.register(ThemeContentViewCell.self, forCellWithReuseIdentifier: "ThemeContent")
        
        view.delegate = self
        view.dataSource = self
        
        view.backgroundColor = UIColor.white
        return view
    }()
    
    @objc fileprivate func press(_ tap: UILongPressGestureRecognizer){
        print("嘻嘻嘻你长按个屁")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个性主题"
        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(-48 * SCALE_WIDTH)
            make.left.right.bottom.equalToSuperview()
            
        }
    }
    
//    init(a:[String], b:[String]) {
//        selectedArr = a
//        recommendArr = b
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

extension DiyThemeViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? selectedArr.count : recommendArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeContent", for: indexPath) as! ThemeContentViewCell
        
        cell.text = indexPath.section == 0 ? selectedArr[indexPath.item] : recommendArr[indexPath.item]
        cell.edite = (indexPath.section == 0 && indexPath.item == 0) ? false : isEdite
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ThemeHeader", for: indexPath) as! ThemeHeaderViewCell
        header.text = isEdite ? headerArr[1][indexPath.section] : headerArr[0][indexPath.section]
        header.button.isSelected = isEdite
        if indexPath.section > 0 {
            header.button.isHidden = true
            
        } else {
            header.button.isHidden = false
            
        }
        
        
        header.clickCallback = {[weak self] in
            
            self?.isEdite = !(self?.isEdite)!
            collectionView.reloadData()
            
        }
        
        return header
        
    }
    
}
