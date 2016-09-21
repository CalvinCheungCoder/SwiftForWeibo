//
//  HomeViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

class HomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func showFridens() {
        
        print(#function)
        
        let vc = WBDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

extension HomeViewController {
    
    override func MakeUI() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFridens))
    }
}
