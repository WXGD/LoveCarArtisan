//
//  CashierView.m
//  TradePlatform
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashierView.h"
#import "ZYKeyboardUtil.h"
#import "UUInputAccessoryView.h"
// 省份简称键盘
#import "SelectProvinceView.h"
// 大写键盘
#import "CustomKeyboard.h"

@interface CashierView ()

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *cashierScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *cashierView;
/** 添加用户标题 */
@property (strong, nonatomic) UsedCellView *addUserTitleView;
/** 手机号view */
@property (strong, nonatomic) UIView *phoneView;
@property (strong, nonatomic) UILabel *phoneTitleLabel;
@property (strong, nonatomic) UIView *phoneLineView;
/** 车牌号view */
@property (strong, nonatomic) UIView *plnView;
@property (strong, nonatomic) UILabel *plnTitleLabel;
@property (strong, nonatomic) UIView *plnLineView;
/** 省份简称键盘 */
@property (strong, nonatomic) SelectProvinceView *selectProvince;
/** 添加服务标题 */
@property (strong, nonatomic) UsedCellView *addServiceTitleView;
/** 收款view */
@property (strong, nonatomic) UIView *collectionView;
/** 数量view */
@property (strong, nonatomic) UIView *numberView;
@property (strong, nonatomic) UILabel *numberTitleLabel;
@property (strong, nonatomic) UIView *numberLineView;
/** 购物车view */
@property (strong, nonatomic) UIView *shoppingCartView;
/** 购物车数量 */
@property (strong, nonatomic) UILabel *shoppingCartNumLabel;
/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
/** 其他信息标题 */
@property (strong, nonatomic) UsedCellView *otherTitleView;

@end

@implementation CashierView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cashierLayoutView];
        // 操作键盘弹出
        self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
        @weakify(self)
        [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
            @strongify(self)
            [keyboardUtil adaptiveViewHandleWithAdaptiveView:self, nil];
        }];
        // 省份简称通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(provinceBtnAction:) name:@"ProvinceBtnNotification" object:nil];
        // 大写键盘删除按钮
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customKeyboardDelete:) name:@"customKeyboardDelete" object:nil];
        // 大写键盘添加文字
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customKeyboardAddContent:) name:@"customKeyboardAddContent" object:nil];
        // 大写键盘下一步
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customKeyboardNextStep:) name:@"customKeyboardNextStep" object:nil];
    }
    return self;
}


#pragma mark - 按钮点击方法
// 销售价按钮点击
- (void)pretiumBtnAction:(UIButton *)button {
    [UUInputAccessoryView showKeyboardType:UIKeyboardTypeNumbersAndPunctuation content:self.pretiumView.viceLabel.text Block:^(NSString *contentStr) {
        if (contentStr.length == 0) return ;
        double pretium = [contentStr doubleValue];
        self.pretiumView.viceLabel.text = [NSString stringWithFormat:@"%.2f", pretium];
        if (_delegate && [_delegate respondsToSelector:@selector(editPretiumDelegate)]) {
            [_delegate editPretiumDelegate];
        }
    }];
}
// 下次保养时间点击
- (void)nextTimeBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minimumDate= [NSDate date];
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        self.nextTimeView.viceTextFiled.text = timestamp;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}
// 回收键盘
- (void)cashierTapAction {
    [self endEditing:YES];
}
// 省份简称按钮点击
- (void)caftaBtnAction:(UIButton *)button {
    [self endEditing:YES];
    self.selectProvince = [[SelectProvinceView alloc] init];
    [self.selectProvince show];
}
// 省份简称键盘点击
- (void)provinceBtnAction:(NSNotification *)province {
    [self.selectProvince dismiss];
    self.caftaBtn.titleLabel.text = province.userInfo[@"province"];
}
// 大写键盘通知
// 删除按钮
- (void)customKeyboardDelete:(NSNotification *)notification {
    [self.plnTF deleteBackward];
}
// 文本选中
- (void)customKeyboardAddContent:(NSNotification *)notification {
    [self.plnTF insertText:notification.userInfo[@"choiceBtnContent"]];
}
// 下一步
- (void)customKeyboardNextStep:(NSNotification *)notification {
    [self.superview endEditing:YES];
}

