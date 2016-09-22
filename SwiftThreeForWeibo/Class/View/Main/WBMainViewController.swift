//
//  WBMainViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址：https://github.com/CalvinCheungCoder/SwiftForWeibo
// QQ:984382258


import UIKit

class WBMainViewController: UITabBarController {
    
    // MARK: - 私有控件
    // 撰写按钮
    lazy var composeButton: UIButton = UIButton.cz_imageButton(
        "tabbar_compose_icon_add",
        backgroundImageName: "tabbar_compose_button")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupChildControllers()
        setupComposeButton()
    }
}

// MARK: - UITabBarControllerDelegate
extension WBMainViewController: UITabBarControllerDelegate {
    
    // 将要选择 TabBarItem
    // - parameter tabBarController: tabBarController
    // - parameter viewController:   目标控制器
    // - returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // 1.获取控制器在数组中的索引
        let idx = (childViewControllers as NSArray).index(of: viewController)
        
        // 2.判断当前索引是首页，同时 idx 也是首页，重复点击首页的按钮
        if selectedIndex == 0 && idx == selectedIndex {
            
            print("点击首页")
            // 3.让表格滚动到顶部
            // a) 获取到控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! HomeViewController
            
            // b) 滚动到顶部
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            
            // 4.刷新数据 － 增加延迟，是保证表格先滚动到顶部再刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                
                vc.loadData()
            })
            
            
            // 5.清除 tabItem 的 badgeNumber
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        // 判断目标控制器是否是 UIViewController
        return !viewController.isMember(of: UIViewController.self)
    }
}


// extension 类似于 OC 中的 分类，在 Swift 中还可以用来切分代码块
// 可以把相近功能的函数，放在一个 extension 中
// 便于代码维护
// 注意：和 OC 的分类一样，extension 中不能定义属性
// MARK: - 设置界面
extension WBMainViewController {
    
    // 设置撰写按钮
    func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        // 计算按钮的宽度
        let count = CGFloat(childViewControllers.count)
        // 将向内缩进的宽度
        let w = tabBar.bounds.width / count
        
        // CGRectInset 正数向内缩进，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        print("撰写按钮宽度 \(composeButton.bounds.width)")
        
        // 按钮监听方法
//        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    // 设置所有子控制器
    func setupChildControllers() {
        
        // 0. 获取沙盒 json 路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        // 加载 data
        var data = NSData(contentsOfFile: jsonPath)
        
        // 判断 data 是否有内容，如果没有，说明本地沙盒没有文件
        if data == nil {
            // 从 Bundle 加载 data
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
        }
        
        // data 一定会有一个内容，反序列化
        // 反序列化转换成数组
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: AnyObject]]
            else {
                return
        }
        
        // 遍历数组，循环创建控制器数组
        var arrayM = [UIViewController]()
        for dict in array! {
            
            arrayM.append(controller(dict: dict))
        }
        
        // 设置 tabBar 的子控制器
        viewControllers = arrayM
    }
    
    // 使用字典创建一个子控制器
    // - parameter dict: 信息字典[clsName, title, imageName, visitorInfo]
    // - returns: 子控制器
    private func controller(dict: [String: AnyObject]) -> UIViewController {
        
        print("bundle \(Bundle.main.namespace)")
        let str:String = "SwiftThreeForWeibo"
        
        // 1. 取得字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(str + "." + clsName) as? WBBaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String: String]
            
            else {
                
                return UIViewController()
        }
        
        // 2. 创建视图控制器
        let vc = cls.init()
        
        vc.title = title
        
        // 设置控制器的访客信息字典
        vc.visitorInfoDictionary = visitorDict
        
        // 3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_highlighted")?.withRenderingMode(.alwaysOriginal)
        
        // 4. 设置 tabbar 的标题字体（大小）
        vc.tabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.orange],
            for: .highlighted)
        // 系统默认是 12 号字，修改字体大小，要设置 Normal 的字体大小
        vc.tabBarItem.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
            for: UIControlState(rawValue: 0))
        
        // 实例化导航控制器的时候，会调用 push 方法将 rootVC 压栈
        let nav = WBNavViewController(rootViewController: vc)
        
        return nav
    }
}


