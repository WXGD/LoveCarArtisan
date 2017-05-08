//
//  OrderInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leftRigText.h"
#import "CWStarRateView.h"

@interface OrderInfoView : UIView

/** 填充scrollview的view */
@property (strong, nonatomic) UIStackView *orderInfoBackView;
/** 状态 */
@property (strong, nonatomic) UILabel *orderType;
/** 订单号 */
@property (strong, nonatomic) leftRigText *orderNum;
/** 复制 */
@property (strong, nonatomic) UIButton *copyBtn;
/** 客户信息view */
@property (strong, nonatomic) UsedCellView *userInfo;
/** 车牌view */
@property (strong, nonatomic) UIView *plnView;
/** 车牌号 */
@property (strong, nonatomic) UILabel *plnLabel;
/** 服务名称 */
@property (strong, nonatomic) UsedCellView *serviceNameView;
/** 用户姓名 */
@property (strong, nonatomic) leftRigText *userName;
/** 用户车牌 */
@property (strong, nonatomic) leftRigText *userPln;
/** 用户手机号 */
@property (strong, nonatomic) leftRigText *userPhone;
/** 单价 */
@property (strong, nonatomic) UsedCellView *unitPrice;
/** 数量 */
@property (strong, nonatomic) UsedCellView *number;
/** 备注 */
@property (strong, nonatomic) UsedCellView *remarks;
/** 总价 */
@property (strong, nonatomic) UsedCellView *total;
/** 优惠 */
@property (strong, nonatomic) UsedCellView *discount;
/** 支付金额 */
@property (strong, nonatomic) UsedCellView *payLoan;
/** 支付方式 */
@property (strong, nonatomic) UsedCellView *payMode;
/** 卡／交易号 */
@property (strong, nonatomic) UsedCellView *payCard;
/** 评分 */
@property (strong, nonatomic) leftRigText *commentScore;
/** 评星 */
@property (strong, nonatomic) CWStarRateView *commentStar;
/** 评价内容 */
@property (strong, nonatomic) leftRigText *commentContent;
/*==================依据订单状态显示的内容================*/
/** 支付信息标题 */
@property (strong, nonatomic) UILabel *payInfoTitle;
/** 评价标题 */
@property (strong, nonatomic) UILabel *evaluateTitle;
/** 支付信息view */
@property (strong, nonatomic) UIView *payInfoView;
/** 评价view */
@property (strong, nonatomic) UIView *evaluateView;

@end
