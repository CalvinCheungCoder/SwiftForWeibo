//
//  WBNetworkManager.swift
//  SwiftThreeForWeibo
//
//  Created by CalvinCheung on 16/9/23.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import UIKit
import AFNetworking

// Swift 的枚举支持任意数据类型
// switch / enum 在 OC 中都只是支持整数
enum WBHTTPMethod {
    case GET
    case POST
}

// 网络管理工具
class WBNetworkManager: AFHTTPSessionManager {
    
    
    
    // 静态区／常量／闭包
    // 在第一次访问时，执行闭包，并且将结果保存在 shared 常量中
    static let shared: WBNetworkManager = {
        
        // 实例化对象
        let instance = WBNetworkManager()
        
        // 设置响应反序列化支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        // 返回对象
        return instance
    }()
    
    
    // 封装 AFN 的 GET / POST 请求
    func request(type: WBHTTPMethod = .GET, url: String, params: Any?, callBack: @escaping (Any?, Error?) -> ()) {
        
        if type == .GET {
            
            get(url, parameters: params, progress: nil, success: { (_, response) in
                callBack(response, nil)
                
                }, failure: { (_, error) in
                    callBack(nil, error)
            })
            
        } else {
            
            post(url, parameters: params, progress: nil, success: { (_, response) in
                callBack(response, nil)
                }, failure: { (_, error) in
                    callBack(nil, error)
            })
            
        }
        
    }

}
