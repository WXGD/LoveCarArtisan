//
//  BenefitQuiryView.m
//  TradePlatform
//
//  Created by apple on 2017/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitQuiryView.h"
// view
#import "DrivingPermitView.h"
#import "ZYKeyboardUtil.h"

@interface BenefitQuiryView ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

/** 头部背景图片 */
@property (strong, nonatomic) UIImageView *headerBackImage;
/** 保险查询logo */
@property (strong, nonatomic) UIImageView *benefitQuiryLogo;
/** 保险选项卡view */
@property (strong, nonatomic) UIView *benefitTabView;
/** 新增保险保险 */
@property (strong, nonatomic) UIButton *addBenefitQuiryBtn;
/** 保险查询历史 */
@property (strong, nonatomic) UIButton *benefitQuiryHistoryBtn;
/** 选中按钮 */
@property (strong, nonatomic) UIButton *checkBtn;
/** 保险查询标记view */
@property (strong, nonatomic) UIView *benefitQuirySignView;

/** 保险选项卡填充背景View */
@property (strong, nonatomic) UIView *benTabBackView;

/** 新增查询保险ScrollView */
@property (strong, nonatomic) UIScrollView *addbenQuiryScorllView;
/** 新增查询填充背景View */
@property (strong, nonatomic) UIView *addbenQuiryBackView;

/** 预计结果提示 */
@property (strong, nonatomic) UILabel *expectsResultsSignLabel;

/** 服务提供商 */
@property (strong, nonatomic) UILabel *serviceProviderLabel;

/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@end

@implementation BenefitQuiryView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self benefitQuiryViewLayoutView];
        // 限制车架号最大输入位数
        [self limitVinMaxNumInputSignal];
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

// tab按钮选择
- (void)benefitTabBtnAction:(UIButton *)button {
    // 回收键盘
    [self endEditing:YES];
    self.checkBtn.selected = !self.checkBtn.selected;
    self.checkBtn = button;
    self.checkBtn.selected = !self.checkBtn.selected;
    /** 选中标记 */
    // 告诉self约束需要更新
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.benTabScorllView.contentOffset = CGPointMake(ScreenW * (self.checkBtn.tag - 5010), 0);
    }];
}


// 行驶证按钮
- (void)drivingPermitBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 品牌车型 */
        case CarBrandBtnAction: {
            DrivingPermitView *drivingPermitView = [[DrivingPermitView alloc] init];
            drivingPermitView.drivingPermitImage.image = [UIImage imageNamed:@"driving_permit_car_brand"];
            [drivingPermitView show];
            break;
        }
            /** 车架号 */
        case VinBtnAction: {
            DrivingPermitView *drivingPermitView = [[DrivingPermitView alloc] init];
            drivingPermitView.drivingPermitImage.image = [UIImage imageNamed:@"driving_permit_vin"];
            [drivingPermitView show];
            break;
        }
            /** 发动机号 */
        case EngineBtnAction: {
            DrivingPermitView *drivingPermitView = [[DrivingPermitView alloc] init];
            drivingPermitView.drivingPermitImage.image = [UIImage imageNamed:@"driving_permit_engine"];
            [drivingPermitView show];
            break;
        }
            /** 初次登记时间 */
        case CheckTimeBtnAction: {
            DrivingPermitView *drivingPermitView = [[DrivingPermitView alloc] init];
            drivingPermitView.drivingPermitImage.image = [UIImage imageNamed:@"driving_permit_check_time"];
            [drivingPermitView show];
            break;
        }
        default:
            break;
    }
}

// 登记时间
- (void)checkTimeBtnAvtion:(UIButton *)button {
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
        self.checkTimeView.viceLabel.text = timestamp;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}

#pragma mark - scrollview滚动代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![NSStringFromClass([scrollView class]) isEqualToString:@"UITableView"]) {
        UIButton *checkBtn = (UIButton *)[self viewWithTag: scrollView.contentOffset.x / ScreenW + 5010];
        [self benefitTabBtnAction:checkBtn];
    }
}
#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.quiryRecordArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"quiryRecordCell";
    QuiryRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[QuiryRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.quiryRecordModel = [self.quiryRecordArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取当前选中模型
    BennfitQuiryRecordModel *quiryRecordModel = [self.quiryRecordArray objectAtIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(quiryRecordChoiceCell:quiryRecordModel:)]) {
        [_delegate quiryRecordChoiceCell:indexPath quiryRecordModel:quiryRecordModel];
    }
}


