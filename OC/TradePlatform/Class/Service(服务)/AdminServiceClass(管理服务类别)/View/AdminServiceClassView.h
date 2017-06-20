//
//  AdminServiceClassView.h
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "HaveChosenView.h"
#import "NotChosenView.h"

@interface AdminServiceClassView : UIView

/** 已添加服务类别 */
@property (strong, nonatomic) HaveChosenView *haveChosenView;
/** 未添加服务类别 */
@property (strong, nonatomic) NotChosenView *notChosenView;
/** 已添加服务类别数据 */
@property (strong, nonatomic) NSMutableArray *haveChosenArray;
/** 未添加服务类别数据 */
@property (strong, nonatomic) NSMutableArray *notChosenArray;

@end
