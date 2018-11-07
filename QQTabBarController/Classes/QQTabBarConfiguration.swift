//
//  QQTabBarConfiguration.swift
//  QQTabBarController_Example
//
//  Created by 秦琦 on 2018/11/7.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

@objc public protocol QQTabBarConfiguration {
    ///tabBarButton中的文字的frame
    @objc optional func titleRect(forContentRect contentRect: CGRect) -> CGRect
    ///tabBarButton中的图片的frame
    @objc optional func imageRect(forContentRect contentRect: CGRect) -> CGRect
    ///tabBar的高度
    @objc optional func heightForTabBar() -> CGFloat
    ///超出tabBar的额外高度
    @objc optional func extraTopMargin() -> CGFloat
}

extension String {
    
    ///计算尺寸
    func qq_size(with font: UIFont, maxSize: CGSize) -> CGSize {
        let attr = [NSAttributedString.Key.font: font]
        return (self as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attr, context: nil).size
    }
    
}
