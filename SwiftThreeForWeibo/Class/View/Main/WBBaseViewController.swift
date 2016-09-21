//
//  WBBaseViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    // 自定义导航条目
    lazy var navItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MakeUI()
    }
    
    // 重写title的setter
    override var title: String?{
        didSet {
            navItem.title = title
        }
    }
}

extension WBBaseViewController {
    
    func MakeUI(){
        
        view.backgroundColor = UIColor.cz_random()
        
        // 添加导航条
        view.addSubview(navigationBar)
        // 将Item设置给Bar
        navigationBar.items = [navItem]
        // 设置NavBar渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
    }
}
