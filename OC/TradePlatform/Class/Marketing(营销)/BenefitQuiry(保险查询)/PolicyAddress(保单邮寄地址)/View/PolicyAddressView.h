//
//  PolicyAddressView.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolicyAddressView : UIView
/** scrollview */
@property (strong, nonatomic) UIScrollView *policyScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIStackView *policyAddressBackView;
/** 车牌 */
@property (strong, nonatomic) UsedCellView *theCarNumView;
/** 保单实付金额 */
@property (strong, nonatomic) UsedCellView *theAmountView;
/** 车主信息 */
@property (strong, nonatomic) UsedCellView *theCarInfoView;
/** 车主姓名 */
@property (strong, nonatomic) UsedCellView *theNameView;
/** 身份证号 */
@property (strong, nonatomic) UsedCellView *theCardIdView;
/** 收件信息 */
@property (strong, nonatomic) UsedCellView *theRecipientInfoView;
/** 收件人姓名 */
@property (strong, nonatomic) UsedCellView *theRecipientNameView;
/** 收件人手机号 */
@property (strong, nonatomic) UsedCellView *theRecipientPhoneView;
/** 收件地址 */
@property (strong, nonatomic) UsedCellView *theRecipientAddressView;
/** 详细地址 */
@property (strong, nonatomic) UsedCellView *theAddressDetailView;
@end
