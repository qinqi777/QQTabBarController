# QQTabBarController

[![CI Status](https://img.shields.io/travis/qinqi777/QQTabBarController.svg?style=flat)](https://travis-ci.org/qinqi777/QQTabBarController)
[![Version](https://img.shields.io/cocoapods/v/QQTabBarController.svg?style=flat)](https://cocoapods.org/pods/QQTabBarController)
[![License](https://img.shields.io/cocoapods/l/QQTabBarController.svg?style=flat)](https://cocoapods.org/pods/QQTabBarController)
[![Platform](https://img.shields.io/cocoapods/p/QQTabBarController.svg?style=flat)](https://cocoapods.org/pods/QQTabBarController)

一个自定义```UITabBarController```可以自定义```tabBar```的高度，添加中间的按钮，超出```tabBar```的```bounds```的按钮，超出范围也能响应点击。并且可以适配原生的```UITabBarItem```模型

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
将整个仓库clone下来，在 Example 文件夹的目录下执行 `pod install` ，然后运行Example

## Installation

QQTabBarController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

QQCorner 支持通过 CocoaPods 安装，简单地添加下面这一行到你的 Podfile 中

```ruby
pod 'QQTabBarController'
```

## Useage

创建一个控制器，继承于```QQTabBarController```，如需更多自定义设置，可实现协议```QQTabBarConfiguration```，可以设置```tabBarButton```中的文字frame和图片frame，设置```tabBar```的高度，以及额外高度。

#### Swift Version

```Swift
import QQTabBarController

class ExampleViewController: QQTabBarController {

    override func viewDidLoad() {
        
        //要在super之前给config赋值
        config = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabBar.backgroundImage = UIImage.qq_withColor(UIColor.cyan)
        tabBar.shadowImage = UIImage()
        
        for i in 0..<4 {
            let vc = UIViewController()
            vc.title = "根控制器" + String(i)
            let nav = UINavigationController(rootViewController: vc)
            nav.title = "导航" + String(i)
            nav.tabBarItem.image = UIImage.qq_withColor(UIColor.blue)
            nav.tabBarItem.selectedImage = UIImage.qq_withColor(UIColor.magenta)
            nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
            nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
            addChild(nav)
        }
        
        let centerBtn = UIButton(type: .custom)
        centerBtn.frame = CGRect(x: 0, y: 0, width: 77, height: 77)
        centerBtn.setBackgroundImage(UIImage.qq_withColor(UIColor.red), for: .normal)
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

```

## Author

qinqi777, qinqi376990311@163.com

## License

QQTabBarController is available under the MIT license. See the LICENSE file for more info.
