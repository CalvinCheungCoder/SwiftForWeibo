//
//  UIView+Extension.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit

// 对UIView的扩展
extension UIView {
    
    // 扩展计算属性
    // x坐标
    var x: CGFloat {
        get {
            return frame.origin.x
        } set {
            frame.origin.x = newValue
        }
    }
    
    // y坐标
    var y: CGFloat {
        get {
            return frame.origin.y
        } set {
            frame.origin.y = newValue
        }
    }
    
    // 宽度
    var width: CGFloat {
        
        get {
            return frame.size.width
        } set {
            frame.size.width = newValue
        }
        
        
    }
    // 高度
    var height: CGFloat {
        
        get {
            return frame.size.height
        } set {
            frame.size.height = newValue
        }
        
        
    }
    
    // 中心x
    var centerX: CGFloat {
        get {
            return center.x
        } set {
            center.x = newValue
        }
    }
    
    // 中心y
    var centerY: CGFloat {
        get {
            return center.y
        } set {
            center.y = newValue
        }
    }
    
    // 获取或者设置size大小
    var size: CGSize {
        get {
            return frame.size
        } set {
            frame.size = newValue
        }
    }
 
}
