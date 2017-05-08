//
//  UserMemberCardModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMemberCardModel : NSObject

/* "provider_user_id": 25  #用户id,
 "card_no": "00100002"  #卡号,
 "money": "15.00"  #剩余余额,
 "num": 4  #剩余次数,
 "card_category_id": "1"  #卡分类 1-次卡 2-金额卡,
 "name": ""  #卡名称
 mobile：手机号
 "is_expire": 0  #会员卡是否过期 0-未过期 1-过期 */
/** 用户id */
@property (nonatomic, copy) NSString *provider_user_id;
/** 用户卡id */
@property (nonatomic, copy) NSString *provider_user_card_id;
/** 卡号 */
@property (nonatomic, copy) NSString *card_no;
/** 剩余余额 */
@property (nonatomic, assign) double money;
/** 剩余余次 */
@property (nonatomic, assign) NSInteger num;
/** 卡类型ID（1:次卡，2:金额卡,3-年卡 */
@property (nonatomic, assign) NSInteger card_category_id;
/** 卡名称 */
@property (nonatomic, copy) NSString *name;
/** 手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 会员卡是否过期 0-未过期 1-过期 */
@property (nonatomic, assign) NSInteger is_expire;
/** 车辆车牌号 */
@property (copy, nonatomic) NSString *car_plate_no;

/*用户会员卡字段   "provider_user_card_id": "1"  #用户卡id,
 "card_category_id": 1  #卡类型 1-次卡 2-储值卡 3-年卡,
 "money": "12"  #剩余余额,
 "num": 7  #剩余次数,
 "end_time": "2018-02-20"  #年卡的结束日期,
 "card_no": "00100001"  #会员卡号,
 "name": "10次卡"  #卡名称,
 "description": ""  #卡描述,
 "used_goods":[1, "##可以使用的商品id集合"],
 "used_goods_text": "大车普洗,小车普洗"  #适用的服务文字表示 */
/** 卡描述 */
@property (nonatomic, copy) NSString *descri;
/*收银，"card_category_id" = 2;
 "card_no" = 00700002;
 description = "";
 "end_time" = "";
 money = 300;
 name = "储值卡";
 num = 0;
 "provider_user_card_id" = 46;
 "used_goods" = ( 1,);
 "used_goods_text" = "大车精洗测试,小车普洗测试,测试洗车,洗车1,洗车次卡15次,大小车普洗,小车普洗,小车普洗,大车精洗,1分钱商品"; */
/** 会员卡可用服务 */
@property (nonatomic, strong) NSArray *used_goods;
/** 会员卡结束时间 */
@property (nonatomic, copy) NSString *end_time;
/** 会员卡可用服务 */
@property (nonatomic, copy) NSString *used_goods_text;
/** 搜索
 "card_category_id" = 1;
 "card_name" = "1次卡";
 "card_no" = 0010001;
 "end_time" = "";
 money = 0;
 num = 5;
 "provider_user_card_id" = 1;
 */
/** 卡名称 */
@property (nonatomic, copy) NSString *card_name;



/***************判断会员卡是否可用自用字段******************/
/** 会员卡是否可用 1-可用 0-不可用 */
@property (assign, nonatomic) BOOL is_used;
/***************会员卡充值自用字段******************/
/** 充值金额 */
@property (nonatomic, assign) float amountMoney;
/** 充值次数 */
@property (nonatomic, assign) NSInteger amountNum;


// 下拉刷新
- (void)userCardRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCardArray, NSDictionary *options))success;
// 上啦加载
- (void)userCardLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *userCardArray))success;


@end
