//
//  ShoppingCartCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShoppingCartCell.h"

@interface ShoppingCartCell ()

/** 数量 */
@property (strong, nonatomic) UsedCellView *numView;
/** 商品单价 */
@property (strong, nonatomic) UILabel *priceLabel;
/** 总价 */
@property (strong, nonatomic) UsedCellView *totalView;
/** 总价标题 */
@property (strong, nonatomic) UILabel *totalTitleLabel;
/** 总价 */
@property (strong, nonatomic) UILabel *totalLabel;

@end

@implementation ShoppingCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        [self shoppingCartCellLayoutView];
    }
    return self;
}

- (void)shoppingCartCellLayoutView {
    /** 数量 */
    self.numView = [[UsedCellView alloc] init];
    self.numView.cellLabel.font = FourteenTypeface;
    self.numView.cellLabel.textColor = Black;
    self.numView.isCellImage = YES;
    self.numView.isArrow = YES;
    self.numView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.contentView addSubview:self.numView];
    /** 数量操作按钮 */
    /** 数量 */
    self.numTF = [[UITextField alloc] init];
    self.numTF.userInteractionEnabled = NO;
    [self.numView addSubview:self.numTF];
    /** 加号 */
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setImage:[UIImage imageNamed:@"cashier_add"] forState:UIControlStateNormal];
    [self.numView addSubview:self.addBtn];
    /** 减号 */
    self.subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.subBtn setImage:[UIImage imageNamed:@"cashier_sub"] forState:UIControlStateNormal];
    [self.numView addSubview:self.subBtn];
    /** 商品单价 */
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = GrayH2;
    self.priceLabel.font = FourteenTypeface;
    [self.numView addSubview:self.priceLabel];
    /** 销售价 */
    self.pretiumView = [[UsedCellView alloc] init];
    self.pretiumView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.pretiumView.arrowImage setTitle:@"元" forState:UIControlStateNormal];
    [self.pretiumView.arrowImage setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.pretiumView.arrowImage.titleLabel.font = FourteenTypeface;
    [self.pretiumView.arrowImage setImage:nil forState:UIControlStateNormal];
    self.pretiumView.cellLabel.text = @"成交单价";
    self.pretiumView.cellLabel.textColor = GrayH1;
    self.pretiumView.cellLabel.font = FourteenTypeface;
    self.pretiumView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.pretiumView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.pretiumView.viceTextFiled.font = FourteenTypeface;
    self.pretiumView.viceTextFiled.textColor = RedColor;
    self.pretiumView.isCellImage = YES;
    self.pretiumView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.contentView addSubview:self.pretiumView];
    /** 总价 */
    self.totalView = [[UsedCellView alloc] init];
    self.totalView.isCellImage = YES;
    self.totalView.isArrow = YES;
    self.totalView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.contentView addSubview:self.totalView];
    /** 总价标题 */
    self.totalTitleLabel = [[UILabel alloc] init];
    self.totalTitleLabel.text = @"合计";
    self.totalTitleLabel.textColor = Black;
    self.totalTitleLabel.font = FourteenTypeface;
    [self.totalView addSubview:self.totalTitleLabel];
    /** 总价 */
    self.totalLabel = [[UILabel alloc] init];
    self.totalLabel.textColor = Black;
    self.totalLabel.font = FourteenTypeface;
    [self.totalView addSubview:self.totalLabel];
}


- (void)setShoppingCartModel:(ShoppingCartModel *)shoppingCartModel {
    _shoppingCartModel = shoppingCartModel;
    /** 商品名称 */
    self.numView.cellLabel.text = shoppingCartModel.goods.goods_name;
    /** 商品数量 */
    self.numTF.text = [NSString stringWithFormat:@"%ld", shoppingCartModel.buy_num];
    /** 商品单价 */
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f元", shoppingCartModel.goods.price];
    /** 销售价 */
    self.pretiumView.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", shoppingCartModel.goods.actual_sale_price];
    /** 总价 */
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f元", shoppingCartModel.goods.actual_sale_price * shoppingCartModel.buy_num];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 数量 */
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(@48);
    }];
    /** 加号 */
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.numView.mas_centerY);
        make.right.equalTo(self.numView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    /** 数量 */
    [self.numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.addBtn.mas_centerY);
        make.right.equalTo(self.addBtn.mas_left);
    }];
    /** 减号 */
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.addBtn.mas_centerY);
        make.right.equalTo(self.numTF.mas_left);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    /** 商品单价 */
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.subBtn.mas_left).offset(-16);
        make.centerY.equalTo(self.numView.mas_centerY);
    }];
    /** 销售价 */
    [self.pretiumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.numView.mas_bottom);
        make.height.mas_equalTo(@48);
    }];
    /** 总价 */
    [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.pretiumView.mas_bottom);
        make.height.mas_equalTo(@40);
    }];
    /** 总价 */
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.totalView.mas_right).offset(-16);
        make.centerY.equalTo(self.totalView.mas_centerY);
    }];
    /** 总价标题 */
    [self.totalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.totalLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.totalView.mas_centerY);
    }];
}

@end
