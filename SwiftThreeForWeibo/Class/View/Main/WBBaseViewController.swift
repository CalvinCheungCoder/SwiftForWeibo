//
//  WBBaseViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址：https://github.com/CalvinCheungCoder/SwiftForWeibo
// QQ:984382258


import UIKit

class WBBaseViewController: UIViewController {
    
    // 访客视图信息字典
    var visitorInfoDictionary: [String: String]?
    // 表格
    var tableView: UITableView?
    // 刷新控件
    var refreshControl:UIRefreshControl?
    
    var isPullup = false
    
    var userLogin = true
    
    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    // 自定义导航条目
    lazy var navItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MakeUI()
        loadData()
    }
    
    // 重写title的setter
    override var title: String?{
        didSet {
            navItem.title = title
        }
    }
    
    // 子类实现具体方法
    func loadData() {
        
        refreshControl?.endRefreshing()
    }
}

// 设置访客监听方法
extension WBBaseViewController {
    
    @objc func login() {
        
        print("登录")
    }
    
    
    @objc func register() {
        
        print("注册")
    }
    
}

// MARK:--设置界面
extension WBBaseViewController {
    
    func MakeUI(){
        
        // 取消自动缩进，如果隐藏了导航栏会自动缩进20
        automaticallyAdjustsScrollViewInsets = false
        
        setUpNavigationBar()
        
        userLogin ? setUpTableView() : setupVisitorView()
    }
    
     // 设置表格
    func setUpTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        // 设置数据源和代理
        tableView?.delegate = self
        tableView?.dataSource = self
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.height ?? 49,
                                               right: 0)
        
        
        // 1.刷新控件
        refreshControl = UIRefreshControl()
        // 2.添加到表格视图
        tableView?.addSubview(refreshControl!)
        // 3.添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    // 设置访客视图
    private func setupVisitorView() {
        
        let visitorView = WBVisitorView(frame: view.bounds)
        
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
        // 1. 设置访客视图信息
        visitorView.visitorInfo = visitorInfoDictionary
        // 2.设置注册和登录监听
        visitorView.loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        // 3.设置导航条按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
        
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
        
        navigationBar.tintColor = UIColor.orange
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
    
    // 上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // row
        let row = indexPath.row
        
        let section = tableView.numberOfSections - 1
        
        print("section -- \(section)")
        
        if row < 0 || section < 0{
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && !isPullup {
            print("上拉刷新")
            
            isPullup = true
            loadData()
        }
        
    }
    
}



