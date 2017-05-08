//
//  BennfitQuiryRecordModel.m
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BennfitQuiryRecordModel.h"

@interface BennfitQuiryRecordModel ()

/** 请求接点 */
@property (assign, nonatomic) NSInteger start;

@end

@implementation BennfitQuiryRecordModel



// 下拉刷新,请求保险查询记录
- (void)requestCardTypeListDataParams:(NSMutableDictionary *)params tableView:(UITableView *)tableView success:(void(^)(NSMutableArray *bennfitQuiryRecordArray))success {
    /* /index.php?c=insurance_query&a=list&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id 
     start 	int 	否 	记录开始位置,默认0
     pageSize 	int 	否 	每页显示条数,默认10   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = @"0"; // 列表开始位置 从0开始
    self.start = 20;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"BennfitQuiry" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *bennfitQuiryRecordArray = [BennfitQuiryRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束下拉刷新
            [tableView.mj_header endRefreshing];
            // 恢复数据加载
            [tableView.mj_footer resetNoMoreData];
            // 请求成功
            if (success) {
                success(bennfitQuiryRecordArray);
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


// 上啦加载,请求保险查询记录
- (void)userCardLoadRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void(^)(NSMutableArray *bennfitQuiryRecordArray))success {
    /* /index.php?c=insurance_query&a=list&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     start 	int 	否 	记录开始位置,默认0
     pageSize 	int 	否 	每页显示条数,默认10   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    parameters[@"pageSize"] = @"20"; // 列表行数 // 列表开始位置 从0开始
    parameters[@"start"] = [NSString stringWithFormat:@"%ld", (long)self.start]; // 列表开始位置 从0开始
    self.start += 20;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:nil falseDate:@"success" parentController:viewController success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            NSMutableArray *bennfitQuiryRecordArray = [BennfitQuiryRecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 结束刷新
            [tableView.mj_footer endRefreshing];
            if (bennfitQuiryRecordArray.count != 20) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [tableView.mj_footer endRefreshingWithNoMoreData];
            }
            // 请求成功
            if (success) {
                success(bennfitQuiryRecordArray);
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


// 新增车险接口
+ (void)addBenefitQuiryTextFieldParams:(NSMutableDictionary *)params success:(void(^)())success {
    /* /index.php?c=insurance_query&a=add&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     car_plate_no 	string 	否 	车牌号(拍照不传,直接查询必传)
     license_brand_model 	string 	否 	车牌型号(拍照不传,直接查询必传)
     engine_num 	string 	否 	发动机号(拍照不传,直接查询必传)
     vin 	string 	否 	车架号(拍照不传,直接查询必传)
     register_time 	string 	否 	初次登记时间(拍照不传,直接查询必传)
     query_type 	int 	否 	查询方式, 1-输入查询 2-拍照查询 (默认为1)      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
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

// 新增车险接口
+ (void)addBenefitQuiryImageViewParams:(NSMutableDictionary *)params drivingPermitImage:(UIImage *)drivingPermitImage success:(void(^)())success {
    /* /index.php?c=insurance_query&a=add&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     query_type 	int 	否 	查询方式, 1-输入查询 2-拍照查询 (默认为1)      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"add", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest tokenPOST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        NSData *data = UIImageJPEGRepresentation(drivingPermitImage, 0.2);
        [formData appendPartWithFileData:data name:@"license_img" fileName:@"license_img.jpg" mimeType:@"image/jpeg"];
    } success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            [MBProgressHUD showSuccess:@"添加成功"];
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
