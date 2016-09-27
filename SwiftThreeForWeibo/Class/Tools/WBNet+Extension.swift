//
//  WBNet+Extension.swift
//  SwiftThreeForWeibo
//
//  Created by CalvinCheung on 16/9/27.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import Foundation

// MARK: - 封装新浪微博的网络请求方法
extension WBNetworkManager {
    
    /// 加载微博数据字典数组
    ///
    /// - parameter since_id:   返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    /// - parameter max_id:     返回ID小于或等于max_id的微博，默认为0
    /// - parameter completion: 完成回调[list: 微博字典数组/是否成功]
    func statusList(completion: (_ list: [[String: AnyObject]]?, _ isSuccess: Bool)->()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token":"2.00L89cXD0lrN5Kd96b929f630z_F2e"]
        
        
        request(url: urlString, params: params) { (json, isSuccess) in
            
            print("json\(json)")
            
//            let result = json["statuses"] as? [[String: AnyObject]]
        }
    }
}
