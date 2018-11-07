//
//  ExampleViewController.swift
//  QQTabBarController_Example
//
//  Created by 秦琦 on 2018/11/7.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import QQTabBarController
import QQCorner

class ExampleViewController: QQTabBarController {

    override func viewDidLoad() {
        
        //要在super之前给config赋值
        config = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabBar.backgroundImage = UIImage(named: "tabbar_bg")?.resizableImage(withCapInsets: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
        tabBar.shadowImage = UIImage()
        
        for i in 0..<4 {
            let vc = UIViewController()
            vc.title = "根控制器" + String(i)
            let nav = UINavigationController(rootViewController: vc)
            nav.title = "导航" + String(i)
            
            nav.tabBarItem.image = UIImage(qqCorner: { (corner) in
                corner?.fillColor = UIColor.magenta
                corner?.radius = QQRadiusMakeSame(10)
            }, size: CGSize(width: 20, height: 20))
            nav.tabBarItem.selectedImage = UIImage(qqCorner: { (corner) in
                corner?.fillColor = UIColor.green
                corner?.radius = QQRadiusMakeSame(10)
            }, size: CGSize(width: 20, height: 20))
            
            nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
            nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
            addChild(nav)
        }
        
        let centerBtn = UIButton(type: .custom)
        //x值是无效的，这个按钮一定是居中的
        centerBtn.frame = CGRect(x: 0, y: -8, width: 60, height: 60)
        centerBtn.setBackgroundImage(UIImage(color: UIColor.red, size: centerBtn.bounds.size, cornerRadius: QQRadiusMakeSame(30)), for: .normal)
        centerBtn.addTarget(self, action: #selector(centerBtnClicked(_:)), for: .touchUpInside)
        addCenterBtn(centerBtn)
    }
    
    @objc private func centerBtnClicked(_ btn: UIButton) {
        print("centerBtnClicked")
    }

}

extension ExampleViewController: QQTabBarConfiguration {
    
    func heightForTabBar() -> CGFloat {
        return 60
    }
    
    func extraTopMargin() -> CGFloat {
        return 15
    }
    
    func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 5, width: contentRect.width, height: contentRect.height * 0.6)
    }
    
    func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleY = contentRect.height * 0.6
        return CGRect(x: 0, y: titleY, width: contentRect.width, height: contentRect.height - titleY - 10)
    }
}
