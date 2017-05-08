//
//  AddUserView.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "KeyBoardView.h"
#import "ChangeSexView.h"

@interface AddUserView : KeyBoardView

/** 手机 */
@property (strong, nonatomic) UsedCellView *addPhone;
/** 车牌号 */
@property (strong, nonatomic) UsedCellView *addPln;
/** 品牌车系 */
@property (strong, nonatomic) UsedCellView *addCar;
/** 姓名 */
@property (strong, nonatomic) UsedCellView *addName;
/** 性别 */
@property (strong, nonatomic) ChangeSexView *addSexChoice;
/** 会员卡类型 */
@property (strong, nonatomic) UsedCellView *cardTypeView;
/** 余额，余次 */
@property (strong, nonatomic) UsedCellView *balanceMoreThanView;
/** 年卡卡值 */
@property (strong, nonatomic) UsedCellView *kakaValueView;
/** 手机号位数限制 */
@property (strong, nonatomic) RACSignal *addPhoneSig;
/** 车牌号 */
@property (strong, nonatomic) RACSignal *addPlnSig;

@end
