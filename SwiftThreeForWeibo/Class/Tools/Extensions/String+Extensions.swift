//
//  String+Extensions.swift
//  SwiftThreeForWeibo
//
//  Created by CalvinCheung on 16/9/23.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import Foundation

extension String {
    
    // 从当前字符串中，提取链接和文本
    // Swift 提供了`元组`，同时返回多个值
    /// 如果是 OC，可以返回字典／自定义对象／指针的指针
    func cz_href() -> (link: String, text: String)? {
        
        /*/ 0. 匹配方案
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        
        // 1. 创建正则表达式，并且匹配第一项
        guard let regx = try? RegularExpression(pattern: pattern, options: []),
            let result = regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count))
            else {
                return nil
        }
        
        // 2. 获取结果
        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
 
        */
 
       // return (link, text)
        
        return ("123","245")
    }
}
