//
//  OrderInfoView.h
//  TradePlatform
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leftRigText.h"
#import "CWStarRateView.h"


@interface OrderInfoView : UIView

/** 填充scrollview的view */
@property (strong, nonatomic) UIStackView *orderInfoBackView;
/*================== 头部 ================*/
/** 状态 */
@property (strong, nonatomic) UILabel *orderType;
/** 订单号 */
@property (strong, nonatomic) leftRigText *orderNum;
/** 复制 */
@property (strong, nonatomic) UIButton *replicateBtn;
/*================== 客户信息  ================*/
/** 客户信息view */
@property (strong, nonatomic) UsedCellView *userInfo;
/** 车牌view */
@property (strong, nonatomic) UIView *plnView;
/** 车牌号 */
@property (strong, nonatomic) UILabel *plnLabel;
/** 用户删除提示 */
@property (strong, nonatomic) UILabel *delUserSign;
/*================== 服务详情  ================*/
/** 服务内容 */
@property (strong, nonatomic) UITableView *serviceTable;
/** 服务内容数据 */
@property (strong, nonatomic) NSMutableArray *serviceTableArray;
/** 总价 */
@property (strong, nonatomic) UsedCellView *priceView;
/** 优惠 */
@property (strong, nonatomic) UsedCellView *discountView;
/** 实收 */
@property (strong, nonatomic) UsedCellView *thePaidView;
/*================== 订单信息  ================*/
/** 支付方式 */
@property (strong, nonatomic) UsedCellView *paymentView;
/** 交易号 */
@property (strong, nonatomic) UsedCellView *tradeNumView;
/** 服务师傅 */
@property (strong, nonatomic) UsedCellView *serveMasterView;
/** 收银员 */
@property (strong, nonatomic) UsedCellView *cashierView;
/** 下单时间 */
@property (strong, nonatomic) UsedCellView *placeOrderTimeView;
/** 付款时间 */
@property (strong, nonatomic) UsedCellView *payTimeView;
/** 订单分割线 */
@property (strong, nonatomic) UIView *orderLineView;
/*================== 用户评价  ================*/
/** 用户评价标题 */
@property (strong, nonatomic) UsedCellView *ratedTitleView;
/** 用户评价View */
@property (strong, nonatomic) UIView *ratedView;
/** 评分 */
@property (strong, nonatomic) UILabel *ratedScoreLabel;
/** 评星 */
@property (strong, nonatomic) CWStarRateView *atedStarView;
/** 内容标题 */
@property (strong, nonatomic) UILabel *contentTitleLabel;
/** 评价内容 */
@property (strong, nonatomic) UILabel *contentLabel;


@end
