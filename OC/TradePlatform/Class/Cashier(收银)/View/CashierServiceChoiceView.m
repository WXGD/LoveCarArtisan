//
//  CashierServiceChoiceView.m
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierServiceChoiceView.h"

@interface CashierServiceChoiceView ()<UITableViewDelegate, UITableViewDataSource>

/** view */
@property (strong, nonatomic) UIView *serviceView;
/** 取消 */
@property (strong, nonatomic) UIButton *cancelBtn;
/** table */
@property (strong, nonatomic) UITableView *optionTable;

@end

@implementation CashierServiceChoiceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        [self cashierServiceChoiceViewLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)cashierServiceChoiceViewLayoutView {
    /** view */
    self.serviceView = [[UIView alloc] init];
    self.serviceView.backgroundColor = HEXSTR_RGB(@"f5f5f5");
    [self addSubview:self.serviceView];
    /** 取消 */
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = FifteenTypeface;
    self.cancelBtn.backgroundColor = WhiteColor;
    [self.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.serviceView addSubview:self.cancelBtn];
    /** table */
    self.optionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
    self.optionTable.delegate = self;
    self.optionTable.dataSource = self;
    self.optionTable.bounces = NO;
    self.optionTable.rowHeight = 48;
    self.optionTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.serviceView addSubview:self.optionTable];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** view */
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 取消 */
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.serviceView.mas_bottom);
        make.left.equalTo(self.serviceView.mas_left);
        make.right.equalTo(self.serviceView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** table */
    [self.optionTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.cancelBtn.mas_top).offset(-10);
        make.left.equalTo(self.serviceView.mas_left);
        make.right.equalTo(self.serviceView.mas_right);
        if (self.choiceArray.count > 8) {
            make.height.mas_equalTo(@(48 * 8 + 24));
        }else {
            make.height.mas_equalTo(@(48 * self.choiceArray.count));
        }
    }];
    /** view */
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.optionTable.mas_top);
    }];
}

#pragma mark - tableview代理方
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.choiceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.serviceChoice) {
            /** 服务类型选择 */
        case ServiceTypeChoiceBtnAction:{
            static NSString *cellID = @"serviceTypeChoiceCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            ServiceProviderModel *serviceModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.serviceModel = serviceModel;
            return cell;
            break;
        }
            /** 服务商品选择 */
        case ServiceGoodsChoiceBtnAction:{
            static NSString *cellID = @"serviceGoodsChoiceCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            CommodityShowStyleModel *commodityModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.commodityModel = commodityModel;
            return cell;
            break;
        }
            /** 服务师傅选择 */
        case ServiceMasterChoiceBtnAction:{
            static NSString *cellID = @"serviceMasterChoiceCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            MerchantInfoModel *serviceMasterModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.serviceMasterModel = serviceMasterModel;
            return cell;
            break;
        }
            /** 支付方式选择 */
        case PayMethodChoiceBtnAction:{
            static NSString *cellID = @"payMethodChoiceCell";
            PayMethodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[PayMethodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            PaymentMethodModel *paymentMethod = [self.choiceArray objectAtIndex:indexPath.row];
            cell.payMethodModel = paymentMethod;
            return cell;
            break;
        }
            /** 会员卡类型选择 */
        case UserCardTyoeChoiceBtnAction:{
            static NSString *cellID = @"cardTypeChoiceCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            CardTypeModel *cardTypeModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.cardTypeModel = cardTypeModel;
            return cell;
            break;
        }
            /** 车况 */
        case CarConditionTypeChoiceBtnAction:{
            static NSString *cellID = @"carConditionCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            CarConditionModel *carConditionModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.carConditionModel = carConditionModel;
            return cell;
            break;
        }
            /** 车辆用途 */
        case CarUseTypeChoiceBtnAction:{
            static NSString *cellID = @"carUseModelCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            CarUseModel *carUseModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.carUseModel = carUseModel;
            return cell;
            break;
        }
            /** 订单支付状态 */
        case OrderPayStateBtnAction:{
            static NSString *cellID = @"orderPayStateCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            OrderPayStateModel *orderPayStateModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.orderPayStateModel = orderPayStateModel;
            return cell;
            break;
        }
            /** 用户筛选区间 */
        case UserScreenServiceBtnAction:{
            static NSString *cellID = @"UserScreenServiceCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            ExpireModel *expireModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.expireModel = expireModel;
            return cell;
            break;
        }
            /** 余额筛选区间 */
        case BalanceScreenServiceBtnAction:{
            static NSString *cellID = @"balanceScreenServiceCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            ExpireModel *expireModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.expireModel = expireModel;
            return cell;
            break;
        }
            /** 余次筛选区间 */
        case ThanTimesScreenServiceBtnAction:{
            static NSString *cellID = @"thanTimesScreenServiceCell";
            ServiceGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[ServiceGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            ExpireModel *expireModel = [self.choiceArray objectAtIndex:indexPath.row];
            cell.expireModel = expireModel;
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismiss];
    if (_delegate && [_delegate respondsToSelector:@selector(choiceDelegate:choiceArray:indexPath:)]) {
        [_delegate choiceDelegate:self.serviceChoice choiceArray:self.choiceArray indexPath:indexPath];
    }
}



#pragma mark - 显示
- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
    } completion:nil];
}

#pragma mark - 销毁
- (void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{

        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

@end
