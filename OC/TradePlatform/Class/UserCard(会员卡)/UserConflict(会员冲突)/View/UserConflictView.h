//
//  UserConflictView.h
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAndPlnViewCell.h"

@protocol UserConflictViewDelegate <NSObject>

@optional
- (void)userCellSelectIndexPath:(NSIndexPath *)indexPath;

@end

@interface UserConflictView : UIView

@property (assign, nonatomic) id<UserConflictViewDelegate>delegate;

/** 冲突用户列表数据 */
@property (strong, nonatomic) NSMutableArray *conflictUserArray;
/** 冲突用户列表 */
@property (strong, nonatomic) UITableView *conflictUserTableView;
/** 合并会员卡 */
@property (strong, nonatomic) UIButton *mergeUserCardBtn;
/** 合并会员车辆 */
@property (strong, nonatomic) UIButton *mergeUserCarBtn;
/** 删除按钮 */
@property (strong, nonatomic) UIButton *deleteBtn;
/** 用户选择的模型 */
@property (strong, nonatomic) UserModel *userSelectedModel;
/** 用户未选择的模型 */
@property (strong, nonatomic) UserModel *userUnSelectedModel;




@end
