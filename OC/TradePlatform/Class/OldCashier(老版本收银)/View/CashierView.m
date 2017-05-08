//
//  CashierView.m
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierView.h"
#import "QueryPromptView.h"
#import "ZYKeyboardUtil.h"

@interface CashierView ()<UIScrollViewDelegate>

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *cashierScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *cashierView;

/** 用户信息点击箭头 */
@property (strong, nonatomic) UIImageView *userInfoArrow;

/** 数量view */
@property (strong, nonatomic) UIView *numberView;
@property (strong, nonatomic) UILabel *numberTitleLabel;
/** 确认收款view */
@property (strong, nonatomic) UIView *confirmationCollectionView;

/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@end

@implementation CashierView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cashierViewLayoutView];
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
#pragma mark - 回收键盘
- (void)cashierTapAction {
    [self endEditing:YES];
    // 创建查询提示view
    [self establishQueryPromptView];
}

#pragma mark - view布局
- (void)cashierViewLayoutView {
    /** 背景scrollview */
    self.cashierScrollView = [[UIScrollView alloc] init];
    self.cashierScrollView.backgroundColor = VCBackground;
    self.cashierScrollView.delegate = self;
    [self addSubview:self.cashierScrollView];
    /** 填充scrollview的view */
    self.cashierView = [[UIView alloc] init];
    self.cashierView.backgroundColor = VCBackground;
    [self.cashierScrollView addSubview:self.cashierView];
    UITapGestureRecognizer *cashierTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cashierTapAction)];
    [self.cashierView addGestureRecognizer:cashierTap];

    /** 输入框view */
    self.textFieldView = [[UIView alloc] init];
    self.textFieldView.backgroundColor = WhiteColor;
    [self.cashierView addSubview:self.textFieldView];

    self.queryTF = [[UITextField alloc] init];
    self.queryTF.placeholder = @"请输入手机号／车牌号";
    self.queryTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.queryTF.font = FifteenTypeface;
    self.queryTF.textColor = Black;
    [self.queryTF setValue:RGB(187, 187, 187) forKeyPath:@"_placeholderLabel.textColor"];
    [self.queryTF setValue:FifteenTypeface forKeyPath:@"_placeholderLabel.font"];
    [self.textFieldView addSubview:self.queryTF];

    self.queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.queryBtn setImage:[UIImage imageNamed:@"cashier_user_query"] forState:UIControlStateNormal];
    self.queryBtn.tag = QueryUserBtnAction;
    [self.textFieldView addSubview:self.queryBtn];
    /** 用户信息不完善 */
    self.noPerfectUserInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.noPerfectUserInfoBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.noPerfectUserInfoBtn.titleLabel.font = TwelveTypeface;
    [self.noPerfectUserInfoBtn setImage:[UIImage imageNamed:@"cashier_perfect_user_Info"] forState:UIControlStateNormal];
    [self.noPerfectUserInfoBtn setTitle:@"用户信息不完善，请在收款后完善用户信息" forState:UIControlStateNormal];
    self.noPerfectUserInfoBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.noPerfectUserInfoBtn.tag = NoPerfectUserInfoBtnAction;
    self.noPerfectUserInfoBtn.backgroundColor = WhiteColor;
    [self.cashierView addSubview:self.noPerfectUserInfoBtn];
    /** 用户信息view */
    self.userInfoView = [[UIView alloc] init];
    self.userInfoView.backgroundColor = WhiteColor;
    [self.cashierView addSubview:self.userInfoView];
    /** 用户信息点击箭头 */
    self.userInfoArrow = [[UIImageView alloc] init];
    self.userInfoArrow.image = [UIImage imageNamed:@"right_arrow"];
    [self.userInfoView addSubview:self.userInfoArrow];
    /** 姓名 */
    self.userNameLabel = [[leftRigText alloc] init];
    self.userNameLabel.leftText.text = @"姓 名：";
    self.userNameLabel.leftText.textColor = GrayH1;
    self.userNameLabel.leftText.font = TwelveTypeface;
    self.userNameLabel.rightText.font = TwelveTypeface;
    self.userNameLabel.rightText.textColor = GrayH1;
    [self.userInfoView addSubview:self.userNameLabel];
    /** 车牌号  */
    self.userPlnLabel = [[leftRigText alloc] init];
    self.userPlnLabel.leftText.text = @"车牌号：";
    self.userPlnLabel.leftText.textColor = GrayH1;
    self.userPlnLabel.leftText.font = TwelveTypeface;
    self.userPlnLabel.rightText.font = TwelveTypeface;
    self.userPlnLabel.rightText.textColor = GrayH1;
    [self.userInfoView addSubview:self.userPlnLabel];
    /** 手机号 */
    self.userPhoneLabel = [[leftRigText alloc] init];
    self.userPhoneLabel.leftText.text = @"手机号：";
    self.userPhoneLabel.leftText.textColor = GrayH1;
    self.userPhoneLabel.leftText.font = TwelveTypeface;
    self.userPhoneLabel.rightText.font = TwelveTypeface;
    self.userPhoneLabel.rightText.textColor = GrayH1;
    [self.userInfoView addSubview:self.userPhoneLabel];
    /** 用户信息完善 */
    self.perfectUserInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.perfectUserInfoBtn.tag = PerfectUserInfoBtnAction;
    [self.userInfoView addSubview:self.perfectUserInfoBtn];
    
    /** 类别view */
    self.classView = [[UsedCellView alloc] init];
    self.classView.backgroundColor = WhiteColor;
    self.classView.cellLabel.text = @"类别";
    self.classView.cellLabel.textColor = GrayH1;
    self.classView.cellLabel.font = FourteenTypeface;
    self.classView.describeLabel.font = FourteenTypeface;
    self.classView.describeLabel.text = @"请选择类别";
    self.classView.describeLabel.textColor = Black;
    self.classView.isSplistLine = YES;
    self.classView.isCellImage = YES;
    self.classView.usedCellBtn.tag = ClassBtnAction;
    [self.cashierView addSubview:self.classView];
    /** 服务view */
    self.serviceView = [[UsedCellView alloc] init];
    self.serviceView.backgroundColor = WhiteColor;
    self.serviceView.cellLabel.text = @"服务";
    self.serviceView.cellLabel.textColor = GrayH1;
    self.serviceView.cellLabel.font = FourteenTypeface;
    self.serviceView.describeLabel.font = FourteenTypeface;
    self.serviceView.describeLabel.text = @"请选择服务";
    self.serviceView.describeLabel.textColor = Black;
    self.serviceView.isSplistLine = YES;
    self.serviceView.isCellImage = YES;
    self.serviceView.usedCellBtn.tag = ServiceBtnAction;
    [self.cashierView addSubview:self.serviceView];
    /** 数量view */
    self.numberView = [[UIView alloc] init];
    self.numberView.backgroundColor = WhiteColor;
    [self.cashierView addSubview:self.numberView];

    self.numberTitleLabel = [[UILabel alloc] init];
    self.numberTitleLabel.text = @"数量";
    self.numberTitleLabel.textColor = GrayH1;
    self.numberTitleLabel.font = FourteenTypeface;
    [self.numberView addSubview:self.numberTitleLabel];
    /** 数量操作 */
    self.numberOperationBtn = [[AddSubNumView alloc] init];
    [self.numberView addSubview:self.numberOperationBtn];
    
    /** 服务师傅view */
    self.serviceMasterView = [[UsedCellView alloc] init];
    self.serviceMasterView.backgroundColor = WhiteColor;
    self.serviceMasterView.cellLabel.text = @"服务师傅";
    self.serviceMasterView.cellLabel.textColor = GrayH1;
    self.serviceMasterView.cellLabel.font = FourteenTypeface;
    self.serviceMasterView.describeLabel.font = FourteenTypeface;
    self.serviceMasterView.describeLabel.text = @"请选择服务师傅";
    self.serviceMasterView.describeLabel.textColor = Black;
    self.serviceMasterView.isSplistLine = YES;
    self.serviceMasterView.isCellImage = YES;
    self.serviceMasterView.usedCellBtn.tag = ServiceMasterBtnAction;
    [self.cashierView addSubview:self.serviceMasterView];
    /** 总价view */
    self.priceView = [[UsedCellView alloc] init];
    self.priceView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.priceView.backgroundColor = WhiteColor;
    self.priceView.cellLabel.text = @"总价（元）";
    self.priceView.cellLabel.textColor = GrayH1;
    self.priceView.cellLabel.font = FourteenTypeface;
    self.priceView.viceTextFiled.font = FourteenTypeface;
    self.priceView.viceTextFiled.textColor = HEXSTR_RGB(@"45c018");
    self.priceView.viceTextFiled.textAlignment = NSTextAlignmentRight;
    self.priceView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.priceView.isSplistLine = YES;
    self.priceView.isCellImage = YES;
    self.priceView.usedCellBtn.tag = PriceBtnAction;
    [self.cashierView addSubview:self.priceView];
    /** 确认收款view */
    self.confirmationCollectionView = [[UIView alloc] init];
    self.confirmationCollectionView.backgroundColor = WhiteColor;
    [self addSubview:self.confirmationCollectionView];
    
    self.confirmationCollectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmationCollectionBtn setTitle:@"确认收款" forState:UIControlStateNormal];
    self.confirmationCollectionBtn.titleLabel.font = SixteenTypeface;
    self.confirmationCollectionBtn.titleLabel.textColor = WhiteColor;
    self.confirmationCollectionBtn.backgroundColor = ThemeColor;
    self.confirmationCollectionBtn.layer.masksToBounds = YES;
    self.confirmationCollectionBtn.layer.cornerRadius = 2;
    self.confirmationCollectionBtn.tag = ConfirmationCollectionBtnAction;
    [self.confirmationCollectionView addSubview:self.confirmationCollectionBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 确认收款view */
    [self.confirmationCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    
    [self.confirmationCollectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.confirmationCollectionView.mas_left).offset(16);
        make.right.equalTo(self.confirmationCollectionView.mas_right).offset(-16);
        make.centerY.equalTo(self.confirmationCollectionView.mas_centerY);
        make.height.mas_equalTo(@40);
    }];
    /** 背景scrollview */
    [self.cashierScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.confirmationCollectionView.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.cashierView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cashierScrollView.mas_top);
        make.left.equalTo(self.cashierScrollView.mas_left);
        make.bottom.equalTo(self.cashierScrollView.mas_bottom);
        make.right.equalTo(self.cashierScrollView.mas_right);
        make.width.equalTo(self.cashierScrollView.mas_width);
    }];
    
    /** 输入框view */
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.cashierView.mas_top).offset(10);
        make.height.mas_equalTo(@50);
    }];

    [self.queryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.textFieldView.mas_right).offset(-16);
        make.centerY.equalTo(self.textFieldView.mas_centerY);
    }];
    
    [self.queryTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.textFieldView.mas_left).offset(16);
        make.right.equalTo(self.queryBtn.mas_left).offset(-16);
        make.top.equalTo(self.textFieldView.mas_top);
        make.bottom.equalTo(self.textFieldView.mas_bottom);
    }];

    /** 用户信息不完善 */
    [self.noPerfectUserInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.textFieldView.mas_bottom).offset(0.5);
    }];
    /** 用户信息完善 */
    [self.perfectUserInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.textFieldView.mas_bottom).offset(0.5);
    }];
    /** 用户信息view */
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.textFieldView.mas_bottom).offset(0.5);
    }];
    /** 用户信息点击箭头 */
    [self.userInfoArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.userInfoView.mas_centerY);
        make.right.equalTo(self.userInfoView.mas_right).offset(-16);
    }];
    /** 姓名 */
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userInfoView.mas_top).offset(24);
        make.left.equalTo(self.userInfoView.mas_left).offset(16);
        make.right.equalTo(self.userNameLabel.rightText.mas_right);
        make.bottom.equalTo(self.userNameLabel.rightText.mas_bottom);
    }];
    /** 手机号 */
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(20);
        make.left.equalTo(self.userInfoView.mas_left).offset(16);
        make.right.equalTo(self.userPhoneLabel.rightText.mas_right);
        make.bottom.equalTo(self.userPhoneLabel.rightText.mas_bottom);
    }];
    /** 车牌号  */
    [self.userPlnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userInfoView.mas_top).offset(24);
        make.left.equalTo(self.userInfoView.mas_centerX);
        make.right.equalTo(self.userPlnLabel.rightText.mas_right);
        make.bottom.equalTo(self.userPlnLabel.rightText.mas_bottom);
    }];
    /** 用户信息完善，用户信息不完善， 用户信息view高 */
    [@[self.perfectUserInfoBtn, self.noPerfectUserInfoBtn, self.userInfoView] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.userPhoneLabel.mas_bottom).offset(24);
    }];
    
    /** 类别view */
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.userInfoView.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 服务view */
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.classView.mas_bottom).offset(0.5);
        make.height.mas_equalTo(@50);
    }];
    /** 数量view */
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.serviceView.mas_bottom).offset(0.5);
        make.height.mas_equalTo(@50);
    }];
    [self.numberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.numberView.mas_left).offset(16);
        make.centerY.equalTo(self.numberView.mas_centerY);
    }];
    /** 数量操作 */
    [self.numberOperationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.numberView.mas_right).offset(-16);
        make.centerY.equalTo(self.numberView.mas_centerY);
    }];
    
    /** 服务师傅view */
    [self.serviceMasterView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.numberView.mas_bottom).offset(0.5);
        make.height.mas_equalTo(@50);
    }];
    /** 总价view */
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.serviceMasterView.mas_bottom).offset(0.5);
        make.height.mas_equalTo(@50);
    }];
    /** 填充scrollview的view的高度 */
    [self.cashierView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.priceView.mas_bottom).offset(100);
    }];
}

#pragma mark - 自定义方法
// 创建查询提示view
- (void)establishQueryPromptView {
    // 判断搜索框输入手机号格式限制或搜索框输入车牌号格式限制
    if (self.queryTF.text.length != 0 && ![CustomObject checkTel:self.queryTF.text] && ![CustomObject isPlnNumber:self.queryTF.text]) {
        // 修改textfield文字颜色
        self.queryTF.textColor = HEXSTR_RGB(@"ef5350");
        // 创建查询提示view
        QueryPromptView *queryPrompt = [[QueryPromptView alloc] init];
        queryPrompt.queryTF = self.queryTF;
        [self.cashierView addSubview:queryPrompt];
        @weakify(self)
        [queryPrompt mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.textFieldView.mas_bottom).offset(-5);
            make.left.equalTo(self.cashierView.mas_left).offset(16);
        }];
    }
}

@end
