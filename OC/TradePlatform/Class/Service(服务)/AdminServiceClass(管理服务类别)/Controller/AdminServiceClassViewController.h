//
//  AdminServiceClassViewController.h
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RootViewController.h"

@protocol AdminServiceClassDelegate <NSObject>

@optional
- (void)confirmReviseDelegate:(NSMutableArray *)haveChosenArray notChosenArray:(NSMutableArray *)notChosenArray;

@end

@interface AdminServiceClassViewController : RootViewController

/** 已添加服务类别数据 */
@property (strong, nonatomic) NSMutableArray *haveChosenArray;
/** 未添加服务类别数据 */
@property (strong, nonatomic) NSMutableArray *notChosenArray;
/** 管理修改代理 */
@property (assign, nonatomic) id<AdminServiceClassDelegate>delegate;

@end
