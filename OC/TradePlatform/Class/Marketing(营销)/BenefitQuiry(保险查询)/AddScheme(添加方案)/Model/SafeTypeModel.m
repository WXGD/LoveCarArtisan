//
//  SafeTypeModel.m
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SafeTypeModel.h"

@implementation SafeTypeModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"jqx" : [BenefitModel class], @"syx" : [BenefitModel class]};
}



// 请求保险险种
+ (void)requestSafeTypeSuccess:(void(^)(SafeTypeModel *safeTypeModel))success {
    /* /index.php?c=insurance_category&a=list&v=1     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_category", @"list", APIEdition];
    // 发送请求
    [TPNetRequest GET:URL parameters:nil ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            SafeTypeModel *safeTypeModel = [SafeTypeModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 遍历交强险数据，默认选中交强险和车船税
            for (BenefitModel *benefitModel in safeTypeModel.jqx) {
                benefitModel.is_cover = 1;
            }
            // 请求成功
            if (success) {
                success(safeTypeModel);
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
