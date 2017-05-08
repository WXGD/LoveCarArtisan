//
//  OpenCardView.m
//  TradePlatform
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OpenCardView.h"

@interface OpenCardView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *openCardScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *openCardView;

/** 手机号必填标记 */
@property (strong, nonatomic) UIImageView *phoneSign;
/** 售价必填标记 */
@property (strong, nonatomic) UIImageView *priceSign;
/** 确认开卡 */
@property (strong, nonatomic) UIView *confirOpenCardView;

/** 赠品 */
@property (strong, nonatomic) UIView *premiumView;
@property (strong, nonatomic) UILabel *premiumTitleLabel;
@property (strong, nonatomic) UIImageView *arrowImage;

@end

@implementation OpenCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self openCardLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)openCardLayoutView {
    /** 背景scrollview */
    self.openCardScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.openCardScrollView];
    /** 填充scrollview的view */
    self.openCardView = [[UIView alloc] init];
    [self.openCardScrollView addSubview:self.openCardView];
    // 添加回收键盘的手势
    UITapGestureRecognizer *openCardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCardTapAction:)];
    [self.openCardScrollView addGestureRecognizer:openCardTap];
    /** 卡信息 */
    self.cardInfoView = [[OpenCardInfoView alloc] init];
    [self.openCardView addSubview:self.cardInfoView];
    /** 手机号view */
    self.phoneView = [[UsedCellView alloc] init];
    self.phoneView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.phoneView.arrowImage setImage:[UIImage imageNamed:@"custom_open_card_user_choice"] forState:UIControlStateNormal];
    self.phoneView.arrowImage.tag = PhoneBtnAction;
    self.phoneView.cellLabel.text = @"手机";
    self.phoneView.cellLabel.font = FifteenTypeface;
    self.phoneView.cellLabel.textColor = GrayH1;
    self.phoneView.viceTextFiled.placeholder = @"请输入手机号";
    self.phoneView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.phoneView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.phoneView.viceTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.phoneView.viceTextFiled.textColor = Black;
    self.phoneView.viceTextFiled.font = FourteenTypeface;
    self.phoneView.isCellImage = YES;
    self.phoneView.isCellBtn = YES;
    self.phoneView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.openCardView addSubview:self.phoneView];
    /** 手机号必填标记 */
    self.phoneSign = [[UIImageView alloc] init];
    self.phoneSign.image = [UIImage imageNamed:@"required_marking"];
    [self.phoneView addSubview:self.phoneSign];
    
    /** 车牌号view */
    self.plnView = [[UsedCellView alloc] init];
    self.plnView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.plnView.arrowImage setImage:[UIImage imageNamed:@"custom_open_card_scan"] forState:UIControlStateNormal];
    self.plnView.arrowImage.tag = PlnBtnAction;
    self.plnView.cellLabel.text = @"车牌号";
    self.plnView.cellLabel.font = FifteenTypeface;
    self.plnView.cellLabel.textColor = GrayH1;
    self.plnView.viceTextFiled.placeholder = @"请输入车牌号";
    self.plnView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.plnView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.plnView.viceTextFiled.textColor = Black;
    self.plnView.viceTextFiled.font = FourteenTypeface;
    self.plnView.dividingLineChoice = DividingLineFullScreenLayout;
    self.plnView.isCellImage = YES;
    self.plnView.isCellBtn = YES;
    [self.openCardView addSubview:self.plnView];
    /** 用户名view */
    self.userNameView = [[UsedCellView alloc] init];
    self.userNameView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.userNameView.cellLabel.text = @"姓名";
    self.userNameView.cellLabel.font = FifteenTypeface;
    self.userNameView.cellLabel.textColor = GrayH1;
    self.userNameView.viceTextFiled.placeholder = @"请输入姓名";
    self.userNameView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.userNameView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.userNameView.viceTextFiled.textColor = Black;
    self.userNameView.viceTextFiled.font = FourteenTypeface;
    self.userNameView.dividingLineChoice = DividingLineFullScreenLayout;
    self.userNameView.isCellImage = YES;
    self.userNameView.isArrow = YES;
    self.userNameView.isCellBtn = YES;
    [self.openCardView addSubview:self.userNameView];
    /** 售价view */
    self.priceView = [[UsedCellView alloc] init];
    self.priceView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.priceView.cellLabel.text = @"售价";
    self.priceView.cellLabel.font = FifteenTypeface;
    self.priceView.cellLabel.textColor = GrayH1;
    self.priceView.viceTextFiled.placeholder = @"请输入售价";
    self.priceView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.priceView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.priceView.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.priceView.viceTextFiled.textColor = Black;
    self.priceView.viceTextFiled.font = FourteenTypeface;
    self.priceView.isArrow = YES;
    self.priceView.isCellImage = YES;
    self.priceView.isSplistLine = YES;
    self.priceView.isCellBtn = YES;
    [self.openCardView addSubview:self.priceView];
    /** 售价必填标记 */
    self.priceSign = [[UIImageView alloc] init];
    self.priceSign.image = [UIImage imageNamed:@"required_marking"];
    [self.priceView addSubview:self.priceSign];
    
    /** 销售员view */
    self.salespersonView = [[UsedCellView alloc] init];
    self.salespersonView.cellLabel.text = @"销售员";
    self.salespersonView.cellLabel.font = FifteenTypeface;
    self.salespersonView.cellLabel.textColor = GrayH1;
    self.salespersonView.describeLabel.font = ThirteenTypeface;
    self.salespersonView.describeLabel.textColor = Black;
    self.salespersonView.isSplistLine = YES;
    self.salespersonView.isCellImage = YES;
    self.salespersonView.usedCellBtn.tag = SalespersonBtnAction;
    [self.openCardView addSubview:self.salespersonView];
    /** 赠品view */
    self.premiumView = [[UIView alloc] init];
    self.premiumView.backgroundColor = WhiteColor;
    [self.openCardView addSubview:self.premiumView];
    
    self.premiumTitleLabel = [[UILabel alloc] init];
    self.premiumTitleLabel.text = @"赠品";
    self.premiumTitleLabel.textColor = GrayH1;
    self.premiumTitleLabel.font = FifteenTypeface;
    [self.premiumView addSubview:self.premiumTitleLabel];
    
    self.premiumContentLabel = [[UILabel alloc] init];
    self.premiumContentLabel.textColor = GrayH2;
    self.premiumContentLabel.font = ThirteenTypeface;
    self.premiumContentLabel.textAlignment = NSTextAlignmentRight;
    self.premiumContentLabel.text = @"无";
    self.premiumContentLabel.numberOfLines = 0;
    [self.premiumView addSubview:self.premiumContentLabel];
    
    self.arrowImage = [[UIImageView alloc] init];
    self.arrowImage.image = [UIImage imageNamed:@"right_arrow"];
    [self.premiumView addSubview:self.arrowImage];
    
    self.premiumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.premiumBtn.tag = PremiumBtnAction;
    [self.premiumView addSubview:self.premiumBtn];
    /** 确认开卡 */
    self.confirOpenCardView = [[UIView alloc] init];
    self.confirOpenCardView.backgroundColor = WhiteColor;
    [self addSubview:self.confirOpenCardView];
    
    self.confirOpenCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirOpenCardBtn setTitle:@"确认开卡" forState:UIControlStateNormal];
    self.confirOpenCardBtn.titleLabel.font = SixteenTypeface;
    self.confirOpenCardBtn.titleLabel.textColor = WhiteColor;
    self.confirOpenCardBtn.backgroundColor = ThemeColor;
    self.confirOpenCardBtn.layer.masksToBounds = YES;
    self.confirOpenCardBtn.layer.cornerRadius = 2;
    self.confirOpenCardBtn.tag = ConfirOpenCardBtnAction;
    [self.confirOpenCardView addSubview:self.confirOpenCardBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 确认开卡 */
    [self.confirOpenCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    [self.confirOpenCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.confirOpenCardView.mas_left).offset(16);
        make.right.equalTo(self.confirOpenCardView.mas_right).offset(-16);
        make.centerY.equalTo(self.confirOpenCardView.mas_centerY);
        make.height.mas_equalTo(@40);
    }];
    /** 背景scrollview */
    [self.openCardScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.confirOpenCardView.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.openCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.openCardScrollView.mas_top);
        make.left.equalTo(self.openCardScrollView.mas_left);
        make.bottom.equalTo(self.openCardScrollView.mas_bottom);
        make.right.equalTo(self.openCardScrollView.mas_right);
        make.width.equalTo(self.openCardScrollView.mas_width);
    }];
    
    /** 卡信息 */
    [self.cardInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.openCardView.mas_top);
        make.left.equalTo(self.openCardView.mas_left);
        make.right.equalTo(self.openCardView.mas_right);
        make.bottom.equalTo(self.cardInfoView.canNumMoneyLabel.mas_bottom).offset(16);
    }];
    /** 手机号view */
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardInfoView.mas_bottom).offset(10);
        make.left.equalTo(self.openCardView.mas_left);
        make.right.equalTo(self.openCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 手机号必填标记 */
    [self.phoneSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.phoneView.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.phoneView.cellLabel.mas_centerY);
    }];
    
    /** 车牌号view */
    [self.plnView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.phoneView.mas_bottom);
        make.left.equalTo(self.openCardView.mas_left);
        make.right.equalTo(self.openCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 用户名view */
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnView.mas_bottom);
        make.left.equalTo(self.openCardView.mas_left);
        make.right.equalTo(self.openCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 售价view */
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userNameView.mas_bottom);
        make.left.equalTo(self.openCardView.mas_left);
        make.right.equalTo(self.openCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 售价必填标记 */
    [self.priceSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.priceView.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.priceView.cellLabel.mas_centerY);
    }];
    
    /** 销售员view */
    [self.salespersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.priceView.mas_bottom).offset(10);
        make.left.equalTo(self.openCardView.mas_left);
        make.right.equalTo(self.openCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 赠品view */
    [self.premiumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.salespersonView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.premiumContentLabel.mas_bottom).offset(18);
    }];
    [self.premiumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.premiumView.mas_top).offset(16);
        make.left.equalTo(self.premiumView.mas_left).offset(16);
        make.width.mas_equalTo(@61.5);
    }];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.premiumTitleLabel.mas_centerY);
        make.right.equalTo(self.premiumView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self.premiumContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.premiumTitleLabel.mas_top).offset(2);
        make.left.equalTo(self.premiumTitleLabel.mas_right).offset(28);
        make.right.equalTo(self.arrowImage.mas_left).offset(-16);
    }];
    [self.premiumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.premiumView.mas_top);
        make.left.equalTo(self.premiumView.mas_left);
        make.right.equalTo(self.premiumView.mas_right);
        make.bottom.equalTo(self.premiumView.mas_bottom);
    }];
    /** 填充scrollview的view的高度 */
    [self.openCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.premiumView.mas_bottom).offset(20);
    }];
}

#pragma mark - 回收键盘的方法
- (void)openCardTapAction:(UIButton *)button {
    [self endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}


@end
