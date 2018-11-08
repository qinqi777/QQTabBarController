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

因为需要继承，OC是不可以继承Swift的类的，所以OC中，我们创建一个工具类来专门处理它

TabbarTool.h
```Objective_C
#import <UIKit/UIKit.h>

@interface TabBarTool : NSObject

+ (UIViewController *)tabBarController;
    
@end
```

TabbarTool.m
```Objective_C
#import "TabBarTool.h"
#import "QQTabBarController-Swift.h"
#import "QQCorner.h"

@interface TabBarTool () <QQTabBarConfiguration>

@end

@implementation TabBarTool

static TabBarTool *tool;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [super allocWithZone:zone];
    });
    return tool;
}

+ (UIViewController *)tabBarController {
    //这里的tool是单例哦~一定要有值，否则被释放了协议中的方法就不会走了。
    TabBarTool *tool = [[TabBarTool alloc] init];
    QQTabBarController *tabBarVC = [[QQTabBarController alloc] init];
    tabBarVC.config = tool;
    tabBarVC.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbar_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    tabBarVC.tabBar.shadowImage = [[UIImage alloc] init];
    
    for (int i = 0; i < 4; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = [NSString stringWithFormat:@"跟控制器%d", i];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.title = [NSString stringWithFormat:@"导航%d", i];
        
        nav.tabBarItem.image = [UIImage imageWithQQCorner:^(QQCorner *corner) {
            corner.fillColor = [UIColor magentaColor];
            corner.radius = QQRadiusMakeSame(10);
        } size:CGSizeMake(20, 20)];
        nav.tabBarItem.selectedImage = [UIImage imageWithQQCorner:^(QQCorner *corner) {
            corner.fillColor = [UIColor greenColor];
            corner.radius = QQRadiusMakeSame(10);
        } size:CGSizeMake(20, 20)];
        
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
        
        [tabBarVC addChildViewController:nav];
    }
    
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //x值是无效的，这个按钮一定是居中的
    centerBtn.frame = CGRectMake(0, -8, 60, 60);
    [centerBtn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:centerBtn.bounds.size cornerRadius:QQRadiusMakeSame(30)] forState:UIControlStateNormal];
    [centerBtn addTarget:self action:@selector(centerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [tabBarVC addCenterBtn:centerBtn];

    return tabBarVC;
}

+ (void)centerBtnClicked:(UIButton *)btn {
    NSLog(@"centerBtnClicked");
}

#pragma mark - QQTabBarConfiguration
- (CGFloat)heightForTabBar {
    return 60;
}

- (CGFloat)extraTopMargin {
    return 15;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 5, contentRect.size.width, contentRect.size.height * 0.6);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = contentRect.size.height * 0.6;
    return CGRectMake(0, titleY, contentRect.size.width, contentRect.size.height - titleY - 10);
}

@end
```

AppDelegate 中，设置rootVC
```Objective_C
#import "TabBarTool.h"
self.window.rootViewController = [TabBarTool tabBarController];
```

## Author

qinqi777, qinqi376990311@163.com

## License

QQTabBarController is available under the MIT license. See the LICENSE file for more info.
