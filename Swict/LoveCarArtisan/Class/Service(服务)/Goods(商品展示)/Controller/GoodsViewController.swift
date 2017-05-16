//
//  GoodsViewController.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class GoodsViewController: RootViewController {

    // 懒加载商品数据TableView
    lazy var goodsTable: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 72
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 布局视图
        goodsLayoutView()
    }

    
    func goodsLayoutView() {
        // 商品数据TableView
        view.addSubview(goodsTable)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 商品数据TableView
        goodsTable.mas_makeConstraints { (make:MASConstraintMaker!) in
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


extension GoodsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "goodsCell"
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
        
        
        
        
        return cell
    }

}

