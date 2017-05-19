//
//  ModuleCell.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ModuleCell: UICollectionViewCell {
    /** 按钮1 */
    let btnOne:ModuleView = ModuleView()
    /** 按钮2 */
    let btnTwo:ModuleView = ModuleView()
    /** 按钮3 */
    let btnThree:ModuleView = ModuleView()
    /** cell位置 */
    var indexPath: NSIndexPath? {
        didSet {
            let tab: NSInteger = 50000 + indexPath!.section * 1000 + indexPath!.row * 100 + 50
            /** 按钮1 */
            self.btnOne.serviceBtn.tag = tab + 0;
            /** 按钮2 */
            self.btnTwo.serviceBtn.tag = tab + 1;
            /** 按钮3 */
            self.btnThree.serviceBtn.tag = tab + 2;
        }
    }
    /** 按钮数据 */
    var btnArray: NSArray? {
        didSet {
            
            if btnArray?.count == 1 {
                let module1: ServiceModuleModel = btnArray?.firstObject as! ServiceModuleModel
                /** 按钮1 */
                self.btnOne.serviceLabel.text = module1.name
                self.btnOne.serviceImage.image = UIImage(named: module1.image_url!)
                /** 按钮2 */
                self.btnTwo.isHidden = true
                /** 按钮3 */
                self.btnThree.isHidden = true
            }else if btnArray?.count == 2 {
                let module1: ServiceModuleModel = btnArray?.firstObject as! ServiceModuleModel
                let module2: ServiceModuleModel = btnArray?.object(at: 1) as! ServiceModuleModel
                /** 按钮1 */
                self.btnOne.serviceLabel.text = module1.name
                self.btnOne.serviceImage.image = UIImage(named: module1.image_url!)
                /** 按钮2 */
                self.btnTwo.serviceLabel.text = module2.name
                self.btnTwo.serviceImage.image = UIImage(named: module2.image_url!)
                /** 按钮3 */
                self.btnThree.isHidden = true
            }else if btnArray?.count == 3 {
                let module1: ServiceModuleModel = btnArray?.firstObject as! ServiceModuleModel
                let module2: ServiceModuleModel = btnArray?.object(at: 1) as! ServiceModuleModel
                let module3: ServiceModuleModel = btnArray?.lastObject as! ServiceModuleModel
                /** 按钮1 */
                self.btnOne.serviceLabel.text = module1.name
                self.btnOne.serviceImage.image = UIImage(named: module1.image_url!)
                /** 按钮2 */
                self.btnTwo.serviceLabel.text = module2.name
                self.btnTwo.serviceImage.image = UIImage(named: module2.image_url!)
                /** 按钮3 */
                self.btnThree.serviceLabel.text = module3.name
                self.btnThree.serviceImage.image = UIImage(named: module3.image_url!)
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        moduleCellLayoutView()
    }
    // MARK: 布局控件
    func moduleCellLayoutView() {
        /** 按钮1 */
        addSubview(btnOne)
        /** 按钮2 */
        addSubview(btnTwo)
        /** 按钮3 */
        addSubview(btnThree)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        /** 按钮1 */
        btnOne.mas_makeConstraints { (mark:MASConstraintMaker!) in
            mark.left.equalTo()(self.mas_left)
            mark.top.equalTo()(self.mas_top)
            mark.width.equalTo()(self.btnOne.mas_width)
        }
        /** 按钮2 */
        btnTwo.mas_makeConstraints { (mark:MASConstraintMaker!) in
            mark.left.equalTo()(self.btnOne.mas_right)
            mark.top.equalTo()(self.mas_top)
            mark.width.equalTo()(self.btnOne.mas_width)
        }
        /** 按钮3 */
        btnThree.mas_makeConstraints { (mark:MASConstraintMaker!) in
            mark.left.equalTo()(self.btnTwo.mas_right)
            mark.right.equalTo()(self.mas_right)
            mark.top.equalTo()(self.mas_top)
            mark.width.equalTo()(self.btnOne.mas_width)
        }
    }
}