#pragma mark - 数据操作
/** 购物车数量操作 */
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
- (void)cashierLayoutView {
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
    [self.confirmationCollectionBtn setTitle:@"确认收银" forState:UIControlStateNormal];
    self.confirmationCollectionBtn.titleLabel.font = SixteenTypeface;
    self.confirmationCollectionBtn.titleLabel.textColor = WhiteColor;
    self.confirmationCollectionBtn.backgroundColor = ThemeColor;
    self.confirmationCollectionBtn.tag = ConfirmationCollectionBtnAction;
    [self.collectionView addSubview:self.confirmationCollectionBtn];
    /** 提交订单 */
    self.placeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.placeOrderBtn setTitle:@"暂不收银" forState:UIControlStateNormal];
    self.placeOrderBtn.titleLabel.font = SixteenTypeface;
    self.placeOrderBtn.titleLabel.textColor = WhiteColor;
    self.placeOrderBtn.backgroundColor = BlueColor;
    self.placeOrderBtn.tag = PlaceOrderBtnAction;
    [self.collectionView addSubview:self.placeOrderBtn];
    
    /** 背景scrollview */
    self.cashierScrollView = [[UIScrollView alloc] init];
    self.cashierScrollView.backgroundColor = VCBackground;
    [self addSubview:self.cashierScrollView];
    /** 填充scrollview的view */
    self.cashierView = [[UIView alloc] init];
    self.cashierView.backgroundColor = VCBackground;
    [self.cashierScrollView addSubview:self.cashierView];
    UITapGestureRecognizer *cashierTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cashierTapAction)];
    [self.cashierView addGestureRecognizer:cashierTap];
    /** 添加用户标题 */
    self.addUserTitleView = [[UsedCellView alloc] init];
    self.addUserTitleView.cellLabel.text = @"选择用户";
    self.addUserTitleView.cellLabel.font = FifteenTypeface;
    self.addUserTitleView.cellLabel.textColor = ThemeColor;
    self.addUserTitleView.isCellImage = YES;
    self.addUserTitleView.isArrow = YES;
    self.addUserTitleView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.cashierView addSubview:self.addUserTitleView];
    /** 手机号view */
    self.phoneView = [[UIView alloc] init];
    self.phoneView.backgroundColor = WhiteColor;
    [self.cashierView addSubview:self.phoneView];
    
    self.phoneLineView = [[UIView alloc] init];
    self.phoneLineView.backgroundColor = DividingLine;
    [self.phoneView addSubview:self.phoneLineView];
    
    self.phoneTitleLabel = [[UILabel alloc] init];
    self.phoneTitleLabel.text = @"手机号";
    self.phoneTitleLabel.font = FourteenTypeface;
    self.phoneTitleLabel.textColor = GrayH1;
    [self.phoneView addSubview:self.phoneTitleLabel];
    
    self.phoneTF = [[UITextField alloc] init];
    self.phoneTF.placeholder = @"请输入手机号";
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.phoneTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.phoneTF.font = FourteenTypeface;
    self.phoneTF.textColor = Black;
    [self.phoneView addSubview:self.phoneTF];
    
    self.phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.phoneBtn setImage:[UIImage imageNamed:@"cashier_user"] forState:UIControlStateNormal];
    self.phoneBtn.tag = PhoneBtnAction;
    [self.phoneView addSubview:self.phoneBtn];
    /** 车牌号view */
    self.plnView = [[UIView alloc] init];
    self.plnView.backgroundColor = WhiteColor;
    [self.cashierView addSubview:self.plnView];
    
    self.plnLineView = [[UIView alloc] init];
    self.plnLineView.backgroundColor = DividingLine;
    [self.plnView addSubview:self.plnLineView];
    
    self.plnTitleLabel = [[UILabel alloc] init];
    self.plnTitleLabel.text = @"车牌号";
    self.plnTitleLabel.font = FourteenTypeface;
    self.plnTitleLabel.textColor = GrayH1;
    [self.plnView addSubview:self.plnTitleLabel];
    
    self.caftaBtn = [[CaftaBtn alloc] init];
    self.caftaBtn.titleLabel.text = @"豫";
    self.caftaBtn.tag = CaftaBtnAction;
    [self.caftaBtn.caftaBtn addTarget:self action:@selector(caftaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.plnView addSubview:self.caftaBtn];
    
    self.plnTF = [[UITextField alloc] init];
    self.plnTF.placeholder = @"请输入车牌号";
    self.plnTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.plnTF setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.plnTF setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.plnTF.font = FourteenTypeface;
    self.plnTF.textColor = Black;
    [self.plnView addSubview:self.plnTF];
    
    // 自定义大写键盘
    CustomKeyboard *maskContent = [CustomKeyboard loadBlueViewFromXIB];
    // 注册使用大写键盘
    self.plnTF.inputView = maskContent;
    
    self.plnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.plnBtn setImage:[UIImage imageNamed:@"cashier_user_car"] forState:UIControlStateNormal];
    self.plnBtn.tag = PlnBtnAction;
    [self.plnView addSubview:self.plnBtn];
    /** 用户名 */
    self.userNameView = [[UsedCellView alloc] init];
    self.userNameView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.userNameView.cellLabel.text = @"用户名";
    self.userNameView.cellLabel.font = FourteenTypeface;
    self.userNameView.cellLabel.textColor = GrayH1;
    self.userNameView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.userNameView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.userNameView.viceTextFiled.font = FourteenTypeface;
    self.userNameView.viceTextFiled.textColor = Black;
    self.userNameView.isSplistLine = YES;
    self.userNameView.isCellImage = YES;
    self.userNameView.usedCellBtn.tag = UserNameBtnAction;
    [self.cashierView addSubview:self.userNameView];
    /** 添加服务标题 */
    self.addServiceTitleView = [[UsedCellView alloc] init];
    self.addServiceTitleView.cellLabel.text = @"选择服务";
    self.addServiceTitleView.cellLabel.font = FifteenTypeface;
    self.addServiceTitleView.cellLabel.textColor = ThemeColor;
    self.addServiceTitleView.isCellImage = YES;
    self.addServiceTitleView.isArrow = YES;
    self.addServiceTitleView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.cashierView addSubview:self.addServiceTitleView];
    /** 类别view */
    self.classView = [[UsedCellView alloc] init];
    self.classView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.classView.backgroundColor = WhiteColor;
    self.classView.cellLabel.text = @"类别";
    self.classView.cellLabel.textColor = GrayH1;
    self.classView.cellLabel.font = FourteenTypeface;
    self.classView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.classView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.classView.viceTextFiled.font = FourteenTypeface;
    self.classView.viceTextFiled.text = @"请选择类别";
    self.classView.viceTextFiled.textColor = Black;
    self.classView.isCellImage = YES;
    self.classView.usedCellBtn.tag = ClassBtnAction;
    self.classView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.cashierView addSubview:self.classView];
    /** 服务view */
    self.serviceView = [[UsedCellView alloc] init];
    self.serviceView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.serviceView.backgroundColor = WhiteColor;
    self.serviceView.cellLabel.text = @"服务";
    self.serviceView.cellLabel.textColor = GrayH1;
    self.serviceView.cellLabel.font = FourteenTypeface;
    self.serviceView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.serviceView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.serviceView.viceTextFiled.font = FourteenTypeface;
    self.serviceView.viceTextFiled.textColor = Black;
    self.serviceView.isCellImage = YES;
    self.serviceView.usedCellBtn.tag = ServiceBtnAction;
    self.serviceView.dividingLineChoice = DividingLineFullScreenLayout;
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
    self.numberLineView = [[UIView alloc] init];
    self.numberLineView.backgroundColor = DividingLine;
    [self.numberView addSubview:self.numberLineView];
    /** 数量操作 */
    self.numberOperationBtn = [[AddSubNumView alloc] init];
    [self.numberView addSubview:self.numberOperationBtn];
    /** 价格view */
    self.priceView = [[UsedCellView alloc] init];
    self.priceView.cellLabel.text = @"单价";
    self.priceView.cellLabel.textColor = GrayH1;
    self.priceView.cellLabel.font = FourteenTypeface;
    self.priceView.viceLabel.font = FourteenTypeface;
    self.priceView.viceLabel.textColor = Black;
    self.priceView.isCellImage = YES;
    self.priceView.isArrow = YES;
    self.priceView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.cashierView addSubview:self.priceView];
    /** 销售价view */
    self.pretiumView = [[UsedCellView alloc] init];
    self.pretiumView.cellLabel.text = @"成交单价";
    self.pretiumView.cellLabel.textColor = GrayH1;
    self.pretiumView.cellLabel.font = FourteenTypeface;
    self.pretiumView.viceLabel.font = FourteenTypeface;
    self.pretiumView.viceLabel.textColor = RedColor;
    self.pretiumView.describeLabel.text = @"元";
    self.pretiumView.describeLabel.font = FourteenTypeface;
    self.pretiumView.describeLabel.textColor = GrayH1;
    self.pretiumView.isCellImage = YES;
    self.pretiumView.isArrow = YES;
    self.pretiumView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.pretiumView.usedCellBtn addTarget:self action:@selector(pretiumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cashierView addSubview:self.pretiumView];
    /** 总价view */
    self.totalView = [[UsedCellView alloc] init];
    self.totalView.cellLabel.text = @"合计";
    self.totalView.cellLabel.textColor = GrayH1;
    self.totalView.cellLabel.font = FourteenTypeface;
    self.totalView.viceLabel.font = FourteenTypeface;
    self.totalView.viceLabel.textColor = Black;
    self.totalView.isCellImage = YES;
    self.totalView.isArrow = YES;
    self.totalView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.cashierView addSubview:self.totalView];
    /** 购物车view */
    self.shoppingCartView = [[UIView alloc] init];
    self.shoppingCartView.backgroundColor = WhiteColor;
    [self.cashierView addSubview:self.shoppingCartView];
    [self.shoppingCartView setHidden:YES];
    /** 添加商品 */
    self.addGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addGoodsBtn.backgroundColor = ThemeColor;
    [self.addGoodsBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.addGoodsBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.addGoodsBtn.titleLabel.font = SixteenTypeface;
    self.addGoodsBtn.layer.masksToBounds = YES;
    self.addGoodsBtn.layer.cornerRadius = 2;
    self.addGoodsBtn.tag = AddGoodsBtnAction;
    [self.shoppingCartView addSubview:self.addGoodsBtn];
    /** 其他信息标题 */
    self.otherTitleView = [[UsedCellView alloc] init];
    self.otherTitleView.cellLabel.text = @"其他信息";
    self.otherTitleView.cellLabel.font = FifteenTypeface;
    self.otherTitleView.cellLabel.textColor = ThemeColor;
    self.otherTitleView.isCellImage = YES;
    self.otherTitleView.isArrow = YES;
    self.otherTitleView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.cashierView addSubview:self.otherTitleView];
    /** 服务师傅view */
    self.serviceMasterView = [[UsedCellView alloc] init];
    self.serviceMasterView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.serviceMasterView.backgroundColor = WhiteColor;
    self.serviceMasterView.cellLabel.text = @"服务师傅";
    self.serviceMasterView.cellLabel.textColor = GrayH1;
    self.serviceMasterView.cellLabel.font = FourteenTypeface;
    self.serviceMasterView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.serviceMasterView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.serviceMasterView.viceTextFiled.font = FourteenTypeface;
    self.serviceMasterView.viceTextFiled.textColor = Black;
    self.serviceMasterView.isCellImage = YES;
    self.serviceMasterView.dividingLineChoice = DividingLineFullScreenLayout;
    self.serviceMasterView.usedCellBtn.tag = ServiceMasterBtnAction;
    [self.cashierView addSubview:self.serviceMasterView];
    /** 行驶里程 */
    self.mileageView = [[UsedCellView alloc] init];
    self.mileageView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.mileageView.cellLabel.text = @"行驶里程";
    self.mileageView.cellLabel.font = FourteenTypeface;
    self.mileageView.cellLabel.textColor = GrayH1;
    [self.mileageView.viceTextFiled setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.mileageView.viceTextFiled setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.mileageView.viceTextFiled.placeholder = @"请输入行驶里程";
    self.mileageView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.mileageView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.mileageView.viceTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.mileageView.viceTextFiled.textColor = Black;
    self.mileageView.viceTextFiled.font = FourteenTypeface;
    self.mileageView.isCellImage = YES;
    self.mileageView.isArrow = YES;
    self.mileageView.isCellBtn = YES;
    self.mileageView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.cashierView addSubview:self.mileageView];
    [self.mileageView setHidden:YES];
    /** 下次保养时间 */
    self.nextTimeView = [[UsedCellView alloc] init];
    self.nextTimeView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.nextTimeView.cellLabel.text = @"下次保养时间";
    self.nextTimeView.cellLabel.font = FourteenTypeface;
    self.nextTimeView.cellLabel.textColor = GrayH1;
    [self.nextTimeView.viceTextFiled setValue:GrayH4 forKeyPath:@"_placeholderLabel.textColor"];
    [self.nextTimeView.viceTextFiled setValue:FourteenTypeface forKeyPath:@"_placeholderLabel.font"];
    self.nextTimeView.viceTextFiled.placeholder = @"请选择下次保养时间";
    self.nextTimeView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.nextTimeView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.nextTimeView.viceTextFiled.font = FourteenTypeface;
    self.nextTimeView.viceTextFiled.textColor = Black;
    self.nextTimeView.isSplistLine = YES;
    self.nextTimeView.isCellImage = YES;
    [self.nextTimeView.usedCellBtn addTarget:self action:@selector(nextTimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cashierView addSubview:self.nextTimeView];
    [self.nextTimeView setHidden:YES];
    // 获取当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    self.nextTimeView.viceTextFiled.text = dateTime;
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
//        make.width.mas_equalTo(@70);
        make.width.mas_equalTo(@0);
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
        make.left.equalTo(self.collectionView.mas_centerX);
//        make.width.mas_equalTo(@125);
    }];
    /** 提交订单 */
    [self.placeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.shoppingCartBtn.mas_right);
        make.right.equalTo(self.confirmationCollectionBtn.mas_left);
        make.top.equalTo(self.collectionView.mas_top);
        make.bottom.equalTo(self.collectionView.mas_bottom);
    }];
    
    /** 背景scrollview */
    [self.cashierScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.collectionView.mas_top);
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
        make.bottom.equalTo(self.nextTimeView.mas_bottom);
    }];
    /** 添加用户标题 */
    [self.addUserTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cashierView.mas_top);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 手机号view */
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addUserTitleView.mas_bottom);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    [self.phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.phoneView.mas_centerY);
        make.left.equalTo(self.phoneView.mas_left).offset(16);
    }];
    [self.phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.phoneView.mas_bottom);
        make.left.equalTo(self.phoneView.mas_left);
        make.right.equalTo(self.phoneView.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.phoneView.mas_top);
        make.bottom.equalTo(self.phoneView.mas_bottom);
        make.right.equalTo(self.phoneView.mas_right);
    }];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.phoneView.mas_bottom);
        make.top.equalTo(self.phoneView.mas_top);
        make.left.equalTo(self.phoneView.mas_left).offset(115);
        make.right.equalTo(self.phoneBtn.mas_left).offset(10);
    }];
    /** 车牌号view */
    [self.plnView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.phoneView.mas_bottom);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    [self.plnLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.plnView.mas_bottom);
        make.left.equalTo(self.plnView.mas_left);
        make.right.equalTo(self.plnView.mas_right);
        make.height.mas_equalTo(@0.5);
    }];
    [self.plnTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnView.mas_centerY);
        make.left.equalTo(self.plnView.mas_left).offset(16);
    }];
    [self.caftaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnView.mas_top);
        make.bottom.equalTo(self.plnView.mas_bottom);
        make.left.equalTo(self.plnView.mas_left).offset(115);
    }];
    [self.plnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnView.mas_top);
        make.bottom.equalTo(self.plnView.mas_bottom);
        make.right.equalTo(self.plnView.mas_right);
    }];
    [self.plnTF mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.plnView.mas_bottom);
        make.top.equalTo(self.plnView.mas_top);
        make.left.equalTo(self.caftaBtn.mas_right).offset(16);
        make.right.equalTo(self.plnBtn.mas_left).offset(10);
    }];
    
    /** 用户名 */
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnView.mas_bottom);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 添加服务标题 */
    [self.addServiceTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.userNameView.mas_bottom).offset(10);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 类别view */
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.addServiceTitleView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 服务view */
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.classView.mas_bottom);
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
    [self.numberLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.numberView.mas_left);
        make.right.equalTo(self.numberView.mas_right);
        make.bottom.equalTo(self.numberView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
    /** 数量操作 */
    [self.numberOperationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.numberView.mas_left).offset(106);
        make.centerY.equalTo(self.numberView.mas_centerY);
    }];
    /** 价格view */
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_centerX);
        make.top.equalTo(self.numberOperationBtn.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 销售价view */
    [self.pretiumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_centerX);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.numberOperationBtn.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 总价view */
    [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.priceView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 购物车view */
    [self.shoppingCartView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.totalView.mas_bottom);
//        make.height.mas_equalTo(@60);
        make.height.mas_equalTo(@0);
    }];
//    /** 添加商品 */
//    [self.addGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self)
//        make.bottom.equalTo(self.shoppingCartView.mas_bottom).offset(-10);
//        make.top.equalTo(self.shoppingCartView.mas_top).offset(10);
//        make.left.equalTo(self.shoppingCartView.mas_left).offset(16);
//        make.right.equalTo(self.shoppingCartView.mas_right).offset(-16);
//    }];
    /** 其他信息标题 */
    [self.otherTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.shoppingCartView.mas_bottom).offset(10);
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.height.mas_equalTo(@40);
    }];
    /** 服务师傅view */
    [self.serviceMasterView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.otherTitleView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 行驶里程 */
    [self.mileageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.serviceMasterView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 下次保养时间 */
    [self.nextTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cashierView.mas_left);
        make.right.equalTo(self.cashierView.mas_right);
        make.top.equalTo(self.mileageView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
}



@end
