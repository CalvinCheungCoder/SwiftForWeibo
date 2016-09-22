//
//  UIBarButton+Extension.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址：https://github.com/CalvinCheungCoder/SwiftForWeibo
// QQ:984382258


import UIKit

extension UIBarButtonItem{
    
    /*
     
     
     
     */
    convenience init(title:String,fontSize:CGFloat = 16 ,target:AnyObject? ,action:Selector, isBack:Bool = false) {
        
        let button:UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            button.setImage(UIImage(named:imageName), for: UIControlState(rawValue: 0))
            button.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
            
            button.sizeToFit()
        }
        
        
        button.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView:button)
    }
}

