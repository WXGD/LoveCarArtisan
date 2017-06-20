//
//  CouponModel.m
//  TradePlatform
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponModel.h"

@interface CouponModel ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation CouponModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"coupons" : [CouponInfoModel class]};
}


// 下拉刷新
- (void)couponRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(CouponModel *couponModel))success {
    /*/index.php?c=coupon_grant_record&a=list&v=1
     provider_id 	string 	是 	服务商id
     mobile 	string 	是 	手机号
     car_plate_no 	string 	是 	车牌号
     goods_id 	int 	是 	商品id
     price 	float 	是 	商品实际价格
     is_useful 	int 	否 	是否可用，0-不可用 1-可用 默认为1
     start 	int 	否 	数据显示位置
     pageSize 	int 	否 	每页显示条数      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon_grant_record", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"orderList" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型
            CouponModel *couponModel = [CouponModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            [tableView reloadData];
            // 请求成功
            if (success) {
                success(couponModel);
            }
        }else {
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        // 结束下拉刷新
        [tableView.mj_header endRefreshing];
        // 恢复数据加载
        [tableView.mj_footer resetNoMoreData];
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}

// 上啦加载
- (void)couponLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(CouponModel *couponModel))success {
    /*/index.php?c=order&a=list&v=1
     staff_user_id 	int 	否 	登陆者id(商户app必传,用户自己获取时不传)
     provider_id 	int 	是 	服务商id
     order_category_id 	int 	否 	订单类型id，默认为0（代表全部）
     provider_user_id 	int 	否 	用户id,(获取用户消费记录时必传)
     order_status 	int 	否 	订单状态，默认为0（代表全部）
     sale_user_id 	int 	否 	服务师傅id,默认为0（代表全部）
     pay_method 	int 	否 	支付方式, 1-支付宝 2-微信 3-会员卡 4-现金 (默认为0,代表全部)
     goods_category_id 	int 	否 	服务类别id,默认为0（代表全部）
     order_time 	string 	否 	订单时间区间,格式： 开始时间_截至时间,默认为''(代表全部)
     start 	int 	否 	列表开始位置，默认为0
     pageSize 	int 	否 	每页显示列表数,默认为10      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"order", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"type"] = @"2"; // 服务商项目类型 1：4S店；2：洗车行；3：维修店；4：加油站；
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    params[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"orderList" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型
            CouponModel *couponModel = [CouponModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 刷新tableView
            [tableView reloadData];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (couponModel.coupons.count != 20) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            // 请求成功
            if (success) {
                success(couponModel);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        // 结束刷新
        [tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


@end


@implementation CouponInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"descri" : @"description"};
}

// 请求商家优惠券列表
+ (void)requestMerchantCouponListParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *couponArray))success {
    /*/index.php?c=coupon&a=list&v=1
     provider_user_id 	int 	是 	用户id
     provider_id 	int 	是 	服务商id       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"couponList" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *couponArray = [CouponInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(couponArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


// 商家赠送优惠券列表
+ (void)merchantGiveCouponListParams:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=coupon_grant_record&a=donate&v=1
     provider_user_id 	int 	是 	用户id
     coupon_id 	int 	是 	优惠券id       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"coupon_grant_record", @"donate", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"orderList" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            // 请求成功
            if (success) {
                success();
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}



@end


