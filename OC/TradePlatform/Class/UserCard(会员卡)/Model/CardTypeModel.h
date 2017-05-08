//
//  CardTypeModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllService.h"

@interface CardTypeModel : NSObject


/*  卡类型列表使用数据
 "provider_card_id": 2  #服务商卡id,
 "name": "5次卡"  #卡名称,
 "card_category_id": 1  #卡类别,
 "face_money": "15.00"  #卡面值,
 "available_num": "4"  #$卡次数,
 "available_year": 1  #卡使用年限,
 "price": "20.00"  #原价,
 "sale_price": "15.00"  #售价,
 "description": ""  #卡描述,
 "count": 1  #卡数量,
 "used_goods_text": "商品测试,商品2,美容#适用的服务",
 "used_goods":[1,2,3],
 "code": "001"  #卡前缀,
 "all_service":{
 "used_service_text": "商品测试,商品2,美容,",
 "goods_id":[1,2],
 "goods_category_id":[]}
 } **/


/** 服务商卡id */
@property (nonatomic, assign) NSInteger provider_card_id;
/** 卡类型号 */
@property (nonatomic, assign) NSInteger code;
/** 卡名称 */
@property (nonatomic, copy) NSString *name;
/** 卡类别（1次卡，2储值卡,3年卡） */
@property (nonatomic, assign) NSInteger card_category_id;
/** 卡面值 */
@property (nonatomic, assign) double face_money;
/** 卡次数 */
@property (nonatomic, assign) NSInteger available_num;
/** 卡使用年限 */
@property (nonatomic, assign) NSInteger available_year;
/** 卡原价 */
@property (nonatomic, assign) double price;
/** 卡销售价 */
@property (nonatomic, assign) double sale_price;
/** 卡描述 */
@property (nonatomic, copy) NSString *descri;
/** 卡数量 */
@property (nonatomic, assign) NSInteger count;
/** 适用服务 */
@property (nonatomic, copy) NSString *used_goods_text;
/** 适用服务id */
@property (nonatomic, copy) NSArray *used_goods;

// 自加字段
/** 当前选中标记 */
@property (nonatomic, assign) BOOL checkMark;

/** 自定义开卡使用 （包含服务ID，商品ID）**/
@property (nonatomic, strong) AllService *all_service;

// 请求所有会员卡类型，不带加载框
+ (void)requestCardTypeListDataParams:(NSMutableDictionary *)params tableView:(UITableView *)tableView success:(void(^)(NSMutableArray *cardTypeArray))success;
// 请求所有会员卡类型，带加载框
+ (void)requestCardTypeDataProgressHUDParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *cardTypeArray))success;

@end
