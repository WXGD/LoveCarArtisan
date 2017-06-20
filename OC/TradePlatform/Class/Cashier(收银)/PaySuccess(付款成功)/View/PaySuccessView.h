//
//  PaySuccessView.h
//  TradePlatform
//
//  Created by apple on 2017/2/23.
//  Copyright © 2017年 apple. All rights reserved.
//

// 收银成功页按钮点击类型
typedef NS_ENUM(NSInteger, PaySuccessBottonAction) {
    /** 完善信息按钮 */
    PerfectInfoBtnAction,
    /** 继续收款 */
    ContinueCashierBtnAction,
    /** 返回首页 */
    ReturnHomeBtnAction,
};



#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface PaySuccessView : UIView

/** 填充scrollview的view */
@property (strong, nonatomic) UIStackView *orderInfoBackView;
/** 完善信息view */
@property (strong, nonatomic) UIView *perfectInfoView;

/** 完善信息按钮 */
@property (strong, nonatomic) UIButton *perfectInfoBtn;
/** 继续收款 */
@property (strong, nonatomic) UIButton *continueCashierBtn;
/** 返回首页 */
@property (strong, nonatomic) UIButton *returnHomeBtn;
/** 优惠券 */
@property (strong, nonatomic) UITableView *couponTable;
/** 优惠券数据 */
@property (strong, nonatomic) NSMutableArray *couponArray;
/** 用户信息(修改用户信息时需要) */
@property (strong, nonatomic) UserModel *userInfo;

@end
