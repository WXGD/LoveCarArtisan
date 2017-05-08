//
//  BannerModel.m
//  TradePlatform
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

// 请求首页轮播图接口
+ (void)requestBannerDataParams:(NSMutableDictionary *)params success:(void(^)(NSMutableArray *bannerArray))success {
    /*/index.php?c=app_config&a=list&v=1
     position_type 	int 	否 	展示位置 ,默认为1 ，1-banner  */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"app_config", @"list", APIEdition];
    // 发送请求
    [TPNetRequest GET:URL parameters:nil ProgressHUD:nil falseDate:@"banner" parentController:nil success:^(id responseObject) {
        PDLog(@"请求首页轮播图%@", responseObject);
        NSMutableArray *bannerArray = [[NSMutableArray alloc] init];
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            bannerArray = [BannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (success) {
                success(bannerArray);
            }
        }else {
            if (success) {
                success(nil);
            }
        }
    } failure:^(NSError *error) {
        if (success) {
            success(nil);
        }
    }];
}


@end
