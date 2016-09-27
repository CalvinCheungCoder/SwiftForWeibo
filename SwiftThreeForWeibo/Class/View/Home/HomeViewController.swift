//
//  HomeViewController.swift
//  SwiftThreeForWeibo
//
//  Created by 张丁豪 on 16/9/21.
//  Copyright © 2016年 张丁豪. All rights reserved.
//
// GitHub地址：https://github.com/CalvinCheungCoder/SwiftForWeibo
// QQ:984382258



import UIKit

// 定义全局常亮，尽量使用 private 修饰
private let cellId = "cellId"


class HomeViewController: WBBaseViewController {
    
    // 微博数据数组
    lazy var statusList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func showFridens() {
        
        print(#function)
        
        let vc = WBDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // 加载数据
    override func loadData() {
        
        // 加载微博数据
        let urlStr = "https://api.weibo.com/2/statuses/public_timeline.json"
        let params = ["access_token":"2.00L89cXD0lrN5Kd96b929f630z_F2e"]
        

        WBNetworkManager.shared.request(type: .GET, url: urlStr, params: params) { (res, Error) in
            print("res\(res)")
            print("error\(Error)")
        }
        
        
        for i in 0..<20 {
            
            if self.isPullup {
                
                self.statusList.append("上拉\(i)")
            }
            
            self.statusList.insert(i.description, at: 0)
        }
        
        self.refreshControl?.endRefreshing()
        
        self.isPullup = false
        
        self.tableView?.reloadData()
    }

}

// MARK:--表格数据源方法
extension HomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statusList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = statusList[indexPath.row]
        
        return cell
        
    }
}


extension HomeViewController {
    
    override func setUpTableView() {
        
        super.setUpTableView()
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFridens))
        
        // 注册原型
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
