//
//  UpdateReminderView.h
//  CarRepairFactory
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateReminderModel.h"

@interface UpdateReminderView : UIView

/** 显示 */
- (void)show;
/** 销毁 */
- (void)dismiss;
/** 新版本更新内容 */
@property (nonatomic, strong) UpdateReminderModel *versionInfo;

@end
