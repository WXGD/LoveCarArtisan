//
//  ServiceClassModel.swift
//  LoveCarArtisan
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ServiceClassModel: NSObject {
    /*  "goods_category_id": 1  #商品分类id,
     "name": "洗车"  #商品分类名称*/
    /** 商品分类id */
    var avatargoods_category_id_thumb : Int = 0
    /** 商品分类名称 */
    var name : String?
    /** 获取全部服务商品，所有字段
     "goods":*/
    /** 商品模型 */
    var goods : NSMutableArray?
    /** 收银页面添加字段
     "goods_category_name": "洗车"  #服务类别名称,  **/
    /** 商品分类名称 */
    var goods_category_name : String?
    /** 选中标记 */
    var checkMark : Bool?
}

