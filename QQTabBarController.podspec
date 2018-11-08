#
# Be sure to run `pod lib lint QQTabBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QQTabBarController'
  s.version          = '0.1.2'
  s.summary          = 'A custom UITabBarController which can add a center button beyond the tabBar\'s bounds'
  s.swift_version    = '4.2.0'
  s.description      = 'A custom UITabBarController which can add a center button beyond the tabBar\'s bounds, also can set some properties of UITabBarItem such as background image, titleTextAttributes'

  s.homepage         = 'https://github.com/qinqi777/QQTabBarController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'qinqi777' => 'qinqi376990311@163.com' }
  s.source           = { :git => 'https://github.com/qinqi777/QQTabBarController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://blog.csdn.net/qinqi376990311'
  s.ios.deployment_target = '8.0'
  s.source_files = 'QQTabBarController/Classes/**/*'
  s.requires_arc = true
  s.frameworks = 'UIKit'
  
end
