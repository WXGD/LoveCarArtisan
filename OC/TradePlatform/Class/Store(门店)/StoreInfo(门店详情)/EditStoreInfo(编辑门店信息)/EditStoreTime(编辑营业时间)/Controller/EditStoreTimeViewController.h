//
//  EditStoreTimeViewController.h
//  TradePlatform
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "StoreModel.h"

@interface EditStoreTimeViewController : RootViewController

/** 开始时间 */
@property (nonatomic, copy) NSString *startStr;
/** 结束时间 */
@property (nonatomic, copy) NSString *endStr;
/** 门店信息 */
@property (strong, nonatomic) StoreModel *storeModel;
/** 修改成功回调 */
@property (copy, nonatomic) void(^EditStoreTimeSuccess)(StoreModel *storeModel);

@end
