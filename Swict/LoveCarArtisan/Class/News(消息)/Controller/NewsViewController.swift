//
//  NewsViewController.swift
//  Text
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class NewsViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 布局NAV
        newsLayoutNAV()
        // 添加视图
        addNewsLayoutView()
    }
    // MARK: 网络请求
    
    // MARK: 按钮点击方法
    func newsButtonAction(button: UIButton) {
        
    }
    // MARK: 布局NAV
    private func newsLayoutNAV() {
        
    }
    // MARK: 创建控件
    /** 消息table */
    lazy var newsTable: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    // MARK: 添加视图
    private func addNewsLayoutView() {
        /** 消息table */
        view.addSubview(newsTable)
    }
    // MARK: 布局视图
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /** 消息table */
        newsTable.mas_makeConstraints { (make:MASConstraintMaker!) in
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


extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "newsCell"
        let cell: NewsCell = NewsCell(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
        return cell
    }
}






