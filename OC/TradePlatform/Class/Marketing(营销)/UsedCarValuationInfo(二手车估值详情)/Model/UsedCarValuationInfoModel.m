//
//  UsedCarValuationInfoModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarValuationInfoModel.h"

@implementation UsedCarValuationInfoModel

/** 请求估值详情 */
+ (void)requestUsedCarValuationInfoData:(NSMutableDictionary *)params success:(void(^)(UsedCarValuationInfoModel *valuationInfoModel))success {
    /* /index.php?c=usedcar_assess&a=detail&v=1
     usedcar_assess_record_id 	int 	是 	估值记录id     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"usedcar_assess", @"detail", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"ValuationInfo" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            UsedCarValuationInfoModel *valuationInfoModel = [UsedCarValuationInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(valuationInfoModel);
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
