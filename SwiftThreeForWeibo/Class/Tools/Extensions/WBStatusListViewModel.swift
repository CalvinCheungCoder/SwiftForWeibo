//
//  WBStatusListViewModel.swift
//  SwiftThreeForWeibo
//
//  Created by CalvinCheung on 16/9/23.
//  Copyright © 2016年 张丁豪. All rights reserved.
//

import Foundation


// 微博数据列表视图模型
/*
 父类的选择
 
 - 如果类需要使用 `KVC` 或者字典转模型框架设置对象值，类就需要继承自 NSObject
 - 如果类只是包装一些代码逻辑(写了一些函数)，可以不用任何父类，好处：更加轻量级
 - 提示：如果用 OC 写，一律都继承自 NSObject 即可
 
 使命：负责微博的数据处理
 1. 字典转模型
 2. 下拉／上拉刷新数据处理
 */

// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 3

class WBStatusListViewModel {
    
    // 微博视图模型数组懒加载
    lazy var statusList = [WBStatus]()
    // 上拉刷新错误次数
    private var pullupErrorTimes = 0
    
    // 加载微博列表
    func loadStatus(pullup: Bool, completion: (_ isSuccess: Bool, _ shouldRefresh: Bool)->()) {
        
        // 判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes {
            
            completion(true, false)
            
            return
        }
        
        // since_id 取出数组中第一条微博的 id
        let since_id = pullup ? 0 : (statusList.first?.status.id ?? 0)
        // 上拉刷新，取出数组的最后一条微博的 id
        let max_id = !pullup ? 0 : (statusList.last?.status.id ?? 0)
        
        // 让数据访问层加载数据
        WBStatusListDAL.loadStatus(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            //        }
            //
            //        // 发起网络请求，加载微博数据[字典的数组]
            //        WBNetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            // 0. 如果网络请求失败，直接执行完成回调
            if !isSuccess {
                completion(isSuccess: false, shouldRefresh: false)
                
                return
            }
            
            // 1. 遍历字典数组，字典转 模型 => 视图模型，将视图模型添加到数组
            var array = [WBStatusViewModel]()
            
            for dict in list ?? [] {
                
                // print(dict["pic_urls"])
                
                // 1> 创建微博模型
                let status = WBStatus()
                
                // 2> 使用字典设置模型数值
                status.yy_modelSet(with: dict)
                
                // 3> 使用 `微博` 模型创建 `微博视图` 模型
                let viewModel = WBStatusViewModel(model: status)
                
                // 4> 添加到数组
                array.append(viewModel)
            }
            
            // 视图模型创建完成
            print("刷新到 \(array.count) 条数据 \(array)")
            
            // 2. 拼接数据
            if pullup {
                // 上拉刷新结束后，将结果拼接在数组的末尾
                self.statusList += array
            } else {
                // 下拉刷新，应该将结果数组拼接在数组前面
                self.statusList = array + self.statusList
            }
            
            // 3. 判断上拉刷新的数据量
            if pullup && array.count == 0 {
                
                self.pullupErrorTimes += 1
                
                completion(isSuccess: isSuccess, shouldRefresh: false)
            } else {
                
                self.cacheSingleImage(list: array, finished: completion)
                
                // 4. 真正有数据的回调！
                // completion(isSuccess: isSuccess, shouldRefresh: true)
            }
        }
}
