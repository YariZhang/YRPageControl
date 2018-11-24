//
//  YRPageCircleItem.swift
//  QminiFund
//
//  Created by zhangyr on 15/10/20.
//  Copyright © 2015年 quchaogu. All rights reserved.
//

import UIKit

class YRPageCircleItem: YRPageItem {
    
    var radius : CGFloat = 1.5 {
        didSet {
            setRadius()
        }
    }
    
    func setRadius() {
        self.layer.cornerRadius  = radius
        self.layer.masksToBounds = true
    }

    override func didSelected() {
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.backgroundColor = self.didselectedColor
            self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) 
        
    }
    
    override func didNotSelected() {
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.backgroundColor = didNotSelectedColor
        self.transform = CGAffineTransform.identity
    }

}
