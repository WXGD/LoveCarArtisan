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
        cell.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndVImg
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
        
        
        let cellbbbb: CustomCell = CustomCell()
        cellbbbb.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn
        cellbbbb.backgroundColor = WhiteColor
        view.addSubview(cellbbbb)
        cellbbbb.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.view.mas_left)
            make.right.equalTo()(self.view.mas_right)
            make.top.equalTo()(cellaaaa.mas_bottom)
            make.height.mas_equalTo()(50)
        }
        
        
        let cellccc: CustomCell = CustomCell()
        cellccc.cellStyle = CustomCellStyle.HorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
        cellccc.backgroundColor = WhiteColor
        view.addSubview(cellccc)
        cellccc.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.view.mas_left)
            make.right.equalTo()(self.view.mas_right)
            make.top.equalTo()(cellbbbb.mas_bottom)
            make.height.mas_equalTo()(50)
        }
        
        
        let celldddd: CustomCell = CustomCell()
        celldddd.cellStyle = CustomCellStyle.HorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn
        celldddd.backgroundColor = WhiteColor
        view.addSubview(celldddd)
        celldddd.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.view.mas_left)
            make.right.equalTo()(self.view.mas_right)
            make.top.equalTo()(cellccc.mas_bottom)
            make.height.mas_equalTo()(50)
        }
        
        let celleeee: CustomCell = CustomCell()
        celleeee.cellStyle = CustomCellStyle.HorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn
        celleeee.backgroundColor = WhiteColor
        view.addSubview(celleeee)
        celleeee.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.equalTo()(self.view.mas_left)
            make.right.equalTo()(self.view.mas_right)
            make.top.equalTo()(celldddd.mas_bottom)
            make.height.mas_equalTo()(50)
        }
        
        
//        let cellffff: CustomCell = CustomCell()
//        cellffff.cellStyle = CustomCellStyle.BigImgVerticallyLayoutNotVImg
//        cellffff.backgroundColor = WhiteColor
//        view.addSubview(cellffff)
//        cellffff.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(self.view.mas_top)
//            make.height.mas_equalTo()(50)
//        }
//
//        let cellgggg: CustomCell = CustomCell()
//        cellgggg.cellStyle = CustomCellStyle.BigImgVerticallyLayoutHaveVImgAndNotVBtn
//        cellgggg.backgroundColor = WhiteColor
//        view.addSubview(cellgggg)
//        cellgggg.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(cellffff.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
//        
//        
//        let cellhhhh: CustomCell = CustomCell()
//        cellhhhh.cellStyle = CustomCellStyle.BigImgVerticallyLayoutHaveVImgAndHaveVBtn
//        cellhhhh.backgroundColor = WhiteColor
//        view.addSubview(cellhhhh)
//        cellhhhh.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(cellgggg.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
//        
//        
//        let celliiii: CustomCell = CustomCell()
//        celliiii.cellStyle = CustomCellStyle.VerticallyLayoutNotVImg
//        celliiii.backgroundColor = WhiteColor
//        view.addSubview(celliiii)
//        celliiii.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(cellhhhh.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
//        
//        let celljjj: CustomCell = CustomCell()
//        celljjj.cellStyle = CustomCellStyle.VerticallyLayoutHaveVImgAndNotVBtn
//        celljjj.backgroundColor = WhiteColor
//        view.addSubview(celljjj)
//        celljjj.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(celliiii.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
        
//        let cellkkk: CustomCell = CustomCell()
//        cellkkk.cellStyle = CustomCellStyle.VerticallyLayoutHaveVImgAndHaveVBtn
//        cellkkk.backgroundColor = WhiteColor
//        view.addSubview(cellkkk)
//        cellkkk.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(self.view.mas_top)
//            make.height.mas_equalTo()(50)
//        }
//        
//        let celllll: CustomCell = CustomCell()
//        celllll.cellStyle = CustomCellStyle.ViceTFHorizontalLayoutNotMImgAndNotVImg
//        celllll.backgroundColor = WhiteColor
//        view.addSubview(celllll)
//        celllll.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(cellkkk.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
//        
//        let cellmmm: CustomCell = CustomCell()
//        cellmmm.cellStyle = CustomCellStyle.ViceTFHorizontalLayoutHaveMImgAndNotVImg
//        cellmmm.backgroundColor = WhiteColor
//        view.addSubview(cellmmm)
//        cellmmm.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(celllll.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
//        
//        let cellnnn: CustomCell = CustomCell()
//        cellnnn.cellStyle = CustomCellStyle.ViceTFHorizontalLayoutNotMImgAndHaveVImgAndHaveVBtn
//        cellnnn.backgroundColor = WhiteColor
//        view.addSubview(cellnnn)
//        cellnnn.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(cellmmm.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
//        
//        
//        let cellooo: CustomCell = CustomCell()
//        cellooo.cellStyle = CustomCellStyle.ViceTFHorizontalLayoutNotMImgAndHaveVImgAndNotVBtn
//        cellooo.backgroundColor = WhiteColor
//        view.addSubview(cellooo)
//        cellooo.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(cellnnn.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
//        
//        
//        let cellppp: CustomCell = CustomCell()
//        cellppp.cellStyle = CustomCellStyle.ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndHaveVBtn
//        cellppp.backgroundColor = WhiteColor
//        view.addSubview(cellppp)
//        cellppp.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(cellooo.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
//        
//        
//        let cellqqq: CustomCell = CustomCell()
//        cellqqq.cellStyle = CustomCellStyle.ViceTFHorizontalLayoutHaveMImgAndHaveVImgAndNotVBtn
//        cellqqq.backgroundColor = WhiteColor
//        view.addSubview(cellqqq)
//        cellqqq.mas_makeConstraints { (make:MASConstraintMaker!) in
//            make.left.equalTo()(self.view.mas_left)
//            make.right.equalTo()(self.view.mas_right)
//            make.top.equalTo()(cellppp.mas_bottom)
//            make.height.mas_equalTo()(50)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
