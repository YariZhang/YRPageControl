//
//  YRPageItem.swift
//  QminiFund
//
//  Created by zhangyr on 15/10/20.
//  Copyright © 2015年 quchaogu. All rights reserved.
//

import UIKit

protocol YRPageItemDelegate : NSObjectProtocol {
    func pageItemClickWithTag(_ tag : Int)
}

class YRPageItem: UIButton {
    
    weak var delegate : YRPageItemDelegate?
    var didselectedColor : UIColor = UIColor.white
    var didNotSelectedColor : UIColor = UIColor.lightGray
    var duration : TimeInterval = 0.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(YRPageItem.touchAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func touchAction() {
        delegate?.pageItemClickWithTag(self.tag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSelected() {
        fatalError("didSelected must be override")
    }
    
    func didNotSelected() {
        fatalError("didNotSelected must be override")
    }

}
