//
//  SliderViewController.swift
//  Setting
//
//  Created by ZWT on 2019/10/14.
//  Copyright © 2019 ZWT. All rights reserved.
//

//reference:https://www.hangge.com/blog/cache/detail_1314.html

import UIKit

class SliderPicViewController: UIViewController,UIScrollViewDelegate {

    //代理
    var  delegate : SliderPicViewControllerDelegate!
    //数据源
    var dataSource : [String]!
    
    //当前展示的图片索引
    var currentIndex : Int = 0
    
    //用于轮播的左中右三个image（不管几张图片都是这三个imageView交替使用）
    var leftImageView , middleImageView , rightImageView : UIImageView?
    //放置imageView的滚动视图
    var scrollerView : UIScrollView?
    //scrollView的宽和高
    var scrollerViewWidth : CGFloat?
    var scrollerViewHeight : CGFloat?
    
    //页控制器（小圆点）
    var pageControl : UIPageControl?
    
    //加载指示符（用来当iamgeView还没将图片显示出来时，显示的图片）
    var placeholderImage:UIImage!
    
    //自动滚动计时器
    var autoScrollTimer:Timer?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //获取并设置scrollerView尺寸
        let size : CGSize = self.delegate.galleryScrollerViewSize()
        self.scrollerViewWidth = size.width
        self.scrollerViewHeight = size.height
        
