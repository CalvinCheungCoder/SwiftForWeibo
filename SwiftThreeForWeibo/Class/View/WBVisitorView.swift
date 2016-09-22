//
//  WBVisitorView.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 2016/9/22.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址：https://github.com/CalvinCheungCoder/SwiftForWeibo
// QQ:984382258



import UIKit

class WBVisitorView: UIView {
    
    // 访客视图的信息字典 [imageName / message]
    // 如果是首页 imageName == ""
    var visitorInfo: [String: String]? {
        didSet {
            // 1.取字典信息
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                    
                    return
            }
            
            // 2.设置消息
            tipLabel.text = message
            
            // 3.设置图像，首页不需要设置
            if imageName == "" {
                
                startAnimation()
                return
            }
            
            iconView.image = UIImage(named: imageName)
            
            // 其他控制器的访客视图不需要显示小房子/遮罩视图
            houseIconView.isHidden = true
            MaskIconView.isHidden = true
        }
    }
    
    // 视图旋转动画
    private func startAnimation() {
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        
        // 动画完成不删除
        anim.isRemovedOnCompletion = false
        
        iconView.layer.add(anim, forKey: nil)
        
    }

    override init(frame:CGRect){
        
        super.init(frame: frame)
        
        setUpUI()
    }
    
    
    required init(coder aDecder:NSCoder){
        
        fatalError("init(coder:)has not been implemented")
    }
    
    
    func setupInfo(dict:[String:String]){
        
        
    }
    
    // MARK:--私有控件
    
    // 图像
    lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // 遮罩
    lazy var MaskIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    // 小房子
    lazy var houseIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // 提示标签
    lazy var tipLabel:UILabel = UILabel.cz_label(withText: "关注一些人，回这里看看有什么惊喜，关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGray)
    // 注册按钮
    lazy var registerButton:UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.darkGray, backgroundImageName: "common_button_white_disable")
    // 登录按钮
    lazy var loginBtn:UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
}

// 设置界面
extension WBVisitorView {
    
    func setUpUI(){
        
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        // 添加控件
        addSubview(iconView)
        addSubview(MaskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginBtn)
        
        // 文本居中
        tipLabel.textAlignment = .center
        
        // 取消 autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 自动布局
        let margin: CGFloat = 20.0
        
        // 图像视图
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
        // 小房子
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        
        // 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        
        // 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 40))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
        // 登录按钮
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 40))
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: registerButton,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 0))
        // 遮罩图像
        // views: 定义 VFL 中的控件名称和实际名称映射关系
        // metrics: 定义 VFL 中 () 指定的常数影射关系
        let viewDict = ["maskIconView": MaskIconView,
                        "registerButton": registerButton] as [String : Any]
        let metrics = ["spacing": 20]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskIconView]-0-|",
            options: [],
            metrics: nil,
            views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerButton]",
            options: [],
            metrics: metrics,
            views: viewDict))
    }
}

