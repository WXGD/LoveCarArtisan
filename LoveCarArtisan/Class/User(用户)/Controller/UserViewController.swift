//
//  UserViewController.swift
//  Text
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class UserViewController: RootViewController {

    var userArray:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "userList", ofType: "json")
        let data = NSData.init(contentsOfFile: path!)
        let json:NSDictionary = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        userArray = UserModel.mj_objectArray(withKeyValuesArray: json["data"])

        
        // 布局视图
        userLayoutView()

        
        
        
    }
    
    // 懒加载实时数据View
    lazy var userTable: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 72
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        return tableView
    }()

    private func userLayoutView() {
        view.addSubview(userTable)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userTable.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(self.view.mas_top)
            make.left.mas_equalTo()(self.view.mas_left)
            make.right.mas_equalTo()(self.view.mas_right)
            make.bottom.mas_equalTo()(self.view.mas_bottom)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension UserViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "userCell"
        let cell = UserTableCell(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
        
        let userModel : UserModel = userArray![indexPath.row] as! UserModel
        
        cell.userModel = userModel
        
        
        return cell
    }
}

