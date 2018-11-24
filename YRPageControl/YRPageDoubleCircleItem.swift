//
//  YRPageDoubleCircleItem.swift
//  QminiFund
//
//  Created by zhangyr on 15/10/20.
//  Copyright © 2015年 quchaogu. All rights reserved.
//

import UIKit
import SnapKit

class YRPageDoubleCircleItem: YRPageCircleItem {

    fileprivate var _insideCircle : UILabel?
    var outsideColor          : UIColor = UIColor.white {
        didSet {
            self.layer.borderWidth = 1
            self.layer.borderColor = outsideColor.cgColor
        }
    }
    
    override func setRadius() {
        super.setRadius()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = outsideColor.cgColor
        _insideCircle = UILabel()
        _insideCircle?.layer.cornerRadius  = radius - 2
        _insideCircle?.layer.masksToBounds = true
        _insideCircle?.backgroundColor     = didselectedColor
        self.addSubview(_insideCircle!)
        
        _insideCircle?.snp.makeConstraints({ (maker) -> Void in
            maker.centerX.equalTo(self)
            maker.centerY.equalTo(self)
            maker.width.equalTo((self.radius - 2) * 2)
            maker.height.equalTo((self.radius - 2) * 2)
        })
        
    }
    
    override func didSelected() {
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self._insideCircle?.alpha = 1
        }) 
    }
    
    override func didNotSelected() {
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self._insideCircle?.alpha = 0
        }) 
    }

}
