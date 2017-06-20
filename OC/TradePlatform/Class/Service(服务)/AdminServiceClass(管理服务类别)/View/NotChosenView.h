//
//  NotChosenView.h
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotChosenDelegate <NSObject>

@optional
- (void)addAdminDelegate:(NSInteger)cellItem;

@end

@interface NotChosenView : UIView

/** 代理 */
@property (strong, nonatomic) id<NotChosenDelegate>delegate;
/** 未添加服务类别数据 */
@property (strong, nonatomic) NSMutableArray *notChosenArray;

@end
