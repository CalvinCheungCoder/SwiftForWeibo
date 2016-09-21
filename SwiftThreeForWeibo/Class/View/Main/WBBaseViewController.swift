//
//  WBBaseViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    // 表格
    var tableView: UITableView?
    
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

// MARK:--设置界面
extension WBBaseViewController {
    
    func MakeUI(){
        
        view.backgroundColor = UIColor.cz_random()
        
        setUpNavigationBar()
        setUpTableView()
    }
    
    // 设置表格
    private func setUpTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        // 设置数据源和代理
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    // 设置 NavigationBar
    private func setUpNavigationBar(){
        
        // 添加导航条
        view.addSubview(navigationBar)
        // 将Item设置给Bar
        navigationBar.items = [navItem]
        // 设置NavBar渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        // 设置 Navtitle 字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
    }
}

// MARK:-- UITableViewDataSource,UITableViewDelegate
extension WBBaseViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只准备方法，子类负责具体实现
    // 子类数据源不需要Super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
}



