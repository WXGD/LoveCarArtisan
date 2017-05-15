//
//  SchemeListViewController.h
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
// model
#import "UserCarModel.h"
#import "SafeTypeModel.h"

@interface SchemeListViewController : RootViewController

/** 保存方案列表 */
@property (strong, nonatomic) NSMutableArray *schemeArray;
/** 车辆信息模型 */
@property (strong, nonatomic) UserCarModel *carModel;
/** 添加方案 */
@property (copy, nonatomic) void(^addSchemeBlock)();
/** 编辑方案 */
@property (copy, nonatomic) void(^editSchemeBlock)(SafeTypeModel *safeTypeModel);

@end
