//
//  ServiceProviderModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AlertListModel.h"
#import "CommodityShowStyleModel.h"


@interface AdminServiceModel : NSObject

/*  "used_goods_category": [] #可用服务,
 "unUsed_goods_category": []  #不可用服务 */
/** 可用服务 */
@property (nonatomic, strong) NSMutableArray *used_goods_category;
/** 不可用服务 */
@property (nonatomic, strong) NSMutableArray *unUsed_goods_category;

@end


@interface ServiceProviderModel : AlertListModel

/*  "goods_category_id": 1  #商品分类id,
 "name": "洗车"  #商品分类名称*/

/** 商品分类id */
@property (nonatomic, assign) NSInteger goods_category_id;
/** 商品分类名称 */
@property (nonatomic, copy) NSString *name;
/** 获取全部服务商品，所有字段
 "goods":*/
/** 商品模型 */
@property (nonatomic, strong) NSMutableArray *goods;
/** 收银页面添加字段
 "goods_category_name": "洗车"  #服务类别名称,  **/
/** 商品分类名称 */
@property (nonatomic, copy) NSString *goods_category_name;
/** 自加字段  **/
/** 选中标记 */
@property (nonatomic, assign) BOOL checkMark;

//// 获取全部服务项目(不包含全部类型)
//+ (void)requesServiceListDataParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *serviceList))success;
//// 获取全部服务项目(包含全部类型)
//+ (void)requestServiceTypeListParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *commodityTypeArray))success;

// 获取全部服务商品
+ (void)requestServiceCommodityParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *serviceCommodityArray))success;

@end
