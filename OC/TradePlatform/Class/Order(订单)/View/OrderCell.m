//
//  OrderCell.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderCell.h"
#import "OrderCellView.h"

@interface OrderCell ()

/** 订单cell */
@property (strong, nonatomic) OrderCellView *orderCellView;

@end

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        /** 订单cell */
        self.orderCellView = [[OrderCellView alloc] init];
        [self.contentView addSubview:self.orderCellView];
    }
    return self;
}

- (void)setOrderModel:(OrderModel *)orderModel {
    _orderModel = orderModel;
    // 订单商品数量
    self.orderCellView.orderGoodsNum = orderModel.order_detail.count;
    // 遍历订单商品数量
    for (int i = 0; i < self.orderCellView.orderGoodsNum; i++) {
        // 订单商品模型
        OrderGoodsModel *orderGoodsModel = [orderModel.order_detail objectAtIndex:i];
        // 订单商品view
        OrderGoodsView *orderGoodsView = [self.orderCellView viewWithTag:1570 + i];
        /** 商品类别名称 */
        orderGoodsView.goodsClassName = orderGoodsModel.goods_category_name;
        /** 商品名称 */
        orderGoodsView.goodsNameLabel.text = orderGoodsModel.goods_name;
        /** 商品数量 */
        orderGoodsView.goodsNumLabel.text = [NSString stringWithFormat:@"x%ld", orderGoodsModel.buy_num];
        /** 商品价格 */
        orderGoodsView.goodsPriceLabel.text = [NSString stringWithFormat:@"%.2f", orderGoodsModel.sale_price];
    }
    
    
    
    
    /** 服务类型名称 */
    self.orderCellView.serviceTypeLabel.text = orderModel.order_category_name;
    /** 订单时间 */
    self.orderCellView.orderTimeLabel.text = orderModel.create_time;
    /** 用户车牌号 */
    self.orderCellView.plnLabel.text = orderModel.car_plate_no;
    // 判断是否有用户车牌号
    if (!orderModel.car_plate_no || orderModel.car_plate_no.length == 0) {
        /** 用户手机号 */
        self.orderCellView.plnLabel.text = orderModel.mobile;
        /** 用户手机号 */
        self.orderCellView.phoneLabel.text = @"";
    }else {
        /** 用户手机号 */
        self.orderCellView.phoneLabel.text = orderModel.mobile;
    }
    /** 合计 */
    self.orderCellView.orderTotalLabel.text = [NSString stringWithFormat:@"合计：%.2f元", orderModel.total_actual_price];
    /** 订单类别id(2-服务 3-开卡 4-充值 5-赠品) */
    switch (orderModel.order_category_id) {
        case 2: {
            self.orderCellView.serviceTypeImage.image = [UIImage imageNamed:@"order_service"];
            break;
        }
        case 3: {
            self.orderCellView.serviceTypeImage.image = [UIImage imageNamed:@"order_open_card"];
            break;
        }
        case 4: {
            self.orderCellView.serviceTypeImage.image = [UIImage imageNamed:@"order_card_recharge"];
            break;
        }
        case 5: {
            self.orderCellView.serviceTypeImage.image = [UIImage imageNamed:@"order_premium"];
            break;
        }
        default:
            break;
    }
    /** 订单状态(1未支付，2待使用，3待评价，4已完成 6退款) */
    switch (orderModel.order_status) {
        case 1: {
            self.orderCellView.orderStateLabel.text = @"未支付";
            break;
        }
        case 2: {
            self.orderCellView.orderStateLabel.text = @"待使用";
            break;
        }
        case 3: {
            self.orderCellView.orderStateLabel.text = @"待评价";
            break;
        }
        case 4: {
            self.orderCellView.orderStateLabel.text = @"已完成";
            break;
        }
        case 6: {
            self.orderCellView.orderStateLabel.text = @"退款";
            break;
        }
        default:
            break;
    }
    /** 支付方式 1-支付宝 2-微信 3或4-卡支付 6-现金 7-年卡 */
    switch (orderModel.pay_method_id) {
        case 1: {
            self.orderCellView.payType.text = @"支付宝支付";
            break;
        }
        case 2: {
            self.orderCellView.payType.text = @"微信支付";
            break;
        }
        case 3: {
            self.orderCellView.payType.text = @"会员卡支付";
            break;
        }
        case 4: {
            self.orderCellView.payType.text = @"会员卡支付";
            break;
        }
        case 6: {
            self.orderCellView.payType.text = @"现金支付";
            break;
        }
        case 7: {
            self.orderCellView.payType.text = @"年卡支付";
            break;
        }
        default:
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 订单cell */
    [self.orderCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}



@end

