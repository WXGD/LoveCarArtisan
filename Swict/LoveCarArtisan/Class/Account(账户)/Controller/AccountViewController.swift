//
//  AccountViewController.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class AccountViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let cell: CustomCell = CustomCell()
        cell.backgroundColor = WhiteColor
        view.addSubview(cell)
        cell.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.view.mas_left)
            make.right.equalTo()(self.view.mas_right)
            make.top.equalTo()(self.view.mas_top)
            make.height.mas_equalTo()(50)
        }
        
        
        let cellaaaa: CustomCell = CustomCell()
        cellaaaa.cellStyle = CustomCellStyle.HorizontalLayoutHaveMImgAndNotVImg
        cellaaaa.backgroundColor = WhiteColor
        view.addSubview(cellaaaa)
        cellaaaa.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.view.mas_left)
            make.right.equalTo()(self.view.mas_right)
            make.top.equalTo()(cell.mas_bottom)
            make.height.mas_equalTo()(50)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
