//
//  ShoppingCartFootView.m
//  TradePlatform
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShoppingCartFootView.h"

@interface ShoppingCartFootView ()
/** 总价view */
@property (strong, nonatomic) UIView *totalView;
/** 总价标题 */
@property (strong, nonatomic) UILabel *totalTitleLabel;
/** 分割线view */
@property (strong, nonatomic) UIView *lineView;

/** 收款view */
@property (strong, nonatomic) UIView *collectionView;
/** 购物车数量 */
@property (strong, nonatomic) UILabel *shoppingCartNumLabel;

@end

@implementation ShoppingCartFootView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self shoppingCartFootLayoutView];
    }
    return self;
}

/** 购物车数量 */
- (void)setShoppingCartNum:(NSInteger)shoppingCartNum {
    _shoppingCartNum = shoppingCartNum;
    if (shoppingCartNum == 0) {
        self.shoppingCartNumLabel.text = nil;
        [self.shoppingCartNumLabel setHidden:YES];
        self.shoppingCartBtn.selected = NO;
    }else if (shoppingCartNum > 99) {
        self.shoppingCartNumLabel.text = @"99+";
        [self.shoppingCartNumLabel setHidden:NO];
        self.shoppingCartBtn.selected = YES;
    }else {
        self.shoppingCartNumLabel.text = [NSString stringWithFormat:@"%ld", shoppingCartNum];
        [self.shoppingCartNumLabel setHidden:NO];
        self.shoppingCartBtn.selected = YES;
    }
}


#pragma mark - view布局
- (void)shoppingCartFootLayoutView {
    /** 收款view */
    self.collectionView = [[UIView alloc] init];
    self.collectionView.backgroundColor = WhiteColor;
    [self addSubview:self.collectionView];
    /** 购物车 */
    self.shoppingCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shoppingCartBtn setImage:[UIImage imageNamed:@"cashier_shopping_cart_not_click"] forState:UIControlStateNormal];
    [self.shoppingCartBtn setImage:[UIImage imageNamed:@"cashier_shopping_cart_click"] forState:UIControlStateSelected];
    self.shoppingCartBtn.backgroundColor = HEXSTR_RGB(@"455a64");
    self.shoppingCartBtn.tag = ShoppingCartBtnAction;
    [self.collectionView addSubview:self.shoppingCartBtn];
    /** 购物车数量 */
    self.shoppingCartNumLabel = [[UILabel alloc] init];
    self.shoppingCartNumLabel.backgroundColor = RedColor;
    self.shoppingCartNumLabel.textColor = WhiteColor;
    self.shoppingCartNumLabel.font = TenTypeface;
    self.shoppingCartNumLabel.textAlignment = NSTextAlignmentCenter;
    self.shoppingCartNumLabel.layer.masksToBounds = YES;
    self.shoppingCartNumLabel.layer.cornerRadius = 7.5;
    [self.collectionView addSubview:self.shoppingCartNumLabel];
    [self.shoppingCartNumLabel setHidden:YES];
    /** 确认收款btn */
    self.confirmationCollectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmationCollectionBtn setTitle:@"确认收款" forState:UIControlStateNormal];
    self.confirmationCollectionBtn.titleLabel.font = SixteenTypeface;
    self.confirmationCollectionBtn.titleLabel.textColor = WhiteColor;
    self.confirmationCollectionBtn.backgroundColor = ThemeColor;
    self.confirmationCollectionBtn.tag = ConfirmationCollectionBtnAction;
    [self.collectionView addSubview:self.confirmationCollectionBtn];
    /** 提交订单 */
    self.placeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.placeOrderBtn setTitle:@"挂单暂不收银" forState:UIControlStateNormal];
    self.placeOrderBtn.titleLabel.font = SixteenTypeface;
    self.placeOrderBtn.titleLabel.textColor = WhiteColor;
    self.placeOrderBtn.backgroundColor = BlueColor;
    self.placeOrderBtn.tag = PlaceOrderBtnAction;
    [self.collectionView addSubview:self.placeOrderBtn];
    /** 总价view */
    self.totalView = [[UIView alloc] init];
    self.totalView.backgroundColor = WhiteColor;
    [self addSubview:self.totalView];
    /** 总价按钮 */
    self.totalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.totalBtn.tag = TotalBtnAction;
    [self.totalView addSubview:self.totalBtn];
    /** 总价标题 */
    self.totalTitleLabel = [[UILabel alloc] init];
    self.totalTitleLabel.text = @"总价";
    self.totalTitleLabel.textColor = Black;
    self.totalTitleLabel.font = FourteenTypeface;
    [self.totalView addSubview:self.totalTitleLabel];
    /** 总价 */
    self.totalLabel = [[UILabel alloc] init];
    self.totalLabel.textColor = ThemeColor;
    self.totalLabel.font = FourteenTypeface;
    self.totalLabel.text = @"总价";
    [self.totalView addSubview:self.totalLabel];
    /** 分割线view */
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = DividingLine;
    [self.totalView addSubview:self.lineView];
    /** 清空商品 */
    self.emptyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.emptyBtn setImage:[UIImage imageNamed:@"cashier_shopping_cart_empty"] forState:UIControlStateNormal];
    [self.emptyBtn setTitle:@"清空" forState:UIControlStateNormal];
    [self.emptyBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.emptyBtn.titleLabel.font = FourteenTypeface;
    self.emptyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.emptyBtn.tag = EmptyBtnAction;
    [self.totalView addSubview:self.emptyBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 收款view */
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 购物车 */
    [self.shoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.collectionView.mas_left);
        make.top.equalTo(self.collectionView.mas_top);
        make.bottom.equalTo(self.collectionView.mas_bottom);
        make.width.mas_equalTo(@70);
        
    }];
    /** 购物车数量 */
    [self.shoppingCartNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.shoppingCartBtn.mas_top).offset(10);
        make.right.equalTo(self.shoppingCartBtn.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    /** 确认收款btn */
    [self.confirmationCollectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.collectionView.mas_top);
        make.bottom.equalTo(self.collectionView.mas_bottom);
        make.right.equalTo(self.collectionView.mas_right);
        make.width.mas_equalTo(@125);
    }];
    /** 提交订单 */
    [self.placeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.shoppingCartBtn.mas_right);
        make.right.equalTo(self.confirmationCollectionBtn.mas_left);
        make.top.equalTo(self.collectionView.mas_top);
        make.bottom.equalTo(self.collectionView.mas_bottom);
    }];
    /** 总价view */
    [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.collectionView.mas_top);
        make.height.mas_equalTo(@48);
    }];
    /** 总价标题 */
    [self.totalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.totalView.mas_left).offset(16);
        make.centerY.equalTo(self.totalView.mas_centerY);
    }];
    /** 总价 */
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.totalTitleLabel.mas_right).offset(10);
        make.centerY.equalTo(self.totalView.mas_centerY);
    }];
    /** 清空商品 */
    [self.emptyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.totalView.mas_right);
        make.top.equalTo(self.totalView.mas_top);
        make.bottom.equalTo(self.totalView.mas_bottom);
        make.width.mas_equalTo(@75);
    }];
    /** 总价按钮 */
    [self.totalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.totalView.mas_left);
        make.right.equalTo(self.emptyBtn.mas_left);
        make.top.equalTo(self.totalView.mas_top);
        make.bottom.equalTo(self.totalView.mas_bottom);
    }];
    /** 分割线view */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.emptyBtn.mas_left);
        make.centerY.equalTo(self.totalView.mas_centerY);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@0.5);
    }];
    /** self高 */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.totalView.mas_top);
    }];
}

@end
