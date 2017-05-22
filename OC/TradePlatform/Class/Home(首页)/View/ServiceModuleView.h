//
//  ServiceModuleView.h
//  TradePlatform
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "SMPageControl.h"
#import "ModuleCell.h"

@protocol ServiceModuleDelegate <NSObject>

@optional
/** 服务模块点击代理 */
- (void)serviceModuleBtnAction:(UIButton *)button;

@end

@interface ServiceModuleView : UIView

/** 服务模块数据 */
@property (nonatomic, strong) NSMutableArray *moduleArray;
/** 服务模块代理 */
@property (assign, nonatomic) id<ServiceModuleDelegate>delegate;

@end
