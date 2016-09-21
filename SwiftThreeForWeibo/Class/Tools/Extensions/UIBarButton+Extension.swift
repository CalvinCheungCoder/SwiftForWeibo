//
//  UIBarButton+Extension.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /*
     
     
     
     */
    convenience init(title:String,fontSize:CGFloat = 16 ,target:AnyObject? ,action:Selector) {
        
        let button:UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        button.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView:button)
    }
}

