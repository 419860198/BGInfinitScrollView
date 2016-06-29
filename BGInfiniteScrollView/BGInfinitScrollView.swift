//
//  BGInfinitScrollView.swift
//  BGInfiniteScrollView
//
//  Created by test on 16/6/29.
//  Copyright © 2016年 test. All rights reserved.
//

import UIKit

class BGInfinitScrollView: UIScrollView {

    override func layoutSubviews() {
        var offset = contentOffset
        if offset.x < 0 {
            offset.x = contentSize.width - frame.width
            contentOffset = offset
        }else if offset.x >= contentSize.width - frame.width{
            offset.x = 0
            contentOffset = offset
        }
    }
    
}
