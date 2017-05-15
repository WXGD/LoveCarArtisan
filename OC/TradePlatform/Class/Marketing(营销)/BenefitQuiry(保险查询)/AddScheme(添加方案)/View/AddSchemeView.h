//
//  AddSchemeView.h
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
// view
#import "AddSchemeCell.h"
// model
#import "SafeTypeModel.h"

@protocol AddSchemeDelegate <NSObject>

@optional
- (void)addSchemeDidSelect:(BenefitModel *)benefitModel indexPath:(NSIndexPath *)indexPath cell:(AddSchemeCell *)cell;

@end

@interface AddSchemeView : UIView

/** 代理 */
@property (assign, nonatomic) id<AddSchemeDelegate>delegate;
/** 确认添加btn */
@property (strong, nonatomic) UIButton *confirmAddBtn;
/** 保险列表数据 */
@property (strong, nonatomic) SafeTypeModel *safeTypeModel;
/** 商业险Table */
@property (strong, nonatomic) UITableView *tradeBenefitTable;

@end
