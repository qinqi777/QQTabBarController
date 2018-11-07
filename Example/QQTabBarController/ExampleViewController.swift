//
//  ExampleViewController.swift
//  QQTabBarController_Example
//
//  Created by 秦琦 on 2018/11/7.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import QQTabBarController

class ExampleViewController: QQTabBarController {

    override func viewDidLoad() {
        
        //要在super之前给config赋值
        config = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        tabBar.backgroundImage = UIImage.qq_withColor(UIColor.cyan)
        tabBar.shadowImage = UIImage()
        
        for i in 0..<4 {
            let vc = UIViewController()
            vc.title = "根控制器" + String(i)
            let nav = UINavigationController(rootViewController: vc)
            nav.title = "导航" + String(i)
//            nav.tabBarItem.image = UIImage.qq_withColor(UIColor.blue)
//            nav.tabBarItem.selectedImage = UIImage.qq_withColor(UIColor.magenta)
            nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
            nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
            addChild(nav)
        }
        
        let centerBtn = UIButton(type: .custom)
        centerBtn.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
//        centerBtn.setBackgroundImage(UIImage.qq_withColor(UIColor.red), for: .normal)
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
    
}
