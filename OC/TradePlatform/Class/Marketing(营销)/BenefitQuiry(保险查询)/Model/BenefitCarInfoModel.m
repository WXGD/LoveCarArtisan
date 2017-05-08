//
//  BenefitCarInfoModel.m
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitCarInfoModel.h"

@implementation BenefitCarInfoModel


// 通过车牌号查询车辆信息接口
+ (void)usePlnQuiryCarInfo:(NSMutableDictionary *)params success:(void(^)(BenefitCarInfoModel *carInfo))success {
    /* /index.php?c=insurance_query&a=car_info&v=1
     provider_id 	int 	是 	服务商id
     car_plate_no 	int 	是 	车牌号       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"car_info", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            BenefitCarInfoModel *carInfo = [BenefitCarInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(carInfo);
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
