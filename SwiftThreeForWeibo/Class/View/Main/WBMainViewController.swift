//
//  WBMainViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 添加自定义tabBar，利用kvc给只读属性赋值
        let ZDHTabBar = WBTabBar()
        // 设置代理
        ZDHTabBar.WBDelegate = self
        // 定义自定义tabBar的闭包
        // 在此使用self会产生循环引用, 解决办法使用[weak self]
        ZDHTabBar.composeButtonCloser = { [weak self] in
            print("我是闭包调用过来的")
        }
        setValue(ZDHTabBar, forKey: "tabBar")
        
        // 添加子控制器
        addChildViewController(childController: HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(childController: MessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(childController: DiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(childController: ProfileViewController(), title: "我", imageName: "tabbar_profile")
    }
    
    /**
     portrait    : 竖屏，肖像
     landscape   : 横屏，风景画
     
     - 使用代码控制设备的方向，好处，可以在在需要横屏的时候，单独处理！
     - 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向！
     - 如果播放视频，通常是通过 modal 展现的！
     */
    
    // Method 'supportedInterfaceOrientations()' with Objective-C selector 'supportedInterfaceOrientations' conflicts with getter for 'supportedInterfaceOrientations' from superclass 'UIViewController' with the same Objective-C selector
//    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask{
//        return .portrait
//    }

    func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        // 设置tabBar的图片和文字
        childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: "\(imageName)_highlighted")?.withRenderingMode(.alwaysOriginal)
        // 设置文字选中的颜色
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: UIControlState.selected)
        // 设置文字大小，
        childController.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState.normal)
        // 设置文字内容
        childController.title = title
        // 创建导航控制器
        let navigationController = WBNavViewController(rootViewController: childController)
        addChildViewController(navigationController)
        }
    }


// 用延展实现代理方法
extension WBMainViewController:WBTabBarDelegate {
    
    func didSelectedComposeButton() {
        
        let vc = UIViewController()
        
        present(vc, animated: true, completion: nil)
    }

}

