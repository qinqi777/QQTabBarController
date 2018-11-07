//
//  QQTabBarController.swift
//  QQTabBarController_Example
//
//  Created by 秦琦 on 2018/11/7.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

open class QQTabBarController: UITabBarController {

    ///tabBar的配置
    open weak var config: QQTabBarConfiguration?
    
    private weak var qq_tabBar: QQTabBar!
    
    private let bottomMargin: CGFloat = { () -> CGFloat in
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.keyWindow else {
                return 0.0
            }
            return window.safeAreaInsets.bottom
        }
        return 0.0
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTabBar()
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var tabH = 49 + bottomMargin
        if let height = config?.heightForTabBar?() {
            tabH = height
        }
        let tabY = UIScreen.main.bounds.height - tabH
        qq_tabBar.frame = CGRect(x: 0, y: tabY, width: UIScreen.main.bounds.width, height: tabH)
        guard let cls = NSClassFromString("UITabBarButton") else {
            return
        }
        for child in tabBar.subviews {
            if child.isKind(of: cls) {
                child.removeFromSuperview()
            }
        }
    }
    
    private func setupTabBar() {
        let qqTabBar = QQTabBar()
        qqTabBar.config = config     
        qqTabBar.isTranslucent = false
        qqTabBar.didClickedItem = { [weak self] (from, to) in
            self?.selectedIndex = to
        }
        setValue(qqTabBar, forKey: "tabBar")
        qq_tabBar = qqTabBar
    }
    
    override open func addChild(_ childController: UIViewController) {
        qq_tabBar.addTabBar(item: childController.tabBarItem)
        super.addChild(childController)
    }
    
    open func addCenterBtn(_ btn: UIButton) {
        qq_tabBar.addCenterBtn(btn)
    }

}
