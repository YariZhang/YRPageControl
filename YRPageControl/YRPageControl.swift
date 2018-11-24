//
//  YRPageControl.swift
//  QminiFund
//
//  Created by zhangyr on 15/10/20.
//  Copyright © 2015年 quchaogu. All rights reserved.
//

import UIKit

public enum YRPageType : Int {
    case circle
    case rectangle
    case doubleCircle
}

@objc public protocol YRPageControlDelegate : NSObjectProtocol {
    @objc optional func pageControl(_ pageControl : YRPageControl , didSelectedPage page : Int)
}

open class YRPageControl: UIView, YRPageItemDelegate {

    ///style for page control (default is .Circle)
    public var pageControlStyle : YRPageType = .circle {
        didSet {
            initAllItems()
        }
    }
    ///count of pages (default is 0)
    public var numberOfPages : Int = 0 {
        didSet {
            initAllItems()
        }
    }
    ///current page to show (default is 0)
    public var currentPage : Int = 0 {
        didSet {
            selectedItem()
        }
    }
    ///color for current page (default is whiteColor)
    public var currentPageIndicatorTintColor : UIColor = UIColor.white {
        didSet {
            initAllItems()
        }
    }
    ///color for other page that not show now (default is lightGrayColor)
    public var indicatorTintColor : UIColor = UIColor.lightGray {
        didSet {
            initAllItems()
        }
    }
    ///duration for animation (default is 0.2)
    public var duration : TimeInterval = 0.2
    ///delegate for page control (comply with YRPageControlDelegate)
    public weak var delegate : YRPageControlDelegate?
    ///size for rectangle (only for rectangle)
    public var sizeOfRectangle : CGSize = CGSize(width: 16, height: 2) {
        didSet {
            initAllItems()
        }
    }
    ///radius for circle (only for circle)
    public var radius : CGFloat = 2.5 {
        didSet {
            initAllItems()
        }
    }
    ///space for each item (default is 2)
    public var space : CGFloat = 2 {
        didSet {
            initAllItems()
        }
    }
    ///outside circle color (only for double circle , default is white)
    public var outsideColor : UIColor = UIColor.white
    ///pageControl enable (default is true)
    public var pageControlEnabled : Bool = true
    
    
    private func initAllItems() {
        currentPage = 0
        lastItem = 0
        var width : CGFloat = 0
        
        switch pageControlStyle {
        case .circle :
            width = CGFloat(numberOfPages) * radius * 2 + CGFloat(numberOfPages - 1) * space
        case .rectangle :
            width = CGFloat(numberOfPages) * sizeOfRectangle.width + CGFloat(numberOfPages - 1) * space
        case .doubleCircle :
            width = CGFloat(numberOfPages) * radius * 2 + CGFloat(numberOfPages - 1) * space
        }
        
        if width < 0 {
            width = 0
        }
        
        contentArray.removeAll(keepingCapacity: false)
        
        if contentView != nil {
            for v in contentView.subviews {
                v.removeFromSuperview()
            }
        }else{
            contentView = UIView()
            self.addSubview(contentView)
        }
        
        contentView.snp.remakeConstraints({ (maker) -> Void in
            maker.centerX.equalTo(self)
            maker.top.equalTo(self)
            maker.bottom.equalTo(self)
            maker.width.equalTo(width)
        })
        
        addItem()
        
    }
    
    private func addItem() {
        for i in 0 ..< numberOfPages {
            switch pageControlStyle {
            case .circle :
                let cItem                 = YRPageCircleItem()
                cItem.didselectedColor    = currentPageIndicatorTintColor
                cItem.didNotSelectedColor = indicatorTintColor
                cItem.radius              = radius
                cItem.duration            = duration
                cItem.delegate            = self
                cItem.tag                 = i
                if i == currentPage {
                    cItem.didSelected()
                }else{
                    cItem.didNotSelected()
                }
                self.contentView.addSubview(cItem)
                cItem.snp.makeConstraints({ (maker) -> Void in
                    maker.left.equalTo(self.contentView).offset((self.radius * 2 + self.space) * CGFloat(i))
                    maker.centerY.equalTo(self.contentView)
                    maker.width.equalTo(self.radius * 2)
                    maker.height.equalTo(self.radius * 2)
                })
                contentArray.append(cItem)
            case .rectangle :
                let rItem                 = YRPageRectItem()
                rItem.didselectedColor    = currentPageIndicatorTintColor
                rItem.didNotSelectedColor = indicatorTintColor
                rItem.duration            = duration
                rItem.delegate            = self
                rItem.tag                 = i
                if i == currentPage {
                    rItem.didSelected()
                }else{
                    rItem.didNotSelected()
                }
                self.contentView.addSubview(rItem)
                rItem.snp.makeConstraints({ (maker) -> Void in
                    maker.left.equalTo(self.contentView).offset((self.sizeOfRectangle.width + self.space) * CGFloat(i))
                    maker.centerY.equalTo(self.contentView)
                    maker.width.equalTo(self.sizeOfRectangle.width)
                    maker.height.equalTo(self.sizeOfRectangle.height)
                })
                contentArray.append(rItem)
            case .doubleCircle :
                let dItem                 = YRPageDoubleCircleItem()
                dItem.didselectedColor    = currentPageIndicatorTintColor
                dItem.didNotSelectedColor = indicatorTintColor
                dItem.radius              = radius
                dItem.duration            = duration
                dItem.delegate            = self
                dItem.outsideColor        = outsideColor
                dItem.tag                 = i
                if i == currentPage {
                    dItem.didSelected()
                }else{
                    dItem.didNotSelected()
                }
                self.contentView.addSubview(dItem)
                dItem.snp.makeConstraints({ (maker) -> Void in
                    maker.left.equalTo(self.contentView).offset((self.radius * 2 + self.space) * CGFloat(i))
                    maker.centerY.equalTo(self.contentView)
                    maker.width.equalTo(self.radius * 2)
                    maker.height.equalTo(self.radius * 2)
                })
                contentArray.append(dItem)
            }
        }
        
    }
    
    private func selectedItem() {
        if currentPage == lastItem || currentPage >= contentArray.count {
            //print("错误位置")
            return
        }
        let item  = contentArray[currentPage]
        let oItem = contentArray[lastItem]
        item.didSelected()
        oItem.didNotSelected()
        lastItem  = currentPage
    }
    
    
    internal func pageItemClickWithTag(_ tag: Int) {
        if pageControlEnabled {
            delegate?.pageControl!(self, didSelectedPage: tag)
        }
    }
    
    fileprivate var contentView  : UIView!
    fileprivate var contentArray : Array<YRPageItem> = Array()
    fileprivate var lastItem     : Int               = 0
}
