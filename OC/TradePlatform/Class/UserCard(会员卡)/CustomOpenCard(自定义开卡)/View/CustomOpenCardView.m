//
//  CustomOpenCardView.m
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CustomOpenCardView.h"
#import "ZYKeyboardUtil.h"

@interface CustomOpenCardView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *customOpenCardScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *customOpenCardView;


/** 手机号必填标记 */
@property (strong, nonatomic) UIImageView *phoneSign;
/** 卡名称必填标记 */
@property (strong, nonatomic) UIImageView *cardNameSign;
/** 次数必填标记 */
@property (strong, nonatomic) UIImageView *numSign;
/** 售价必填标记 */
@property (strong, nonatomic) UIImageView *priceSign;
/** 可用服务view */
@property (strong, nonatomic) UIView *usableServiceView;
@property (strong, nonatomic) UILabel *usableServiceTitleLabel;
@property (strong, nonatomic) UIImageView *arrowImage;
/** 确认开卡 */
@property (strong, nonatomic) UIView *confirOpenCardView;
/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
/** 赠品 */
@property (strong, nonatomic) UIView *premiumView;
@property (strong, nonatomic) UILabel *premiumTitleLabel;
@property (strong, nonatomic) UIImageView *premiumArrowImage;


@end

@implementation CustomOpenCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self customOpenCardLayoutView];
        [self customOpenCardViewTextFieldSignal];
        // 操作键盘弹出
        self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
        @weakify(self)
        [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
            @strongify(self)
            [keyboardUtil adaptiveViewHandleWithAdaptiveView:self, nil];
        }];
    }
    return self;
}
#pragma mark - view布局
- (void)customOpenCardLayoutView {
    /** 背景scrollview */
    self.customOpenCardScrollView = [[UIScrollView alloc] init];
    [self addSubview:self.customOpenCardScrollView];
    /** 填充scrollview的view */
    self.customOpenCardView = [[UIView alloc] init];
    [self.customOpenCardScrollView addSubview:self.customOpenCardView];
    // 添加回收键盘的手势
    UITapGestureRecognizer *customOpenCardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customOpenCardTapAction:)];
    [self.customOpenCardScrollView addGestureRecognizer:customOpenCardTap];
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
    [self.customOpenCardView addSubview:self.phoneView];
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
    self.plnView.isCellImage = YES;
    self.plnView.isCellBtn = YES;
    self.plnView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.customOpenCardView addSubview:self.plnView];
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
    self.userNameView.isSplistLine = YES;
    self.userNameView.isCellImage = YES;
    self.userNameView.isArrow = YES;
    self.userNameView.isCellBtn = YES;
    [self.customOpenCardView addSubview:self.userNameView];
    /** 卡名称view */
    self.cardNameView = [[UsedCellView alloc] init];
    self.cardNameView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.cardNameView.arrowImage setImage:[UIImage imageNamed:@"custom_open_card_card_choice"] forState:UIControlStateNormal];
    self.cardNameView.arrowImage.tag = CardNameBtnAction;
    self.cardNameView.cellLabel.text = @"卡名称";
    self.cardNameView.cellLabel.font = FifteenTypeface;
    self.cardNameView.cellLabel.textColor = GrayH1;
    self.cardNameView.viceTextFiled.placeholder = @"请输入卡名称";
    self.cardNameView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.cardNameView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.cardNameView.viceTextFiled.textColor = Black;
    self.cardNameView.viceTextFiled.font = FourteenTypeface;
    self.cardNameView.isCellImage = YES;
    self.cardNameView.isCellBtn = YES;
    self.cardNameView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.customOpenCardView addSubview:self.cardNameView];
    /** 卡名称必填标记 */
    self.cardNameSign = [[UIImageView alloc] init];
    self.cardNameSign.image = [UIImage imageNamed:@"required_marking"];
    [self.cardNameView addSubview:self.cardNameSign];
    
    /** 卡类型view */
    self.cardTypeView = [[UsedCellView alloc] init];
    self.cardTypeView.cellLabel.text = @"卡类型";
    self.cardTypeView.cellLabel.font = FifteenTypeface;
    self.cardTypeView.cellLabel.textColor = GrayH1;
    self.cardTypeView.describeLabel.font = ThirteenTypeface;
    self.cardTypeView.describeLabel.textColor = Black;
    self.cardTypeView.usedCellBtn.tag = CardTypeBtnAction;
    self.cardTypeView.isCellImage = YES;
    self.cardTypeView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.customOpenCardView addSubview:self.cardTypeView];
    /** 次数view */
    self.numView = [[UsedCellView alloc] init];
    self.numView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.numView.cellLabel.text = @"次数";
    self.numView.cellLabel.font = FifteenTypeface;
    self.numView.cellLabel.textColor = GrayH1;
    self.numView.viceTextFiled.placeholder = @"请输入卡的初始次数";
    self.numView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.numView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.numView.viceTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.numView.viceTextFiled.textColor = Black;
    self.numView.viceTextFiled.font = FourteenTypeface;
    self.numView.isArrow = YES;
    self.numView.isCellImage = YES;
    self.numView.isCellBtn = YES;
    self.numView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.customOpenCardView addSubview:self.numView];
    /** 次数必填标记 */
    self.numSign = [[UIImageView alloc] init];
    self.numSign.image = [UIImage imageNamed:@"required_marking"];
    [self.numView addSubview:self.numSign];

    /** 可用服务view */
    self.usableServiceView = [[UIView alloc] init];
    self.usableServiceView.backgroundColor = WhiteColor;
    [self.customOpenCardView addSubview:self.usableServiceView];
    
    self.usableServiceTitleLabel = [[UILabel alloc] init];
    self.usableServiceTitleLabel.text = @"可用服务";
    self.usableServiceTitleLabel.textColor = GrayH1;
    self.usableServiceTitleLabel.font = FifteenTypeface;
    [self.usableServiceView addSubview:self.usableServiceTitleLabel];
    
    self.usableServiceLabel = [[UILabel alloc] init];
    self.usableServiceLabel.textColor = Black;
    self.usableServiceLabel.font = ThirteenTypeface;
    self.usableServiceLabel.textAlignment = NSTextAlignmentRight;
    self.usableServiceLabel.text = @"全部服务";
    self.usableServiceLabel.numberOfLines = 0;
    [self.usableServiceView addSubview:self.usableServiceLabel];
    
    self.arrowImage = [[UIImageView alloc] init];
    self.arrowImage.image = [UIImage imageNamed:@"right_arrow"];
    [self.usableServiceView addSubview:self.arrowImage];
    
    self.usableServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.usableServiceBtn.tag = UsableServiceBtnAction;
    [self.usableServiceView addSubview:self.usableServiceBtn];
    
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
    self.priceView.isCellBtn = YES;
    self.priceView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.customOpenCardView addSubview:self.priceView];
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
    [self.customOpenCardView addSubview:self.salespersonView];
    /** 赠品view */
    self.premiumView = [[UIView alloc] init];
    self.premiumView.backgroundColor = WhiteColor;
    [self.customOpenCardView addSubview:self.premiumView];
    
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
    
    self.premiumArrowImage = [[UIImageView alloc] init];
    self.premiumArrowImage.image = [UIImage imageNamed:@"right_arrow"];
    [self.premiumView addSubview:self.premiumArrowImage];
    
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
    [self.customOpenCardScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.confirOpenCardView.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.customOpenCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.customOpenCardScrollView.mas_top);
        make.left.equalTo(self.customOpenCardScrollView.mas_left);
        make.bottom.equalTo(self.customOpenCardScrollView.mas_bottom);
        make.right.equalTo(self.customOpenCardScrollView.mas_right);
        make.width.equalTo(self.customOpenCardScrollView.mas_width);
    }];
    
    /** 手机号view */
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.customOpenCardView.mas_top);
        make.left.equalTo(self.customOpenCardView.mas_left);
        make.right.equalTo(self.customOpenCardView.mas_right);
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
        make.left.equalTo(self.customOpenCardView.mas_left);
        make.right.equalTo(self.customOpenCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 用户名view */
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnView.mas_bottom);
        make.left.equalTo(self.customOpenCardView.mas_left);
        make.right.equalTo(self.customOpenCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 卡名称view */
    [self.cardNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userNameView.mas_bottom).offset(10);
        make.left.equalTo(self.customOpenCardView.mas_left);
        make.right.equalTo(self.customOpenCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 卡名称必填标记 */
    [self.cardNameSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cardNameView.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.cardNameView.cellLabel.mas_centerY);
    }];
    
    /** 卡类型view */
    [self.cardTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardNameView.mas_bottom);
        make.left.equalTo(self.customOpenCardView.mas_left);
        make.right.equalTo(self.customOpenCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 次数view */
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cardTypeView.mas_bottom);
        make.left.equalTo(self.customOpenCardView.mas_left);
        make.right.equalTo(self.customOpenCardView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 次数必填标记 */
    [self.numSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.numView.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.numView.cellLabel.mas_centerY);
    }];
    
    /** 可用服务view */
    [self.usableServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.numView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.usableServiceLabel.mas_bottom).offset(18);
    }];
    [self.usableServiceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usableServiceView.mas_top).offset(16);
        make.left.equalTo(self.usableServiceView.mas_left).offset(16);
        make.width.mas_equalTo(@61.5);
    }];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.usableServiceTitleLabel.mas_centerY);
        make.right.equalTo(self.usableServiceView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    [self.usableServiceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usableServiceTitleLabel.mas_top).offset(2);
        make.left.equalTo(self.usableServiceTitleLabel.mas_right).offset(28);
        make.right.equalTo(self.arrowImage.mas_left).offset(-16);
    }];
    [self.usableServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usableServiceView.mas_top);
        make.left.equalTo(self.usableServiceView.mas_left);
        make.right.equalTo(self.usableServiceView.mas_right);
        make.bottom.equalTo(self.usableServiceView.mas_bottom);
    }];

    /** 售价view */
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usableServiceView.mas_bottom).offset(10);
        make.left.equalTo(self.customOpenCardView.mas_left);
        make.right.equalTo(self.customOpenCardView.mas_right);
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
        make.top.equalTo(self.priceView.mas_bottom);
        make.left.equalTo(self.customOpenCardView.mas_left);
        make.right.equalTo(self.customOpenCardView.mas_right);
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
    
    [self.premiumArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [self.customOpenCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.premiumView.mas_bottom).offset(20);
    }];
    
}

