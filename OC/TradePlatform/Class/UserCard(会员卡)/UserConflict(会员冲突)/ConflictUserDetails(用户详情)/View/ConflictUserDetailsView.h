//
//  ConflictUserDetailsView.h
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConflictUserDetailsView : UIView

/** 填充scrollview的view */
@property (strong, nonatomic) UIStackView *conflictUserDetailsView;

/** 姓名 */
@property (strong, nonatomic) UsedCellView *userNameView;
/** 电话 */
@property (strong, nonatomic) UsedCellView *userPhoneView;
/** 会员卡列表数量 */
@property (strong, nonatomic) UIView *userCardView;
@property (strong, nonatomic) UILabel *userCardCountLabel;
/** 会员卡table */
@property (strong, nonatomic) UITableView *userCardTable;
/** 会员卡模型数组 */
@property (strong, nonatomic) NSMutableArray *userCardArray;
/**  车辆列表数量 */
@property (strong, nonatomic) UIView *userCarView;
@property (strong, nonatomic) UILabel *userCarCountLabel;
/** 车辆table */
@property (strong, nonatomic) UITableView *userCarTable;
/** 车辆模型数组 */
@property (strong, nonatomic) NSMutableArray *userCarArray;

@end
