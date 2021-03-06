//
//  WBDemoViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址：https://github.com/CalvinCheungCoder/SwiftForWeibo
// QQ:984382258



import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置标题
        title = "第 \(navigationController?.childViewControllers.count ?? 0) 个"
    }

    
    @objc func showNext() {
        
        let vc = WBDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension WBDemoViewController {
    
    override func setUpTableView() {
        
        super.setUpTableView()
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
    }
    
}
