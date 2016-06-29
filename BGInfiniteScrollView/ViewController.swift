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
        
    }

    func useInfinitScrollView() {
        infinitScorllView.pagingEnabled = true
        
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

}