#pragma mark - 输入框响应
- (void)customOpenCardViewTextFieldSignal {
    // 获取手机号signal
    RACSignal *phoneSignal = self.phoneView.viceTextFiled.rac_textSignal;
    // 判断账户输入框输入位数
    RACSignal *phoneNum = [phoneSignal map:^id(NSString *text) {
        return @(text.length > 10);
    }];
    // 限制账号输入框可输入位数
    RAC(self.phoneView.viceTextFiled, text) =
    [phoneNum map:^id(NSNumber *phoneNumberTF){
        return [phoneNumberTF boolValue] ? [self.phoneView.viceTextFiled.text substringToIndex:11] : self.phoneView.viceTextFiled.text;
    }];
    RACSignal *phoneType = [phoneSignal map:^id(NSString *text) {
        return @([CustomObject checkTel:text]);
    }];
    
    
    // 获取卡名称signal
    RACSignal *cardNameSignal = self.cardNameView.viceTextFiled.rac_textSignal;
    // 判断卡名称输入框输入位数
    RACSignal *cardNameMinSig = [cardNameSignal map:^id(NSString *text) {
        return @(text.length > 0);
    }];
    
    // 获取次数signal
    RACSignal *numSignal = self.numView.viceTextFiled.rac_textSignal;
    // 判断次数输入框输入位数
    RACSignal *numMinSig = [numSignal map:^id(NSString *text) {
        return @([text integerValue] > 0);
    }];
    
    
    // 获取售价signal
    RACSignal *priceSignal = self.priceView.viceTextFiled.rac_textSignal;
    // 判断售价输入框输入位数
    RACSignal *priceMinSig = [priceSignal map:^id(NSString *text) {
        return @([text integerValue] > 0);
    }];
    // 聚合以上信息
    self.aggregationInfo = [RACSignal combineLatest:@[phoneType, cardNameMinSig, numMinSig, priceMinSig]
                                                   reduce:^id(NSNumber *phoneType, NSNumber *cardNameMinSig, NSNumber *numMinSig, NSNumber *priceMinSig){
                                                       return @([phoneType boolValue]&&[cardNameMinSig boolValue]&&[numMinSig boolValue]&&[priceMinSig boolValue]);
                                                   }];
}



#pragma mark - 回收键盘的方法
- (void)customOpenCardTapAction:(UIButton *)button {
    [self endEditing:YES];
}


@end
