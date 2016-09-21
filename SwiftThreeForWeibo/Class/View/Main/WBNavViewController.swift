//
//  WBNavViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

//enum TabbarHideStyle {
//    //    有动画
//    case tabbarHideWithAnimation
//    //    无动画
//    case tabbarHideWithNoAnimation
//}

class WBNavViewController: UINavigationController {
    
//    var tabbarHideStyle = TabbarHideStyle.tabbarHideWithNoAnimation
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 隐藏Nav
        navigationBar.isHidden = true
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            // 判断控制器类型
            if let vc = viewController as? WBBaseViewController{
                
                var title = "返回"
                // 判断控制器级数
                if childViewControllers.count == 1 {
                    // title显示首页标题
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                // 取出自定义的 NavItem
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(popToParent),isBack:true)
            }
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    // pop 返回到上一级
    @objc private func popToParent() {
        popViewController(animated: true)
    }

//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    override init(rootViewController: UIViewController) {
//        super.init(rootViewController: rootViewController)
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        if self.viewControllers.count > 0 {
//            let rootVC = self.viewControllers[0]
//            // 是否添加动画
//            if tabbarHideStyle == TabbarHideStyle.tabbarHideWithAnimation {
//                UIView.animate(withDuration: 0.35, animations: {
//                    rootVC.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 64)
//                })
//            }else{
//                viewController.hidesBottomBarWhenPushed = true
//            }
//        }
//        super.pushViewController(viewController, animated: true)
//    }

}
