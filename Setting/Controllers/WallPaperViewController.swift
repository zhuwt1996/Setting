//
//  WallPaperViewController.swift
//  Setting
//
//  Created by ZWT on 2019/10/14.
//  Copyright © 2019 ZWT. All rights reserved.
//

import UIKit
/**
 UIScrollView:
 
    1、循环滚动
    2、定时自动跳转
    3、手动滑动图片
    4、刷新数据
    5、页控制器
 
reference：https://www.hangge.com/blog/cache/detail_1314.html
 https://github.com/zhuwt1996/Setting/blob/master/Setting/Assets.xcassets/acml.imageset/acml.jpg
 */

class WallPaperViewController: UIViewController,SliderPicViewControllerDelegate {

    var images = ["acml","bsln","lwp","gzhd"]
    
    //图片轮播组件
    var sliderPicVC : SliderPicViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "壁纸"
        view.backgroundColor = UIColor.white
        
        //初始化图片轮播组件
        sliderPicVC = SliderPicViewController()
        sliderPicVC.delegate = self
        sliderPicVC.view.frame = CGRect(x: 10, y: 40, width: SCREEN_WIDTH-20,
                                          height: (SCREEN_WIDTH-20)/4*3);
        
        //将图片轮播组件添加到当前视图
        self.addChild(sliderPicVC)
        self.view.addSubview(sliderPicVC.view)
        
        //添加组件的点击事件
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(WallPaperViewController.handleTapAction(_:)))
        sliderPicVC.view.addGestureRecognizer(tap)
        
        setupUI()
    }
    
    //点击事件响应
    @objc func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        //获取图片索引值
        let index = sliderPicVC.currentIndex
        //弹出索引信息
        let alertController = UIAlertController(title: "您点击的图片索引是：",
                                                message: "\(index)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func setupUI(){
        
    }
}

extension WallPaperViewController{
    func galleryDataSource() -> [String] {
         return images
    }
    
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: SCREEN_WIDTH-20, height: (SCREEN_WIDTH-20)/4*3)
    }
    
}
