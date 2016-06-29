//
//  ViewController.swift
//  BGInfiniteScrollView
//
//  Created by test on 16/6/29.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

struct ViewConfig {
    var bgColor:UIColor = UIColor.redColor()
    var title:String = ""
}

class ViewController: UIViewController {
    var dataList:[ViewConfig] = []
    let infinitScorllView = BGInfinitScrollView()
    var timer:NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for x in 0..<5 {
            let color = UIColor(red: CGFloat(random()%255)/255.0, green: CGFloat(random()%255)/255.0, blue: CGFloat(random()%255)/255.0, alpha: 1)
            var viewConfig = ViewConfig()
            viewConfig.bgColor = color
            viewConfig.title = "\(x) View"
            dataList.append(viewConfig)
        }
        
        useInfinitScrollView()
        startAnimation()
        
    }

    func useInfinitScrollView() {
        infinitScorllView.pagingEnabled = true
        infinitScorllView.delegate = self
        
        let count = dataList.count
        let width = UIScreen.mainScreen().bounds.width
        
        for x in 0 ..< count {
            let point = CGPointMake(CGFloat(x) * width, 0)
            let config = dataList[x]
            addView(point, config: config ,toView: infinitScorllView )
        }
        
        //添加一个额外的view在scroll末尾 当滑动到末尾是显示第一个视图
        let point = CGPointMake(CGFloat(count) * width, 0)
        let config = dataList.first
        addView(point, config: config! ,toView: infinitScorllView)
        
        infinitScorllView.contentSize = CGSizeMake(CGFloat(count + 1) * width, 0)
        
        infinitScorllView.frame = CGRectMake(0, 100, width, 150)
        self.view.addSubview(infinitScorllView)
    }
    
    func addView(point: CGPoint, config: ViewConfig, toView: UIView) {
        let viewa = UILabel(frame: CGRectMake(point.x, point.y, UIScreen.mainScreen().bounds.width, 150))
        viewa.backgroundColor = config.bgColor
        viewa.text = config.title
        viewa.font = UIFont.systemFontOfSize(40)
        viewa.textAlignment = .Center
        toView.addSubview(viewa)
    }
    
    func startAnimation() {
        self.timer = NSTimer(timeInterval: 2.0, target: self, selector: #selector(self.scrollViewInfinitScrollView), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
        
    }
    
    func stopAnimation() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func scrollViewInfinitScrollView() {
        var offset = infinitScorllView.contentOffset
        var index = Int(offset.x / infinitScorllView.frame.width)
        index += 1
        //当自动轮播到额外的一个view时就触发了layoutSubView的判断
        offset.x = CGFloat(index) *  infinitScorllView.frame.width
        dispatch_async(dispatch_get_main_queue()) {
            self.infinitScorllView.setContentOffset(offset, animated: true)
        }
    }
}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAnimation()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopAnimation()
    }
}
