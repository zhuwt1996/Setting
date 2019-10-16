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

class DiyThemeViewController: UIViewController{
    
    var switchoverCallback: ((_ selectedArr: [String], _ recommendArr: [String], _ index: Int) -> ())?
    
    var isEdite = false
    
    var indexPath: IndexPath?
    var targetIndexPath: IndexPath?
    //数据源
    var headerArr = [["切换主题","点击添加更多主题"],["长按拖动排序","点击添加更多主题"]]
    var selectedArr = ["推荐","河北","财经","娱乐","体育","社会","NBA","视频","汽车","图片","科技","军事","国际","数码","星座","电影","时尚","文化","游戏","教育","动漫","政务","纪录片","房产","佛学","股票","理财"]
    
    var recommendArr = ["有声","家居","电竞","美容","电视剧","搏击","健康","摄影","生活","旅游","韩流","探索","综艺","美食","育儿"]
    
    private lazy var dragingItem: ThemeContentViewCell = {
        
        let cell = ThemeContentViewCell(frame: CGRect(x: 0, y: 0, width: itemW, height: itemW * 0.5))
        cell.isHidden = true
        return cell
    }()
    
    
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
        if !isEdite {
            
            isEdite = !isEdite
            collectionView.reloadData()
            return
        }
        let point = tap.location(in: collectionView)
        
        switch tap.state {
        case UIGestureRecognizerState.began:
            dragBegan(point: point)
        case UIGestureRecognizerState.changed:
            drageChanged(point: point)
        case UIGestureRecognizerState.ended:
            drageEnded(point: point)
        case UIGestureRecognizerState.cancelled:
            drageEnded(point: point)
        default: break
            
        }
    }
    
    //MARK: - 长按开始
    private func dragBegan(point: CGPoint) {
        
        
        
        indexPath = collectionView.indexPathForItem(at: point)
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0
        {return}
        
        let item = collectionView.cellForItem(at: indexPath!) as? ThemeContentViewCell
        item?.isHidden = true
        dragingItem.isHidden = false
        dragingItem.frame = (item?.frame)!
        dragingItem.text = item!.text
        dragingItem.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    //MARK: - 长按过程
    private func drageChanged(point: CGPoint) {
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0 {return}
        dragingItem.center = point
        targetIndexPath = collectionView.indexPathForItem(at: point)
        if targetIndexPath == nil || (targetIndexPath?.section)! > 0 || indexPath == targetIndexPath || targetIndexPath?.item == 0 {return}
        // 更新数据
        let obj = selectedArr[indexPath!.item]
        selectedArr.remove(at: indexPath!.row)
        selectedArr.insert(obj, at: targetIndexPath!.item)
        //交换位置
        collectionView.moveItem(at: indexPath!, to: targetIndexPath!)
        indexPath = targetIndexPath
    }
    
    //MARK: - 长按结束
    private func drageEnded(point: CGPoint) {
        
        if indexPath == nil || (indexPath?.section)! > 0 || indexPath?.item == 0 {return}
        let endCell = collectionView.cellForItem(at: indexPath!)
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.dragingItem.transform = CGAffineTransform.identity
            self.dragingItem.center = (endCell?.center)!
            
        }, completion: {
            
            (finish) -> () in
            
            endCell?.isHidden = false
            self.dragingItem.isHidden = true
            self.indexPath = nil
            
        })
        
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
            make.top.equalTo(-52 * SCALE_WIDTH)
            make.left.right.bottom.equalToSuperview()
            
        }
    }
    
}

extension DiyThemeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if indexPath.section > 0 {
            
            // 更新数据
            let obj = recommendArr[indexPath.item]
            recommendArr.remove(at: indexPath.item)
            selectedArr.append(obj)
            collectionView.moveItem(at: indexPath, to: NSIndexPath(item: selectedArr.count - 1, section: 0) as IndexPath)
            
        } else {
            
            if isEdite {
                
                if indexPath.item == 0 {return}
                // 更新数据
                let obj = selectedArr[indexPath.item]
                selectedArr.remove(at: indexPath.item)
                recommendArr.insert(obj, at: 0)
                collectionView.moveItem(at: indexPath, to: NSIndexPath(item: 0, section: 1) as IndexPath)
                
            } else {
                
                if switchoverCallback != nil {
                    
                    switchoverCallback!(selectedArr, recommendArr, indexPath.item)
                    _ = navigationController?.popViewController(animated: true)
                }
            }
        }
        
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
