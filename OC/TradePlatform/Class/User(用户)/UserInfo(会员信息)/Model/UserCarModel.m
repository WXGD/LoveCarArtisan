//
//  UserCarModel.m
//  TradePlatform
//
//  Created by apple on 2017/4/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCarModel.h"

@implementation UserCarModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

// 给车牌号赋值
- (void)setCar_plate_no:(NSString *)car_plate_no {
    _car_plate_no = car_plate_no;
    if (car_plate_no.length > 2) {
        self.province_CAFTA = [car_plate_no substringToIndex:1]; //截取掉下标1之前的字符串
        self.car_plate_num = [car_plate_no substringFromIndex:1]; //截取掉下标1之后的字符串
    }
}


/** 请求会员车辆列表 */
+ (void)requestUsreCarListParame:(NSMutableDictionary *)parame success:(void(^)(NSMutableArray *usreCarListArray))success {
    /* 	/index.php?c=provider_user_car&a=list&v=1
     provider_user_id 	int 	是 	用户id   */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user_car", @"list", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = parame;
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在加载数据..." falseDate:@"login" parentController:nil success:^(id responseObject) {
        PDLog(@"sigln%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqualToString:@"0"]) {
            NSMutableArray *usreCarListArray = [UserCarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (success) {
                success(usreCarListArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        PDLog(@"sigln%@", error);
        [MBProgressHUD showError:@"请求失败"];
    }];
}

@end


