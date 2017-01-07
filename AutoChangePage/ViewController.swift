//
//  ViewController.swift
//  AutoChangePage
//
//  Created by Frank.Chen on 2017/1/7.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate  {
    
    let movieImage: [String] = ["movie01", "movie02", "movie03"] // 圖片名稱
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var currenPageNumber: Int = 0 // 當前頁數
    
    // MARK: - LifeCycle
    // ---------------------------------------------------------------------
    override func viewDidLoad() {
        let w: CGFloat = self.view.frame.size.width
        let h: CGFloat = self.view.frame.size.height - 20
        
        // 產生UIScrollView
        self.scrollView = UIScrollView()
        self.scrollView!.frame = CGRect(x: 0, y: 0, width: w, height: h)
        self.scrollView!.contentSize = CGSize(width: w * CGFloat(self.movieImage.count), height: h)
        self.scrollView!.backgroundColor = UIColor.clear
        self.scrollView!.showsVerticalScrollIndicator = true // 顯示右側垂直拉bar條
        self.scrollView!.showsHorizontalScrollIndicator = false // 隱藏底部平行拉bar條
        self.scrollView!.isPagingEnabled = true // 設定能以本身容器的寬度做切頁(橫向的scrollView)
        self.scrollView!.delegate = self
        
        // 生成UIPageControl(頁面數量顯示器)
        self.pageControl = UIPageControl()
        self.pageControl.frame = CGRect(x: 0, y: h, width: w, height: 20)
        self.pageControl.numberOfPages = movieImage.count
        self.pageControl.currentPage = 0
        
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageControl)
        
        // 動態產生三張電影圖片
        var imageView: UIImageView!
        for i in 0 ... 2 {
            imageView = UIImageView()
            imageView.frame = CGRect(x: w * CGFloat(i), y: 0, width: w, height: h)
            imageView.image = UIImage(named: self.movieImage[i])
            self.scrollView!.addSubview(imageView)
        }
        
        // 設定每?秒自動翻頁
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.onAutoChangePageAction), userInfo: nil, repeats: true)
    }

    // MARK: - CallBack & listener
    // ---------------------------------------------------------------------
    // 自動切頁
    func onAutoChangePageAction() {
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.size.width * CGFloat(self.currenPageNumber), y: 0), animated: true)
        self.pageControl.currentPage = self.currenPageNumber
        self.currenPageNumber += 1
        if self.currenPageNumber == 3 {
            self.currenPageNumber = 0
        }
    }

    // MARK: - Delegate
    // ---------------------------------------------------------------------
    // 滑動圖片切頁所會觸發的事件
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 利用scrollView的容器內X座標算出UIPageController要顯示第幾頁
        let currentPage: CGFloat = scrollView.contentOffset.x / self.view.frame.size.width
        self.pageControl.currentPage = Int(currentPage)
    }

}

