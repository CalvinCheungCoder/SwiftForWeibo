//
//  WBBaseViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        MakeUI()
    }
}

extension WBBaseViewController {
    
    func MakeUI(){
        
        view.backgroundColor = UIColor.cz_random()
    }
}
