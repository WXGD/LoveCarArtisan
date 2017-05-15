
//
//  UpdateReminderModel.m
//  CarRepairFactory
//
//  Created by apple on 2016/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UpdateReminderModel.h"
#import "UpdateReminderView.h"

@implementation UpdateReminderModel


// 更新提醒接口
+ (void)updateReminderAlreadyNewest:(void(^)())alreadyNewest {
    /*/index.php?c=app_client_version&a=info&v=1 */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"app_client_version", @"info", APIEdition];
    // 发送请求
    [TPNetRequest GET:URL parameters:nil ProgressHUD:nil falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"更新提醒%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            UpdateReminderModel *updateReminder = [UpdateReminderModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 当前版本号
            float currentVersion = [[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] floatValue];
            if (updateReminder.app_version > currentVersion) {
                PDLog(@"打印");
                UpdateReminderView *updateReminderView = [[UpdateReminderView alloc] init];
                updateReminderView.versionInfo = updateReminder;
                [updateReminderView show];
            }else {
                if (alreadyNewest) {
                    alreadyNewest();
                }
            }
        }
    } failure:^(NSError *error) {
        PDLog(@"error%@", error);
    }];
}


@end
