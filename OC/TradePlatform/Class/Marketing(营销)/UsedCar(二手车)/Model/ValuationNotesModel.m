//
//  ValuationNotesModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ValuationNotesModel.h"

@interface ValuationNotesModel ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation ValuationNotesModel


// 下拉刷新,请求估值记录
- (void)usedCarValuationListDataParams:(NSMutableDictionary *)params tableView:(UITableView *)tableView success:(void(^)(NSMutableArray *valuationNotesArray))success {
    /* /index.php?c=usedcar_assess&a=list&v=1
     provider_id 	int 	是 	服务商id    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"usedcar_assess", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"UsedCarValuationList" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *valuationNotesArray = [ValuationNotesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            // 请求成功
            if (success) {
                success(valuationNotesArray);
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


// 上啦加载,请求估值记录
- (void)usedCarValuationLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *valuationNotesArray))success {
    /* /index.php?c=usedcar_assess&a=list&v=1
     provider_id 	int 	是 	服务商id    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"usedcar_assess", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *valuationNotesArray = [ValuationNotesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (valuationNotesArray.count != 20) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            // 请求成功
            if (success) {
                success(valuationNotesArray);
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



// 添加二手车估值
+ (void)AddUsedCarValuation:(NSMutableDictionary *)params success:(void(^)())success {
    /* /index.php?c=usedcar_assess&a=car_assess&v=1
     provider_id 	int 	是 	服务商id
     provider_user_car_id 	int 	否 	用户车辆id,用户详情中必传
     city_id 	int 	是 	城市id
     brand_id 	int 	是 	品牌id
     brand_series_id 	int 	是 	车系id
     car_model_id 	int 	是 	车型id
     purpose 	int 	是 	车辆用途：1自用 2公务商用 3营运
     car_status 	int 	是 	车况：1优秀 2一般 3较差
     used_date 	string 	是 	上牌时间： 格式yyyy-mm
     mileage 	float 	是 	公里数
     purchase_price 	float 	是 	购买价格     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"usedcar_assess", @"car_assess", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showSuccess:@"估值成功"];
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
