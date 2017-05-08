//
//  AlertListAction.h
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ElasticBoxView.h"
#import "AlertListModel.h"

@protocol AlertModelChooseActionDelegate <NSObject>

@optional
- (void)alertModelChooseActionBoxView:(ElasticBoxView *)BoxView alertRow:(NSInteger)alertRow;

@end


@interface AlertListAction : ElasticBoxView

/** 代理 */
@property (assign, nonatomic) id<AlertModelChooseActionDelegate>delegate;
/** 订单类型数据 */
@property (strong, nonatomic) NSMutableArray *alertListArray;
/** 当前选中的类型 */
@property (strong, nonatomic) AlertListModel *currentCellModel;
/** 订单类型选择标题 */
@property (strong, nonatomic) UILabel *typeChooseTi;

@end

