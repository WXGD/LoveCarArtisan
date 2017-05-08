//
//  OrderServiceCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderServiceCell.h"

@interface OrderServiceCell ()

/** 服务名称 */
@property (strong, nonatomic) UsedCellView *orderServiceName;
/** 服务次数 */
@property (strong, nonatomic) UsedCellView *orderServiceNum;
/** 分割线 */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation OrderServiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        /** 服务名称 */
        self.orderServiceName = [[UsedCellView alloc] init];
        self.orderServiceName.cellLabel.text = @"总价";
        self.orderServiceName.cellLabel.font = FifteenTypeface;
        self.orderServiceName.cellLabel.textColor = Black;
        self.orderServiceName.describeLabel.text = @"总价";
        self.orderServiceName.describeLabel.font = ThirteenTypeface;
        self.orderServiceName.describeLabel.textColor = Black;
        self.orderServiceName.isArrow = YES;
        self.orderServiceName.isCellImage = YES;
        self.orderServiceName.isSplistLine = YES;
        [self.contentView addSubview:self.orderServiceName];
        /** 服务次数 */
        self.orderServiceNum = [[UsedCellView alloc] init];
        self.orderServiceNum.cellLabel.text = @"总价";
        self.orderServiceNum.cellLabel.font = FourteenTypeface;
        self.orderServiceNum.cellLabel.textColor = GrayH2;
        self.orderServiceNum.describeLabel.text = @"总价";
        self.orderServiceNum.describeLabel.font = TwelveTypeface;
        self.orderServiceNum.describeLabel.textColor = GrayH1;
        self.orderServiceNum.isArrow = YES;
        self.orderServiceNum.isCellImage = YES;
        self.orderServiceNum.isSplistLine = YES;
        [self.contentView addSubview:self.orderServiceNum];
        /** 分割线 */
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = DividingLine;
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)setOrderDetailsModel:(OrderDetailsModel *)orderDetailsModel {
    _orderDetailsModel = orderDetailsModel;
    /** 服务名称 */
    self.orderServiceName.cellLabel.text = orderDetailsModel.goods_name;
    /** 服务销售价 */
    self.orderServiceName.describeLabel.text = [NSString stringWithFormat:@"%.2f元", orderDetailsModel.sale_price];
    /** 服务次数 */
    self.orderServiceNum.cellLabel.text = [NSString stringWithFormat:@"可使用数量：%ld", orderDetailsModel.available_num];
    /** 总数量 */
    self.orderServiceNum.describeLabel.text = [NSString stringWithFormat:@"x%ld", orderDetailsModel.buy_num];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 服务名称 */
    [self.orderServiceName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.orderServiceName.cellLabel.mas_bottom);
    }];
    /** 服务次数 */
    [self.orderServiceNum mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderServiceName.mas_bottom).offset(16);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.orderServiceNum.cellLabel.mas_bottom);
    }];
    /** 分割线 */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.height.mas_equalTo(@0.5);
    }];
}

@end
