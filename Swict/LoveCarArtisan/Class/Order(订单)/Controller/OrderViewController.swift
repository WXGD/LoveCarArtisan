//
//  OrderViewController.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/7/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class OrderViewController: RootViewController {

    // MARK: 创建控件
    /** 订单table */
    lazy var orderTable: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = 150
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 布局NAV
        orderLayoutNAV()
        // 添加视图
        addOrderLayoutView()
    }
    // MARK: 布局NAV
    private func orderLayoutNAV() {
        
    }
    // MARK: 添加视图
    private func addOrderLayoutView() {
        /** 订单table */
        view.addSubview(orderTable)
    }
    // MARK: 布局视图
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /** 订单table */
        orderTable.mas_makeConstraints { (make:MASConstraintMaker!) in
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

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "orderCell"
        let cell: OrderCell = OrderCell(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
        return cell
    }
}

