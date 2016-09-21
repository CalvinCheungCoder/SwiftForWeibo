//
//  WBTabBar.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

// 使用代理实现点击按钮
protocol WBTabBarDelegate: NSObjectProtocol {
    
    func didSelectedComposeButton()
}


class WBTabBar: UITabBar {

    var composeButtonCloser: (() -> ())?
    
    // 添加代理属性
    weak var WBDelegate: WBTabBarDelegate?
    
    // 创建加号按钮
    private lazy var composeButton: UIButton = {
        let button = UIButton()
        // button 添加点击事件
        button.addTarget(self, action: #selector(composeButtonClick), for: .touchUpInside)
        
        // 设置图片
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), for: UIControlState.normal)
        button.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), for: UIControlState.highlighted)
        
        // 设置背景图片
        button.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: UIControlState.normal)
        
        button.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        // 设置大小
        button.sizeToFit()
        return button
    }()
    
    
    // MARK: 方法＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
    
    // 表示使用手写代码去创建对象
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    // 使用xib或者storyboard创建对象的时候会调用该方法, 提示为不支持xib创建
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    private func setupUI() {
        // 设置背景图片,防止push的右边出现黑色效果
        backgroundImage = UIImage(named: "tabbar_background")
        
        //添加子视图控件
        addSubview(composeButton)
        
    }
    
    // MARK: 加号按钮的点击事件
    // private 修饰的这个事件函数,在swift运行循环里面是找不到
    // oc基于运行时使用kvc动态派发调用该方法, @objc 告诉编译器我们使用oc机制去调用这个方法
    @objc private func composeButtonClick() {
        print("点到我了")
        composeButtonCloser?()
        
        WBDelegate?.didSelectedComposeButton()
    }
    
    // 重写布局子控件的方法
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置composeButton的中心
        composeButton.centerX = width / 2
        composeButton.centerY = height / 2
        
        // 重新计算barbuttonitem的宽度
        let itemWith = width / 5
        // 纪录是第几个tabBarItem
        var index = 0
        for value in subviews {
            
            if value.isKind(of: NSClassFromString("UITabBarButton")!) {
                
                value.width = itemWith
                // 系统按钮的x坐标
                value.x = CGFloat(index) * itemWith
                
                index += 1
                // 当前将要显示第三个系统按钮的时候让其多加上一个加号按钮的宽度
                if index == 2 {
                    index += 1
                }
            }
        }
    }
}
