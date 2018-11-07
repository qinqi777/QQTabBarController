//
//  QQTabBar.swift
//  QQTabBarController_Example
//
//  Created by 秦琦 on 2018/11/7.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class QQTabBar: UITabBar {

    ///tabBar的配置
    weak var config: QQTabBarConfiguration?
    var didClickedItem: ((Int, Int) -> ())?
    private weak var bgImgView: UIImageView!
    private var tabBarBtns = [QQTabBarButton]()
    private weak var selectedBtn: QQTabBarButton?
    private weak var centerBtn: UIButton?
    private let bottomMargin: CGFloat = { () -> CGFloat in
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.keyWindow else {
                return 0.0
            }
            return window.safeAreaInsets.bottom
        }
        return 0.0
    }()
    
    override var backgroundImage: UIImage? {
        set {
            super.backgroundImage = UIImage()
            bgImgView.image = newValue
        }
        get {
            return super.backgroundImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imgView = UIImageView()
        addSubview(imgView)
        bgImgView = imgView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTabBar(item: UITabBarItem) {
        let btn = QQTabBarButton(config: config)
        addSubview(btn)
        tabBarBtns.append(btn)
        btn.item = item
        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchDown)
        if tabBarBtns.count == 1 {
            btnClicked(btn)
        }
    }
    
    func addCenterBtn(_ btn: UIButton) {
        addSubview(btn)
        centerBtn = btn
    }
    
    @objc func btnClicked(_ btn: QQTabBarButton) {
        selectedBtn?.isSelected = false
        btn.isSelected = true
        selectedBtn = btn
        guard let handler = didClickedItem else {
            return
        }
        let from = selectedBtn == nil ? 0 : selectedBtn!.tag
        handler(from, btn.tag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var imgY: CGFloat = 0
        if let y = config?.extraTopMargin?() {
            imgY = -y
        }
        bgImgView?.frame = CGRect(x: 0, y: imgY, width: frame.width, height: frame.height - imgY)
        var centerW: CGFloat = 0
        if let center = centerBtn {
            centerW = center.bounds.width < 1 ? 49 : center.bounds.width
            let centerH = center.bounds.height < 1 ? 49 : center.bounds.height
            let centerX = (bounds.width - centerW) * 0.5
            center.frame = CGRect(x: centerX, y: bounds.height - centerH, width: centerW, height: centerH)
        }
        let btnH = frame.height - bottomMargin
        let btnW = (frame.width - centerW) / CGFloat(tabBarBtns.count)
        for i in 0..<tabBarBtns.count {
            let btn = tabBarBtns[i]
            var btnX = CGFloat(i) * btnW
            if i > 1 {
                btnX += centerW
            }
            btn.frame = CGRect(x: btnX, y: 0, width: btnW, height: btnH)
            btn.tag = i
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let center = centerBtn {
            if center.point(inside: convert(point, to: center), with: event) {
                return center
            }
        }
        return super.hitTest(point, with: event)
    }

}