#pragma mark - view布局
- (void)benefitQuiryViewLayoutView {
    /** 头部背景图片 */
    self.headerBackImage = [[UIImageView alloc] init];
    self.headerBackImage.image = [UIImage imageNamed:@"header_choice_back"];
    [self addSubview:self.headerBackImage];
    /** 营销项目logo */
    self.benefitQuiryLogo = [[UIImageView alloc] init];
    self.benefitQuiryLogo.image = [UIImage imageNamed:@"benefit_quiry_logo"];
    [self.headerBackImage addSubview:self.benefitQuiryLogo];
    /** 保险选项卡view */
    self.benefitTabView = [[UIView alloc] init];
    self.benefitTabView.backgroundColor = WhiteColor;
    [self addSubview:self.benefitTabView];
    /** 新增保险保险 */
    self.addBenefitQuiryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBenefitQuiryBtn setTitle:@"新增查询" forState:UIControlStateNormal];
    self.addBenefitQuiryBtn.titleLabel.font = FourteenTypeface;
    [self.addBenefitQuiryBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.addBenefitQuiryBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [self.addBenefitQuiryBtn addTarget:self action:@selector(benefitTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.addBenefitQuiryBtn.tag = 5010;
    [self.benefitTabView addSubview:self.addBenefitQuiryBtn];
    self.checkBtn = self.addBenefitQuiryBtn;
    self.addBenefitQuiryBtn.selected = YES;
    /** 保险查询历史 */
    self.benefitQuiryHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.benefitQuiryHistoryBtn setTitle:@"查询历史" forState:UIControlStateNormal];
    self.benefitQuiryHistoryBtn.titleLabel.font = FourteenTypeface;
    [self.benefitQuiryHistoryBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.benefitQuiryHistoryBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [self.benefitQuiryHistoryBtn addTarget:self action:@selector(benefitTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.benefitQuiryHistoryBtn.tag = 5011;
    [self.benefitTabView addSubview:self.benefitQuiryHistoryBtn];
    /** 保险查询标记view */
    self.benefitQuirySignView = [[UIView alloc] init];
    self.benefitQuirySignView.backgroundColor = ThemeColor;
    [self.benefitTabView addSubview:self.benefitQuirySignView];
    /** 保险选项卡ScrollView */
    self.benTabScorllView = [[UIScrollView alloc] init];
    self.benTabScorllView.pagingEnabled = YES;
    self.benTabScorllView.showsHorizontalScrollIndicator = NO;
    self.benTabScorllView.delegate = self;
    [self addSubview:self.benTabScorllView];
    // 添加回收键盘的手势
    UITapGestureRecognizer *benTabTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(benTabTapAction:)];
    benTabTap.delegate = self;
    [self.benTabScorllView addGestureRecognizer:benTabTap];
    /** 保险选项卡填充背景View */
    self.benTabBackView = [[UIView alloc] init];
    [self.benTabScorllView addSubview:self.benTabBackView];
    /** 新增查询保险ScrollView */
    self.addbenQuiryScorllView = [[UIScrollView alloc] init];
    [self.benTabBackView addSubview:self.addbenQuiryScorllView];
    /** 新增查询填充背景View */
    self.addbenQuiryBackView = [[UIView alloc] init];
    [self.addbenQuiryScorllView addSubview:self.addbenQuiryBackView];
    /** 车牌号view */
    self.plnView = [[UsedCellView alloc] init];
    self.plnView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.plnView.arrowImage setImage:[UIImage imageNamed:@"custom_open_card_scan"] forState:UIControlStateNormal];
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
    self.plnView.arrowImage.tag = PlnBtnAction;
    [self.addbenQuiryBackView addSubview:self.plnView];
    /** 品牌车型 */
    self.carBrandView = [[UsedCellView alloc] init];
    self.carBrandView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.carBrandView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    self.carBrandView.cellLabel.text = @"品牌车型";
    self.carBrandView.cellLabel.font = FifteenTypeface;
    self.carBrandView.cellLabel.textColor = GrayH1;
    self.carBrandView.viceTextFiled.placeholder = @"请输入品牌车型";
    self.carBrandView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.carBrandView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.carBrandView.viceTextFiled.textColor = Black;
    self.carBrandView.viceTextFiled.font = FourteenTypeface;
    self.carBrandView.isCellImage = YES;
    self.carBrandView.isCellBtn = YES;
    self.carBrandView.arrowImage.tag = CarBrandBtnAction;
    [self.carBrandView.arrowImage addTarget:self action:@selector(drivingPermitBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.addbenQuiryBackView addSubview:self.carBrandView];
    /** 车架号 */
    self.vinView = [[UsedCellView alloc] init];
    self.vinView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.vinView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    self.vinView.cellLabel.text = @"车架号";
    self.vinView.cellLabel.font = FifteenTypeface;
    self.vinView.cellLabel.textColor = GrayH1;
    self.vinView.viceTextFiled.placeholder = @"请输入车架号";
    self.vinView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.vinView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.vinView.viceTextFiled.textColor = Black;
    self.vinView.viceTextFiled.font = FourteenTypeface;
    self.vinView.isCellImage = YES;
    self.vinView.isCellBtn = YES;
    self.vinView.arrowImage.tag = VinBtnAction;
    [self.vinView.arrowImage addTarget:self action:@selector(drivingPermitBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.addbenQuiryBackView addSubview:self.vinView];
    /** 发动机号 */
    self.engineView = [[UsedCellView alloc] init];
    self.engineView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.engineView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    self.engineView.cellLabel.text = @"发动机号";
    self.engineView.cellLabel.font = FifteenTypeface;
    self.engineView.cellLabel.textColor = GrayH1;
    self.engineView.viceTextFiled.placeholder = @"请输入发动机号";
    self.engineView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.engineView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.engineView.viceTextFiled.textColor = Black;
    self.engineView.viceTextFiled.font = FourteenTypeface;
    self.engineView.isCellImage = YES;
    self.engineView.isCellBtn = YES;
    self.engineView.arrowImage.tag = EngineBtnAction;
    [self.engineView.arrowImage addTarget:self action:@selector(drivingPermitBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.addbenQuiryBackView addSubview:self.engineView];
    /** 初次登记时间 */
    self.checkTimeView = [[UsedCellView alloc] init];
    [self.checkTimeView.arrowImage setImage:[UIImage imageNamed:@"benefit_quiry_there"] forState:UIControlStateNormal];
    self.checkTimeView.cellLabel.text = @"初次登记时间 ";
    self.checkTimeView.cellLabel.font = FifteenTypeface;
    self.checkTimeView.cellLabel.textColor = GrayH1;
    self.checkTimeView.viceLabel.textColor = Black;
    self.checkTimeView.viceLabel.font = FourteenTypeface;
    self.checkTimeView.isSplistLine = YES;
    self.checkTimeView.isCellImage = YES;
    self.checkTimeView.isCellBtn = YES;
    self.checkTimeView.arrowImage.tag = CheckTimeBtnAction;
    [self.checkTimeView.arrowImage addTarget:self action:@selector(drivingPermitBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.addbenQuiryBackView addSubview:self.checkTimeView];
    // 获取当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    self.checkTimeView.viceLabel.text = dateTime;
    // 初次登记时间选择按钮
    self.checkTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkTimeButton addTarget:self action:@selector(checkTimeBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkTimeView addSubview:self.checkTimeButton];
    /** 预计结果提示 */
    self.expectsResultsSignLabel = [[UILabel alloc] init];
    self.expectsResultsSignLabel.text = @"预计10分钟出结果";
    self.expectsResultsSignLabel.font = TwelveTypeface;
    self.expectsResultsSignLabel.textColor = BlueColor;
    [self.addbenQuiryBackView addSubview:self.expectsResultsSignLabel];
    /** 提交查询 */
    self.submitQueryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitQueryBtn setTitle:@"提交查询" forState:UIControlStateNormal];
    self.submitQueryBtn.titleLabel.font = FifteenTypeface;
    [self.submitQueryBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.submitQueryBtn.backgroundColor = ThemeColor;
    self.submitQueryBtn.layer.masksToBounds = YES;
    self.submitQueryBtn.layer.cornerRadius = 2;
    self.submitQueryBtn.tag = SubmitQueryBtnAction;
    [self.addbenQuiryBackView addSubview:self.submitQueryBtn];
    /** 拍摄行驶证查询 */
    self.shotQueryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shotQueryBtn setTitle:@"拍摄行驶证正面查询" forState:UIControlStateNormal];
    self.shotQueryBtn.titleLabel.font = FifteenTypeface;
    [self.shotQueryBtn setTitleColor:Black forState:UIControlStateNormal];
    self.shotQueryBtn.backgroundColor = WhiteColor;
    self.shotQueryBtn.layer.masksToBounds = YES;
    self.shotQueryBtn.layer.cornerRadius = 2;
    self.shotQueryBtn.layer.borderWidth = 0.5;
    self.shotQueryBtn.layer.borderColor = DividingLine.CGColor;
    self.shotQueryBtn.tag = ShotQueryBtnAction;
    [self.addbenQuiryBackView addSubview:self.shotQueryBtn];
    /** 服务提供商 */
    self.serviceProviderLabel = [[UILabel alloc] init];
    self.serviceProviderLabel.text = @"本服务由龙郡保险提供";
    self.serviceProviderLabel.font = TwelveTypeface;
    self.serviceProviderLabel.textColor = GrayH2;
    [self.addbenQuiryBackView addSubview:self.serviceProviderLabel];
    /** 查询记录 */
    self.quiryRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 46) style:UITableViewStylePlain];
    self.quiryRecordTableView.delegate = self;
    self.quiryRecordTableView.dataSource = self;
    self.quiryRecordTableView.rowHeight = 82;
    self.quiryRecordTableView.backgroundColor = CLEARCOLOR;
    self.quiryRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.benTabBackView addSubview:self.quiryRecordTableView];
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 56.5)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, ScreenW, 14.5)];
    label.textColor = GrayH2;
    label.font = TwelveTypeface;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"本服务由龙郡保险提供";
    [footView addSubview:label];
    self.quiryRecordTableView.tableFooterView = footView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 头部背景图片 */
    [self.headerBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    /** 营销项目logo */
    [self.benefitQuiryLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerBackImage.mas_top);
        make.left.equalTo(self.headerBackImage.mas_left);
        make.right.equalTo(self.headerBackImage.mas_right);
        make.bottom.equalTo(self.headerBackImage.mas_bottom);
    }];
    /** 保险选项卡view */
    [self.benefitTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerBackImage.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@44);
    }];
    /** 新增保险保险 */
    [self.addBenefitQuiryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benefitTabView.mas_top);
        make.bottom.equalTo(self.benefitTabView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_centerX);
    }];
    /** 保险查询历史 */
    [self.benefitQuiryHistoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benefitTabView.mas_top);
        make.bottom.equalTo(self.benefitTabView.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_centerX);
    }];
    /** 保险查询标记view */
    [self.benefitQuirySignView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.benefitTabView.mas_bottom);
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake((ScreenW / 2 - 32), 2));
    }];
    /** 保险选项卡ScrollView */
    [self.benTabScorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benefitTabView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 保险选项卡填充背景View */
    [self.benTabBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benTabScorllView.mas_top);
        make.left.equalTo(self.benTabScorllView.mas_left);
        make.bottom.equalTo(self.benTabScorllView.mas_bottom);
        make.right.equalTo(self.benTabScorllView.mas_right);
        make.height.equalTo(self.benTabScorllView.mas_height);
        make.width.mas_equalTo(@(ScreenW * 2));
    }];
    /** 新增查询保险ScrollView */
    [self.addbenQuiryScorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benTabBackView.mas_top);
        make.left.equalTo(self.benTabBackView.mas_left);
        make.bottom.equalTo(self.benTabBackView.mas_bottom);
        make.right.equalTo(self.benTabBackView.mas_centerX);
    }];
    /** 新增查询填充背景View */
    [self.addbenQuiryBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addbenQuiryScorllView.mas_top);
        make.left.equalTo(self.addbenQuiryScorllView.mas_left);
        make.bottom.equalTo(self.addbenQuiryScorllView.mas_bottom);
        make.right.equalTo(self.addbenQuiryScorllView.mas_right);
        make.width.equalTo(self.addbenQuiryScorllView.mas_width);
        make.bottom.equalTo(self.serviceProviderLabel.mas_bottom).offset(24);
    }];
    /** 车牌号 */
    [self.plnView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addbenQuiryBackView.mas_top);
        make.left.equalTo(self.addbenQuiryBackView.mas_left);
        make.right.equalTo(self.addbenQuiryBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 品牌车型 */
    [self.carBrandView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.plnView.mas_bottom);
        make.left.equalTo(self.addbenQuiryBackView.mas_left);
        make.right.equalTo(self.addbenQuiryBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 车架号 */
    [self.vinView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carBrandView.mas_bottom);
        make.left.equalTo(self.addbenQuiryBackView.mas_left);
        make.right.equalTo(self.addbenQuiryBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 发动机号 */
    [self.engineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.vinView.mas_bottom);
        make.left.equalTo(self.addbenQuiryBackView.mas_left);
        make.right.equalTo(self.addbenQuiryBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 初次登记时间 */
    [self.checkTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.engineView.mas_bottom);
        make.left.equalTo(self.addbenQuiryBackView.mas_left);
        make.right.equalTo(self.addbenQuiryBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    // 初次登记时间选择按钮
    [self.checkTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.checkTimeView.mas_top);
        make.left.equalTo(self.checkTimeView.mas_left);
        make.right.equalTo(self.checkTimeView.mas_right).offset(-80);
        make.bottom.equalTo(self.checkTimeView.mas_bottom);
    }];
    /** 预计结果提示 */
    [self.expectsResultsSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.checkTimeView.mas_bottom).offset(27);
        make.left.equalTo(self.addbenQuiryBackView.mas_left).offset(16);
    }];
    /** 提交查询 */
    [self.submitQueryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.expectsResultsSignLabel.mas_bottom).offset(10);
        make.left.equalTo(self.addbenQuiryBackView.mas_left).offset(16);
        make.right.equalTo(self.addbenQuiryBackView.mas_right).offset(-16);
        make.height.mas_equalTo(@44);
    }];
    /** 拍摄行驶证查询 */
    [self.shotQueryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.submitQueryBtn.mas_bottom).offset(16);
        make.left.equalTo(self.addbenQuiryBackView.mas_left).offset(16);
        make.right.equalTo(self.addbenQuiryBackView.mas_right).offset(-16);
        make.height.mas_equalTo(@44);
    }];
    /** 服务提供商 */
    [self.serviceProviderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.shotQueryBtn.mas_bottom).offset(44);
        make.centerX.equalTo(self.addbenQuiryBackView.mas_centerX);
    }];
    /** 查询记录 */
    [self.quiryRecordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.benTabBackView.mas_top);
        make.left.equalTo(self.benTabBackView.mas_centerX);
        make.bottom.equalTo(self.benTabBackView.mas_bottom);
        make.right.equalTo(self.benTabBackView.mas_right);
    }];
}


