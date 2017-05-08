//
//  AddUserView.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddUserView.h"

@interface AddUserView ()
/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *addUserScrollView;
/** 填充scrollview的view */
@property (strong, nonatomic) UIView *addUserView;

/** 更多信息标题 */
@property (strong, nonatomic) UILabel *moreInfoTitle;
@property (strong, nonatomic) UILabel *moreInfoTitleSign;
/** 性别 */
@property (strong, nonatomic) UIView *addSexView;
@property (strong, nonatomic) UILabel *addSexLabel;
/** 老会员卡信息标题 */
@property (strong, nonatomic) UILabel *oldMembershipCardTitleLabel;
/** 手机号必填标记 */
@property (strong, nonatomic) UIImageView *phoneRequiredMarking;

@end

@implementation AddUserView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addUserLayoutView];
        // 输入框响应
        [self newAddCardTextFieldSignal];
    }
    return self;
}

/** 年卡卡值 */
- (void)kakaValueBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        self.kakaValueView.describeLabel.text = timestamp;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}

#pragma mark - 回收键盘
- (void)addUserTapAction {
    [self endEditing:YES];
}

- (void)addUserLayoutView {
    /** 背景scrollview */
    self.addUserScrollView = [[UIScrollView alloc] init];
    self.addUserScrollView.backgroundColor = VCBackground;
    [self addSubview:self.addUserScrollView];
    /** 填充scrollview的view */
    self.addUserView = [[UIView alloc] init];
    self.addUserView.backgroundColor = VCBackground;
    [self.addUserScrollView addSubview:self.addUserView];
    UITapGestureRecognizer *cashierTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addUserTapAction)];
    [self.addUserView addGestureRecognizer:cashierTap];
    [self.addUserScrollView addGestureRecognizer:cashierTap];

    /** 手机 */
    self.addPhone = [[UsedCellView alloc] init];
    self.addPhone.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.addPhone.cellLabel.text = @"手机";
    self.addPhone.cellLabel.font = FifteenTypeface;
    self.addPhone.cellLabel.textColor = GrayH1;
    self.addPhone.viceTextFiled.placeholder = @"请输入手机号";
    self.addPhone.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.addPhone.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.addPhone.viceTextFiled.keyboardType = UIKeyboardTypePhonePad;
    self.addPhone.viceTextFiled.textColor = Black;
    self.addPhone.isSplistLine = YES;
    self.addPhone.isArrow = YES;
    self.addPhone.isCellImage = YES;
    self.addPhone.isCellBtn = YES;
    [self.addUserView addSubview:self.addPhone];
    /** 手机号必填标记 */
    self.phoneRequiredMarking = [[UIImageView alloc] init];
    self.phoneRequiredMarking.image = [UIImage imageNamed:@"required_marking"];
    [self.addPhone addSubview:self.phoneRequiredMarking];
    /** 更多信息标题 */
    self.moreInfoTitle = [[UILabel alloc] init];
    self.moreInfoTitle.text = @"更多信息";
    self.moreInfoTitle.font = ThirteenTypeface;
    self.moreInfoTitle.textColor = GrayH2;
    [self.addUserView addSubview:self.moreInfoTitle];

    self.moreInfoTitleSign = [[UILabel alloc] init];
    self.moreInfoTitleSign.text = @"（非必填内容）";
    self.moreInfoTitleSign.font = ThirteenTypeface;
    self.moreInfoTitleSign.textColor = ThemeColor;
    [self.addUserView addSubview:self.moreInfoTitleSign];
    /** 姓名 */
    self.addName = [[UsedCellView alloc] init];
    self.addName.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.addName.cellLabel.text = @"姓名";
    self.addName.cellLabel.font = FifteenTypeface;
    self.addName.cellLabel.textColor = GrayH1;
    self.addName.viceTextFiled.placeholder = @"请输入姓名";
    self.addName.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.addName.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.addName.viceTextFiled.textColor = Black;
    self.addName.dividingLineChoice = DividingLineFullScreenLayout;
    self.addName.isArrow = YES;
    self.addName.isCellImage = YES;
    self.addName.isCellBtn = YES;
    [self.addUserView addSubview:self.addName];
    /** 车牌号 */
    self.addPln = [[UsedCellView alloc] init];
    self.addPln.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.addPln.cellLabel.text = @"车牌号";
    self.addPln.cellLabel.textColor = GrayH1;
    self.addPln.cellLabel.font = FifteenTypeface;
    self.addPln.viceTextFiled.placeholder = @"请输入车牌号";
    self.addPln.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.addPln.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.addPln.viceTextFiled.textColor = Black;
    self.addPln.dividingLineChoice = DividingLineFullScreenLayout;
    self.addPln.isArrow = YES;
    self.addPln.isCellImage = YES;
    self.addPln.isCellBtn = YES;
    [self.addUserView addSubview:self.addPln];
    /** 品牌车系 */
    self.addCar = [[UsedCellView alloc] init];
    self.addCar.usedCellTypeChoice = DescribeImageTextHorizontalLayout;
    self.addCar.cellLabel.text = @"品牌车系";
    self.addCar.cellLabel.textColor = GrayH1;
    self.addCar.cellLabel.font = FifteenTypeface;
    self.addCar.describeLabel.text = @"请选择品牌车系";
    self.addCar.describeLabel.textColor = GrayH2;
    self.addCar.describeLabel.font = ThirteenTypeface;
    self.addCar.describeImageSize = CGSizeMake(35, 35);
    self.addCar.isSplistLine = YES;
    self.addCar.isCellImage = YES;
    [self.addUserView addSubview:self.addCar];
    /** 性别 */
    self.addSexView = [[UIView alloc] init];
    self.addSexView.backgroundColor = WhiteColor;
    [self.addUserView addSubview:self.addSexView];
    self.addSexLabel = [[UILabel alloc] init];
    self.addSexLabel.text = @"性别";
    self.addSexLabel.font = FifteenTypeface;
    self.addSexLabel.textColor = Black;
    [self.addSexView addSubview:self.addSexLabel];
    self.addSexChoice = [[ChangeSexView alloc] init];
    self.addSexChoice.defaultSex = @"男";
    [self.addSexView addSubview:self.addSexChoice];
    [self.addSexView setHidden:YES];
    [self.addSexChoice setHidden:YES];
    
    /** 老会员卡信息标题 */
    self.oldMembershipCardTitleLabel = [[UILabel alloc] init];
    self.oldMembershipCardTitleLabel.text = @"老会员卡信息（非必填）";
    self.oldMembershipCardTitleLabel.font = FourteenTypeface;
    self.oldMembershipCardTitleLabel.textColor = GrayH1;
    [self.addUserView addSubview:self.oldMembershipCardTitleLabel];
    [self.oldMembershipCardTitleLabel setHidden:YES];
    /** 会员卡类型 */
    self.cardTypeView = [[UsedCellView alloc] init];
    self.cardTypeView.cellLabel.text = @"会员卡";
    self.cardTypeView.cellLabel.font = FifteenTypeface;
    self.cardTypeView.cellLabel.textColor = GrayH1;
    self.cardTypeView.describeLabel.text = @"请选择会员卡";
    self.cardTypeView.describeLabel.textColor = GrayH2;
    self.cardTypeView.describeLabel.font = ThirteenTypeface;
    self.cardTypeView.dividingLineChoice = DividingLineFullScreenLayout;
    self.cardTypeView.isCellImage = YES;
    [self.addUserView addSubview:self.cardTypeView];
    /** 余额，余次 */
    self.balanceMoreThanView = [[UsedCellView alloc] init];
    self.balanceMoreThanView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    self.balanceMoreThanView.cellLabel.text = @"余额／余次";
    self.balanceMoreThanView.cellLabel.font = FifteenTypeface;
    self.balanceMoreThanView.cellLabel.textColor = GrayH1;
    self.balanceMoreThanView.viceTextFiled.placeholder = @"请输入余额、余次";
    self.balanceMoreThanView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.balanceMoreThanView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.balanceMoreThanView.viceTextFiled.textColor = Black;
    self.balanceMoreThanView.isSplistLine = YES;
    self.balanceMoreThanView.isArrow = YES;
    self.balanceMoreThanView.isCellImage = YES;
    self.balanceMoreThanView.isCellBtn = YES;
    [self.addUserView addSubview:self.balanceMoreThanView];
    /** 年卡卡值 */
    self.kakaValueView = [[UsedCellView alloc] init];
    self.kakaValueView.cellLabel.text = @"有效期";
    self.kakaValueView.cellLabel.font = FifteenTypeface;
    self.kakaValueView.cellLabel.textColor = GrayH1;
    self.kakaValueView.describeLabel.text = @"请选择到期时间";
    self.kakaValueView.describeLabel.textColor = GrayH2;
    self.kakaValueView.describeLabel.font = ThirteenTypeface;
    self.kakaValueView.isSplistLine = YES;
    self.kakaValueView.isArrow = YES;
    self.kakaValueView.isCellImage = YES;
    [self.kakaValueView.usedCellBtn addTarget:self action:@selector(kakaValueBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.addUserView addSubview:self.kakaValueView];
    // 给当前页面添加清扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction)];
    [self.addUserView addGestureRecognizer:swipeGesture];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.addUserScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.addUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addUserScrollView.mas_top);
        make.left.equalTo(self.addUserScrollView.mas_left);
        make.bottom.equalTo(self.addUserScrollView.mas_bottom);
        make.right.equalTo(self.addUserScrollView.mas_right);
        make.width.equalTo(self.addUserScrollView.mas_width);
    }];

    
    /** 手机 */
    [self.addPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left);
        make.right.equalTo(self.addUserView.mas_right);
        make.top.equalTo(self.addUserView.mas_top);
        make.height.mas_equalTo(@50);
    }];
    /** 手机号必填标记 */
    [self.phoneRequiredMarking mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addPhone.cellLabel.mas_right).offset(5);
        make.centerY.equalTo(self.addPhone.cellLabel.mas_centerY);
    }];
    /** 更多信息标题 */
    [self.moreInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left).offset(15);
        make.top.equalTo(self.addPhone.mas_bottom);
        make.height.mas_equalTo(@40);
    }];

    [self.moreInfoTitleSign mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.moreInfoTitle.mas_right);
        make.centerY.equalTo(self.moreInfoTitle.mas_centerY);
    }];
    /** 姓名 */
    [self.addName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left);
        make.right.equalTo(self.addUserView.mas_right);
        make.top.equalTo(self.moreInfoTitle.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 车牌号 */
    [self.addPln mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left);
        make.right.equalTo(self.addUserView.mas_right);
        make.top.equalTo(self.addName.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 品牌车系 */
    [self.addCar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left);
        make.right.equalTo(self.addUserView.mas_right);
        make.top.equalTo(self.addPln.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 性别 */
    [self.addSexView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left);
        make.right.equalTo(self.addUserView.mas_right);
        make.top.equalTo(self.addName.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    [self.addSexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addSexView.mas_left).offset(15);
        make.centerY.equalTo(self.addSexView.mas_centerY);
    }];
    [self.addSexChoice mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.addSexView.mas_centerY);
        make.left.equalTo(self.addSexLabel.mas_right).offset(15);
        make.width.mas_equalTo(@150);
    }];
    /** 老会员卡信息标题 */
    [self.oldMembershipCardTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left).offset(15);
        make.top.equalTo(self.addCar.mas_bottom);
        make.height.mas_equalTo(@40);
    }];
    /** 会员卡类型 */
    [self.cardTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left);
        make.right.equalTo(self.addUserView.mas_right);
        make.top.equalTo(self.addCar.mas_bottom).offset(10);
        make.height.mas_equalTo(@50);
    }];
    /** 余额，余次 */
    [self.balanceMoreThanView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left);
        make.right.equalTo(self.addUserView.mas_right);
        make.top.equalTo(self.cardTypeView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 年卡卡值 */
    [self.kakaValueView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.addUserView.mas_left);
        make.right.equalTo(self.addUserView.mas_right);
        make.top.equalTo(self.cardTypeView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    /** 填充scrollview的view的高度 */
    [self.addUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.balanceMoreThanView.mas_bottom);
    }];
}


