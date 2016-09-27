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
    
    
//    /// 专门负责拼接 token 的网络请求方法
//    ///
//    /// - parameter method:     GET / POST
//    /// - parameter URLString:  URLString
//    /// - parameter parameters: 参数字典
//    /// - parameter name:       上传文件使用的字段名，默认为 nil，不上传文件
//    /// - parameter data:       上传文件的二进制数据，默认为 nil，不上传文件
//    /// - parameter completion: 完成回调
//    func tokenRequest(method: WBHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, name: String? = nil, data: Data? = nil, completion: (_ json: AnyObject?, _ isSuccess: Bool)->()) {
//        
//        // 处理 token 字典
//        // 0> 判断 token 是否为 nil，为 nil 直接返回，程序执行过程中，一般 token 不会为 nil
//        guard let token = userAccount.access_token else {
//            
//            // 发送通知，提示用户登录
//            print("没有 token! 需要登录")
//            
//            NotificationCenter.default.post(
//                name: NSNotification.Name(rawValue: WBUserShouldLoginNotification),
//                object: nil)
//            
//            completion(json: nil, isSuccess: false)
//            
//            return
//        }
//        
//        // 1> 判断 参数字典是否存在，如果为 nil，应该新建一个字典
//        var parameters = parameters
//        if parameters == nil {
//            // 实例化字典
//            parameters = [String: AnyObject]()
//        }
//        
//        // 2> 设置参数字典，代码在此处字典一定有值
//        parameters!["access_token"] = token
//        
//        // 3> 判断 name 和 data
//        if let name = name, let data = data {
//            // 上传文件
//            upload(URLString: URLString, parameters: parameters, name: name, data: data, completion: completion)
//        } else {
//            
//            // 调用 request 发起真正的网络请求方法
//            // request(URLString: URLString, parameters: parameters, completion: completion)
//            request(method: method, URLString: URLString, parameters: parameters, completion: completion)
//        }
//    }

}
