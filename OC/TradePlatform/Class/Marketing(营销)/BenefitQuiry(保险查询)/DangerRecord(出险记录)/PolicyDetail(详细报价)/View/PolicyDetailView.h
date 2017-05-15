//
//  PolicyDetailView.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompulsoryInsuranceCell.h"
#import "BusinessInsuranceCell.h"
#import "TimeCell.h"
#import "CompulsoryHeaderView.h"
#import "BusinessHeaderView.h"
#import "PolicyDetailModel.h"

@interface PolicyDetailView : UIView
/** 询价:1  出险：2 */
@property (nonatomic, assign)NSInteger whereFrom;
/** 填充scrollview的view */
@property (strong, nonatomic) UIStackView *orderInfoBackView;
/*================== 用户信息 ================*/
/** 保险银行 */
@property (strong, nonatomic) UsedCellView *theInsuranceBankView;
/** 车牌、姓名 */
@property (strong, nonatomic) UsedCellView *theCarNumView;
/** 车型号 */
@property (strong, nonatomic) UsedCellView *theCarTypeView;

/*================== 强制险 ================*/
/** 强制险title */
@property (strong, nonatomic) UsedCellView *theCompulsoryView;
/** 强制险header */
@property (strong, nonatomic) CompulsoryHeaderView *theCompulsoryheaderView;
/** 强制险 */
@property (strong, nonatomic) UITableView *compulsoryInsuranceTable;
/** 强制险数据 */
@property (strong, nonatomic) NSMutableArray *compulsoryInsuranceTableArray;
/*================== 商业险 ================*/
/** 商业险title */
@property (strong, nonatomic) UsedCellView *theBusinessView;
/** 商业险header */
@property (strong, nonatomic) BusinessHeaderView *theBusinessheaderView;
/** 商业险 */
@property (strong, nonatomic) UITableView *businessInsuranceTable;
/** 商业险数据 */
@property (strong, nonatomic) NSMutableArray *businessInsuranceTableArray;
/*================== 金额 ================*/
/** 保费合计 */
@property (strong, nonatomic) UsedCellView *theInsuranceAmountView;
/** 折扣 */
@property (strong, nonatomic) UsedCellView *theDiscountView;
/*================== 到期时间 ================*/
/** 到期时间 */
@property (strong, nonatomic) UITableView *TimeTable;
/** 到期时间数据 */
@property (strong, nonatomic) NSMutableArray *timeTableArray;
///** 商业险到期时间 */
//@property (strong, nonatomic) UsedCellView *theBusinessTimeView;
///** 交强险到期时间 */
//@property (strong, nonatomic) UsedCellView *theTrafficCompulsoryView;
///** 车船税到期时间 */
//@property (strong, nonatomic) UsedCellView *theTransportTaxView;
/*================== 收件人信息 ================*/
/** 收件人 */
@property (strong, nonatomic) UsedCellView *theRecipientView;
/** 收件人手机号 */
@property (strong, nonatomic) UsedCellView *theRecipientPhoneView;
/** 收件人地址 */
@property (strong, nonatomic) UsedCellView *theRecipientAddressView;
/*================== 实付详情 ================*/
/** 实付详情 */
@property (strong, nonatomic) UsedCellView *thePaidView;
/*================== 出保单 ================*/
/** 实付详情按钮view */
@property (strong, nonatomic) UsedCellView *thePaidBtnView;
/** 实付详情按钮 */
@property (strong, nonatomic) UIButton *thePaidBtn;
@end