#pragma mark - 输入框响应
- (void)newAddCardTextFieldSignal {
    // 获取手机号signal
    RACSignal *phoneSignal = self.addPhone.viceTextFiled.rac_textSignal;
    // 判断账户输入框输入位数
    RACSignal *phoneNum = [phoneSignal map:^id(NSString *text) {
        return @(text.length > 10);
    }];
    // 限制账号输入框可输入位数
    RAC(self.addPhone.viceTextFiled, text) =
    [phoneNum map:^id(NSNumber *phoneNumberTF){
        return [phoneNumberTF boolValue] ? [self.addPhone.viceTextFiled.text substringToIndex:11] : self.addPhone.viceTextFiled.text;
    }];
    RACSignal *phoneType = [phoneSignal map:^id(NSString *text) {
        return @([CustomObject checkTel:text]);
    }];
    // 聚合以上信息
    self.addPhoneSig = [RACSignal combineLatest:@[phoneNum, phoneType]
                                      reduce:^id(NSNumber *phoneNum, NSNumber *phoneType){
                                          return @([phoneNum boolValue]&&[phoneType boolValue]);
                                      }];
    
    /** 车牌号 */
    RACSignal *plnSignal = self.addPln.viceTextFiled.rac_textSignal;
    // 判断车牌号输入框输入位数
    RACSignal *plnNumber = [plnSignal map:^id(NSString *text) {
        return @(text.length > 15);
    }];
    // 限制车牌号输入框可输入位数
    RAC(self.addPln.viceTextFiled, text) =
    [plnNumber map:^id(NSNumber *plnTF){
        return [plnTF boolValue] ? [self.addPln.viceTextFiled.text substringToIndex:16] : self.addPln.viceTextFiled.text;
    }];
    
    RACSignal *plnType = [plnSignal map:^id(NSString *text) {
        return @([CustomObject isPlnNumber:text]);
    }];
    // 聚合以上信息
    self.addPlnSig = [RACSignal combineLatest:@[plnNumber, plnType]
                                         reduce:^id(NSNumber *plnNumber, NSNumber *plnType){
                                             return @([plnNumber boolValue]&&[plnType boolValue]);
                                         }];
}



- (void)swipeGestureAction {
    [self endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
