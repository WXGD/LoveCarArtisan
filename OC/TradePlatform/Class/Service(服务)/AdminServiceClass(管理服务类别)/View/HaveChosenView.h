//
//  HaveChosenView.h
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// 单利
#import "ServiceCategoryHandle.h"

@protocol HaveChosenDelegate <NSObject>

@optional
// 删除服务项目
- (void)delAdminDelegate:(UIButton *)button;
// 修改服务项目排序
- (void)editAdminSort:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath;

@end

@interface HaveChosenView : UIView

/** 代理 */
@property (strong, nonatomic) id<HaveChosenDelegate>delegate;
/** 已添加服务类别数据 */
@property (strong, nonatomic) NSMutableArray *haveChosenArray;

@end
