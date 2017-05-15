//
//  PolicyDetailModel.m
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PolicyDetailModel.h"

@implementation PolicyDetailModel
-(void)PolicyDetailRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void (^)(PolicyDetailModel *))success{
    /**/
    NSString *URL = [NSString
                     stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_quote", @"detail", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL
           parameters:parameters
          ProgressHUD:@"加载中..."
            falseDate:@"insurancequoteDetail"
     parentController:viewController
              success:^(id responseObject) {
                  PDLog(@"responseObject%@", responseObject);
                  PDLog(@"params%@", params);
                  if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]]
                       isEqual:@"0"]) {
                      // 获取数据模型数组
                      PolicyDetailModel *policyDetailModel = [PolicyDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
                      // 请求成功
                      if (success) {
                          success(policyDetailModel);
                      }
                  } else {
                      [MBProgressHUD showError:responseObject[@"msg"]];
                  }
              }
              failure:^(NSError *error) {
                  [MBProgressHUD showError:@"请求失败"];
                  PDLog(@"%@", error);
              }];
}


+ (NSDictionary *)objectClassInArray{
    return @{@"insurance_end_time" : [InsuranceEndTimeModel class],@"insurance_start_time" : [InsuranceStartTimeModel class]};
}

@end



@implementation InsuranceCategorysModel

@end


@implementation JqxModel

+ (NSDictionary *)objectClassInArray{
    return @{@"insurance_categorys" : [JqxInsuranceCategorys class]};
}

@end


@implementation JqxInsuranceCategorys

@end


@implementation SyxModel

+ (NSDictionary *)objectClassInArray{
    return @{@"insurance_categorys" : [SyxInsuranceCategorys class]};
}

@end


@implementation SyxInsuranceCategorys

@end


@implementation InsuranceEndTimeModel

@end

@implementation InsuranceStartTimeModel

@end