        //获取数据
        self.dataSource =  self.delegate.galleryDataSource()
        //设置scrollerView
        self.configureScrollerView()
        //设置加载指示图片
        self.configurePlaceholder()
        //设置imageView
        self.configureImageView()
        //设置页控制器
        self.configurePageController()
        //设置自动滚动计时器
        self.configureAutoScrollTimer()
        
    }
    
    //设置scrollerView
    func configureScrollerView(){
        self.scrollerView = UIScrollView(frame: CGRect(x: 0,y: 0,
                                                       width: self.scrollerViewWidth!,
                                                       height: self.scrollerViewHeight!))
        self.scrollerView?.backgroundColor = UIColor.red
        self.scrollerView?.delegate = self
        self.scrollerView?.contentSize = CGSize(width: self.scrollerViewWidth! * 3,
                                                height: self.scrollerViewHeight!)
        //滚动视图内容区域向左偏移一个view的宽度
        self.scrollerView?.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
        self.scrollerView?.isPagingEnabled = true
        self.scrollerView?.bounces = false
        self.view.addSubview(self.scrollerView!)
        
    }
    
    //设置加载指示图片
    func configurePlaceholder(){
        //这里我使用ImageHelper将文字转换成图片，作为加载指示符
        let font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        let size = CGSize(width: self.scrollerViewWidth!, height: self.scrollerViewHeight!)
        placeholderImage = UIImage(text: "图片加载中...", font:font,
                                   color:UIColor.white, size:size)!
    }
    
    //设置imageView
    func configureImageView(){
        self.leftImageView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                       width: self.scrollerViewWidth!,
                                                       height: self.scrollerViewHeight!))
        self.middleImageView = UIImageView(frame: CGRect(x: self.scrollerViewWidth!, y: 0,
                                                         width: self.scrollerViewWidth!,
                                                         height: self.scrollerViewHeight! ))
        self.rightImageView = UIImageView(frame: CGRect(x: 2*self.scrollerViewWidth!, y: 0,
                                                        width: self.scrollerViewWidth!,
                                                        height: self.scrollerViewHeight!))
        self.scrollerView?.showsHorizontalScrollIndicator = false
        
        //设置初始时左中右三个imageView的图片（分别时数据源中最后一张，第一张，第二张图片）
        if(self.dataSource?.count != 0){
            resetImageViewSource()
        }
        
        self.scrollerView?.addSubview(self.leftImageView!)
        self.scrollerView?.addSubview(self.middleImageView!)
        self.scrollerView?.addSubview(self.rightImageView!)
    }
    
    //设置页控制器
    func configurePageController() {
        self.pageControl = UIPageControl(frame: CGRect(x: SCREEN_WIDTH/2-60,
                                                       y: self.scrollerViewHeight! - 20, width: 120, height: 20))
        self.pageControl?.numberOfPages = (self.dataSource?.count)!
        self.pageControl?.isUserInteractionEnabled = false
        self.view.addSubview(self.pageControl!)
    }
    
    //设置自动滚动计时器
    func configureAutoScrollTimer() {
        //设置一个定时器，每三秒钟滚动一次
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 5, target: self,
                                               selector: #selector(SliderPicViewController.letItScroll),
                                               userInfo: nil, repeats: true)
    }
    
    //计时器时间一到，滚动一张图片
    @objc func letItScroll(){
        let offset = CGPoint(x: 2*scrollerViewWidth!, y: 0)
        self.scrollerView?.setContentOffset(offset, animated: true)
    }
    
    //每当滚动后重新设置各个imageView的图片
    func resetImageViewSource() {
        //当前显示的是第一张图片
        if self.currentIndex == 0 {
 
            self.leftImageView?.image = UIImage(named: self.dataSource!.last!)
            self.middleImageView?.image = UIImage(named: self.dataSource!.first!)
            self.rightImageView?.image = UIImage(named: self.dataSource!.first!)
            let rightImageIndex = (self.dataSource?.count)!>1 ? 1 : 0 //保护
            self.rightImageView?.image = UIImage(named: self.dataSource![rightImageIndex])
        }
            //当前显示的是最后一张图片
        else if self.currentIndex == (self.dataSource?.count)! - 1 {
            self.leftImageView?.image = UIImage(named: self.dataSource![self.currentIndex-1])
            self.middleImageView?.image = UIImage(named: self.dataSource!.last!)
            self.rightImageView?.image = UIImage(named: self.dataSource!.first!)
            
        }
            //其他情况
        else{
            self.leftImageView?.image = UIImage(named: self.dataSource![self.currentIndex-1])
            self.middleImageView?.image = UIImage(named: self.dataSource![self.currentIndex])
            self.rightImageView?.image = UIImage(named: self.dataSource![self.currentIndex+1])
        }
    }
    
    //scrollView滚动完毕后触发
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取当前偏移量
        let offset = scrollView.contentOffset.x
        
        if(self.dataSource?.count != 0){
            
            //如果向左滑动（显示下一张）
            if(offset >= self.scrollerViewWidth!*2){
                //还原偏移量
                scrollView.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
                //视图索引+1
                self.currentIndex = self.currentIndex + 1
                
                if self.currentIndex == self.dataSource?.count {
                    self.currentIndex = 0
                }
            }
            
            //如果向右滑动（显示上一张）
            if(offset <= 0){
                //还原偏移量
                scrollView.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
                //视图索引-1
                self.currentIndex = self.currentIndex - 1
                
                if self.currentIndex == -1 {
                    self.currentIndex = (self.dataSource?.count)! - 1
                }
            }
            
            //重新设置各个imageView的图片
            resetImageViewSource()
            //设置页控制器当前页码
            self.pageControl?.currentPage = self.currentIndex
        }
    }
    
    //手动拖拽滚动开始
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //使自动滚动计时器失效（防止用户手动移动图片的时候这边也在自动滚动）
        autoScrollTimer?.invalidate()
    }
    
    //手动拖拽滚动结束
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        //重新启动自动滚动计时器
        configureAutoScrollTimer()
    }
    
    //重新加载数据
    func reloadData() {
        //索引重置
        self.currentIndex = 0
        //重新获取数据
        self.dataSource =  self.delegate.galleryDataSource()
        //页控制器更新
        self.pageControl?.numberOfPages = (self.dataSource?.count)!
        self.pageControl?.currentPage = 0
        //重新设置各个imageView的图片
        resetImageViewSource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


//图片轮播组件代理协议
protocol SliderPicViewControllerDelegate{
    //获取数据源
    func galleryDataSource()->[String]
    //获取内部scrollerView的宽高尺寸
    func galleryScrollerViewSize()->CGSize
}