- (void)updateConstraints {
    @weakify(self)
    /** 保险查询标记view */
    [self.benefitQuirySignView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake((ScreenW / 2 - 32), 2));
        make.bottom.equalTo(self.benefitTabView.mas_bottom);
    }];
    [super updateConstraints];
}

#pragma mark - 输入框响应
// 限制车架号最大输入位数
- (void)limitVinMaxNumInputSignal {
    // 获取账户signal
    RACSignal *vinTFSignal = self.vinView.viceTextFiled.rac_textSignal;
    // 判断账户输入框最大输入位数
    RACSignal *vinMaxNumber =
    [vinTFSignal map:^id(NSString *text) {
        return @(text.length > 16);
    }];
    // 限制账号输入框可输入位数
    RAC(self.vinView.viceTextFiled, text) =
    [vinMaxNumber map:^id(NSNumber *vinNumberTF){
        return [vinNumberTF boolValue] ? [self.vinView.viceTextFiled.text substringToIndex:17] : self.vinView.viceTextFiled.text;
    }];
}


#pragma mark - 手势代理，解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 判断是不是tableview触发的手势
    PDLog(@"%@", touch.view);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIImageView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}

#pragma mark - 回收键盘的方法
- (void)benTabTapAction:(UIButton *)button {
    [self endEditing:YES];
}

@end
