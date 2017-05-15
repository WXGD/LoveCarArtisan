//
//  UpdateReminderModel.h
//  CarRepairFactory
//
//  Created by apple on 2016/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateReminderModel : NSObject


/*   "app_version": "1"  #app版本,
 "app_url": "http://image.cheweifang.cn//update/android.apk"  #app下载url,
 "upgrade_info": "更新"  #app更新信息 */
/** 更新标题 */
@property (copy, nonatomic) NSString *title;
/** 版本号 */
@property (assign, nonatomic) float app_version;
/** 版本更新信息 */
@property (copy, nonatomic) NSString *upgrade_info;
/** 程序文件位置, */
@property (copy, nonatomic) NSString *app_url;




/** 更新提醒接口 */
+ (void)updateReminderAlreadyNewest:(void(^)())alreadyNewest;

@end
