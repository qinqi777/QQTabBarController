//
//  QQTabBarButton.swift
//  QQTabBarController_Example
//
//  Created by 秦琦 on 2018/11/7.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class QQTabBarButton: UIButton {
    
    ///tabBar的配置
    weak var config: QQTabBarConfiguration?
    private lazy var badgeBtn: QQTabBarBadgeButton = {
        let badgeBtn = QQTabBarBadgeButton()
        badgeBtn.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
        addSubview(badgeBtn)
        return badgeBtn
    }()
    var item: UITabBarItem? {
        didSet {
            item?.addObserver(self, forKeyPath: "badgeValue", options: .new, context: nil)
            item?.addObserver(self, forKeyPath: "title", options: .new, context: nil)
            item?.addObserver(self, forKeyPath: "image", options: .new, context: nil)
            item?.addObserver(self, forKeyPath: "selectedImage", options: .new, context: nil)
            observeValue(forKeyPath: nil, of: nil, change: nil, context: nil)
        }
    }
    
    override var isHighlighted: Bool {
        get { return false }
        set {}
    }
    
    deinit {
        item?.removeObserver(self, forKeyPath: "badgeValue")
        item?.removeObserver(self, forKeyPath: "title")
        item?.removeObserver(self, forKeyPath: "image")
        item?.removeObserver(self, forKeyPath: "selectedImage")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        setTitle(item?.title, for: .normal)
        setImage(item?.image, for: .normal)
        setImage(item?.selectedImage, for: .selected)
        let norAttrs = item?.titleTextAttributes(for: .normal)
        let selAttes = item?.titleTextAttributes(for: .selected)
        if let color = norAttrs?[NSAttributedString.Key.foregroundColor] {
            setTitleColor(color as? UIColor, for: .normal)
        }
        if let color = selAttes?[NSAttributedString.Key.foregroundColor] {
            setTitleColor(color as? UIColor, for: .selected)
        }
        if let font = norAttrs?[NSAttributedString.Key.font] {
            titleLabel?.font = font as? UIFont
        }
        badgeBtn.badgeValue = item?.badgeValue
        badgeBtn.frame.origin.x = frame.width - badgeBtn.frame.width - 10
        badgeBtn.frame.origin.y = 5
    }
    
    init(config: QQTabBarConfiguration?) {
        super.init(frame: CGRect.zero)
        self.config = config
        imageView?.contentMode = .center
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if let rect = config?.imageRect?(forContentRect: contentRect) {
            return rect
        }
        return CGRect(x: 0, y: 5, width: contentRect.width, height: contentRect.height * 0.6)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if let rect = config?.titleRect?(forContentRect: contentRect) {
            return rect
        }
        return CGRect(x: 0, y: contentRect.height * 0.6, width: contentRect.width, height: contentRect.height * 0.4)
    }

}

class QQTabBarBadgeButton: UIButton {
    
    ///角标值，为0时隐藏
    var badgeValue: String? {
        didSet {
            guard let badgeValue = badgeValue, Int(badgeValue) != 0  else {
                isHidden = true
                return
            }
            isHidden = false
            setTitle(badgeValue, for: .normal)
            let badgeH = currentBackgroundImage!.size.height
            layer.cornerRadius = badgeH * 0.5
            var badgeW = currentBackgroundImage!.size.width
            if badgeValue.count > 1 {
                badgeW = badgeValue.qq_size(with: titleLabel!.font, maxSize: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)).width + 10
            }
            frame.size.width = badgeW
            frame.size.height = badgeH
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        isUserInteractionEnabled = false
        backgroundColor = UIColor.red
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
