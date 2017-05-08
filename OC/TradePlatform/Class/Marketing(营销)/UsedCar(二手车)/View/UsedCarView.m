//
//  UsedCarView.m
//  TradePlatform
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarView.h"
// view
#import "ZYKeyboardUtil.h"
#import "QFDatePickerView.h"

@interface UsedCarView ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

/** 二手车选项卡view */
@property (strong, nonatomic) UIView *usedCarTabView;
/** 新增二手车估值记录 */
@property (strong, nonatomic) UIButton *addUsedCarBtn;
/** 选中按钮 */
@property (strong, nonatomic) UIButton *checkBtn;
/** 二手车查询标记view */
@property (strong, nonatomic) UIView *usedCarSignView;

/** 车辆型号 */
@property (strong, nonatomic) UIView *carBrandView;
@property (strong, nonatomic) UILabel *carBrandTitle;
@property (strong, nonatomic) UIImageView *carBrandArrow;
@property (strong, nonatomic) UIView *carBrandLine;

/** 保险选项卡填充背景View */
@property (strong, nonatomic) UIView *usedCarTabBackView;
/** 新增查询保险ScrollView */
@property (strong, nonatomic) UIScrollView *addValuationScorllView;
/** 新增查询填充背景View */
@property (strong, nonatomic) UIView *addValuationBackView;
/** 精确估值title */
@property (strong, nonatomic) UILabel *exactValuationTitleLabel;

/** 操作键盘弹出 */
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;

@end

@implementation UsedCarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self usedCarLayoutView];
        // 输入框响应
        [self usedCarValuationTextFieldSignal];
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

#pragma mark - 按钮点击方法
// tab按钮选择
- (void)usedCarTabBtnAction:(UIButton *)button {
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
        self.usedCarTabScorllView.contentOffset = CGPointMake(ScreenW * (self.checkBtn.tag - 5010), 0);
    }];
}

// 登记时间
- (void)firstFailingBtnAction:(UIButton *)button {
    [self endEditing:YES];
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
        self.firstFailingView.describeLabel.text = str;
        self.firstFailingView.describeLabel.textColor = Black;
    }];
    [datePickerView show];
//    // 日历
//    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    // 选择框
//    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        // 确定日期
//        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"YYYY-MM";
//        NSString *timestamp = [formatter stringFromDate:datePicker.date];
//        self.firstFailingView.describeLabel.text = timestamp;
//        self.firstFailingView.describeLabel.textColor = Black;
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
//    [alertController addAction:confirm];
//    [alertController addAction:cancel];
//    [[self viewController] presentViewController:alertController animated:YES completion:nil];
//    // 将日期滚轮添加到选择框上
//    [alertController.view addSubview:datePicker];
}


#pragma mark - scrollview滚动代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![NSStringFromClass([scrollView class]) isEqualToString:@"UITableView"]) {
        UIButton *checkBtn = (UIButton *)[self viewWithTag: scrollView.contentOffset.x / ScreenW + 5010];
        [self usedCarTabBtnAction:checkBtn];
    }
}

#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.valuationRecordArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"valuationRecordCell";
    ValuationRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ValuationRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.valuationNotesModel = [self.valuationRecordArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ValuationNotesModel *valuationNotesModel = [self.valuationRecordArray objectAtIndex:indexPath.row];
    /** 车牌型号高度 */
    CGFloat carBrandHeight = [CustomString heightForString:valuationNotesModel.car_model_name textFont:ThirteenTypeface textWidth:ScreenW - 64];
    return 140 + carBrandHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取当前选中模型
    ValuationNotesModel *valuationNotesModel = [self.valuationRecordArray objectAtIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(usedCarValuationInfoChoiceCell:)]) {
        [_delegate usedCarValuationInfoChoiceCell:valuationNotesModel];
    }
}


#pragma mark - view布局
- (void)usedCarLayoutView {
    /** 二手车选项卡view */
    self.usedCarTabView = [[UIView alloc] init];
    self.usedCarTabView.backgroundColor = WhiteColor;
    [self addSubview:self.usedCarTabView];
    /** 新增二手车 */
    self.addUsedCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addUsedCarBtn setTitle:@"新增估值" forState:UIControlStateNormal];
    self.addUsedCarBtn.titleLabel.font = FourteenTypeface;
    [self.addUsedCarBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.addUsedCarBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [self.addUsedCarBtn addTarget:self action:@selector(usedCarTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.addUsedCarBtn.tag = 5010;
    [self.usedCarTabView addSubview:self.addUsedCarBtn];
    self.checkBtn = self.addUsedCarBtn;
    self.addUsedCarBtn.selected = YES;
    /** 二手车查询历史 */
    self.usedCarHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.usedCarHistoryBtn setTitle:@"估值历史" forState:UIControlStateNormal];
    self.usedCarHistoryBtn.titleLabel.font = FourteenTypeface;
    [self.usedCarHistoryBtn setTitleColor:GrayH1 forState:UIControlStateNormal];
    [self.usedCarHistoryBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [self.usedCarHistoryBtn addTarget:self action:@selector(usedCarTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.usedCarHistoryBtn.tag = 5011;
    [self.usedCarTabView addSubview:self.usedCarHistoryBtn];
    /** 二手车查询标记view */
    self.usedCarSignView = [[UIView alloc] init];
    self.usedCarSignView.backgroundColor = ThemeColor;
    [self.usedCarTabView addSubview:self.usedCarSignView];
    
    /** 保险选项卡ScrollView */
    self.usedCarTabScorllView = [[UIScrollView alloc] init];
    self.usedCarTabScorllView.pagingEnabled = YES;
    self.usedCarTabScorllView.showsHorizontalScrollIndicator = NO;
    self.usedCarTabScorllView.delegate = self;
    [self addSubview:self.usedCarTabScorllView];
    // 添加回收键盘的手势
    UITapGestureRecognizer *benTabTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(benTabTapAction:)];
    benTabTap.delegate = self;
    [self.usedCarTabScorllView addGestureRecognizer:benTabTap];
    /** 保险选项卡填充背景View */
    self.usedCarTabBackView = [[UIView alloc] init];
    [self.usedCarTabScorllView addSubview:self.usedCarTabBackView];
    /** 新增查询保险ScrollView */
    self.addValuationScorllView = [[UIScrollView alloc] init];
    [self.usedCarTabBackView addSubview:self.addValuationScorllView];
    /** 新增查询填充背景View */
    self.addValuationBackView = [[UIView alloc] init];
    [self.addValuationScorllView addSubview:self.addValuationBackView];
    /** 车辆型号 */
    self.carBrandView = [[UIView alloc] init];
    self.carBrandView.backgroundColor = WhiteColor;
    [self.addValuationBackView addSubview:self.carBrandView];
    
    self.carBrandTitle = [[UILabel alloc] init];
    self.carBrandTitle.text = @"车辆型号";
    self.carBrandTitle.font = FifteenTypeface;
    self.carBrandTitle.textColor = GrayH1;
    [self.carBrandView addSubview:self.carBrandTitle];
    
    self.carBrandDetails = [[UILabel alloc] init];
    self.carBrandDetails.text = @"请选择车辆型号";
    self.carBrandDetails.textAlignment = NSTextAlignmentRight;
    self.carBrandDetails.textColor = GrayH2;
    self.carBrandDetails.font = ThirteenTypeface;
    self.carBrandDetails.numberOfLines = 2;
    [self.carBrandView addSubview:self.carBrandDetails];
    
    self.carBrandArrow = [[UIImageView alloc] init];
    self.carBrandArrow.image = [UIImage imageNamed:@"right_arrow"];
    [self.carBrandView addSubview:self.carBrandArrow];
    
    self.carBrandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.carBrandView addSubview:self.carBrandBtn];
    
    self.carBrandLine = [[UIView alloc] init];
    self.carBrandLine.backgroundColor = DividingLine;
    [self.carBrandView addSubview:self.carBrandLine];
    /** 所在城市 */
    self.cityView = [[UsedCellView alloc] init];
    self.cityView.cellLabel.text = @"所在城市";
    self.cityView.cellLabel.font = FifteenTypeface;
    self.cityView.cellLabel.textColor = GrayH1;
    self.cityView.describeLabel.text = @"请选择所在城市";
    self.cityView.describeLabel.textAlignment = NSTextAlignmentLeft;
    self.cityView.describeLabel.textColor = GrayH2;
    self.cityView.describeLabel.font = ThirteenTypeface;
    self.cityView.isCellImage = YES;
    self.cityView.usedCellBtn.tag = CityBtnAction;
    self.cityView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.addValuationBackView addSubview:self.cityView];
    /** 首次上牌 */
    self.firstFailingView = [[UsedCellView alloc] init];
    self.firstFailingView.cellLabel.text = @"首次上牌";
    self.firstFailingView.cellLabel.font = FifteenTypeface;
    self.firstFailingView.cellLabel.textColor = GrayH1;
    self.firstFailingView.describeLabel.text = @"请选择上牌时间";
    self.firstFailingView.describeLabel.textAlignment = NSTextAlignmentLeft;
    self.firstFailingView.describeLabel.textColor = GrayH2;
    self.firstFailingView.describeLabel.font = ThirteenTypeface;
    self.firstFailingView.isCellImage = YES;
    [self.firstFailingView.usedCellBtn addTarget:self action:@selector(firstFailingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.firstFailingView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.addValuationBackView addSubview:self.firstFailingView];
    /** 行驶里程 */
    self.mileageView = [[UsedCellView alloc] init];
    self.mileageView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.mileageView.arrowImage setImage:nil forState:UIControlStateNormal];
    [self.mileageView.arrowImage setTitle:@"万公里" forState:UIControlStateNormal];
    self.mileageView.arrowImage.titleLabel.font = FourteenTypeface;
    [self.mileageView.arrowImage setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.mileageView.cellLabel.text = @"行驶里程";
    self.mileageView.cellLabel.font = FifteenTypeface;
    self.mileageView.cellLabel.textColor = GrayH1;
    self.mileageView.viceTextFiled.placeholder = @"请输入行驶里程";
    self.mileageView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.mileageView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.mileageView.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.mileageView.viceTextFiled.textColor = Black;
    self.mileageView.viceTextFiled.font = ThirteenTypeface;
    self.mileageView.isCellImage = YES;
    self.mileageView.isSplistLine = YES;
    self.mileageView.isCellBtn = YES;
    [self.addValuationBackView addSubview:self.mileageView];
    /** 精确估值title */
    self.exactValuationTitleLabel = [[UILabel alloc] init];
    self.exactValuationTitleLabel.text = @"精确估值";
    self.exactValuationTitleLabel.textColor = GrayH2;
    self.exactValuationTitleLabel.font = ThirteenTypeface;
    [self.addValuationBackView addSubview:self.exactValuationTitleLabel];
    /** 车况 */
    self.conditionView = [[UsedCellView alloc] init];
    self.conditionView.cellLabel.text = @"车况";
    self.conditionView.cellLabel.font = FifteenTypeface;
    self.conditionView.cellLabel.textColor = GrayH1;
    self.conditionView.describeLabel.text = @"请选择车况";
    self.conditionView.describeLabel.textAlignment = NSTextAlignmentLeft;
    self.conditionView.describeLabel.textColor = GrayH2;
    self.conditionView.describeLabel.font = ThirteenTypeface;
    self.conditionView.isCellImage = YES;
    self.conditionView.usedCellBtn.tag = ConditionBtnAction;
    self.conditionView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.addValuationBackView addSubview:self.conditionView];
    /** 车辆用途 */
    self.carUseView = [[UsedCellView alloc] init];
    self.carUseView.cellLabel.text = @"车辆用途";
    self.carUseView.cellLabel.font = FifteenTypeface;
    self.carUseView.cellLabel.textColor = GrayH1;
    self.carUseView.describeLabel.text = @"请选择车辆用途";
    self.carUseView.describeLabel.textAlignment = NSTextAlignmentLeft;
    self.carUseView.describeLabel.textColor = GrayH2;
    self.carUseView.describeLabel.font = ThirteenTypeface;
    self.carUseView.isCellImage = YES;
    self.carUseView.usedCellBtn.tag = CarUseBtnAction;
    self.carUseView.dividingLineChoice = DividingLineFullScreenLayout;
    [self.addValuationBackView addSubview:self.carUseView];
    /** 车辆购入价 */
    self.carBuyPriceView = [[UsedCellView alloc] init];
    self.carBuyPriceView.usedCellTypeChoice = ViceTextFiledHorizontalLayout;
    [self.carBuyPriceView.arrowImage setImage:nil forState:UIControlStateNormal];
    [self.carBuyPriceView.arrowImage setTitle:@"万元" forState:UIControlStateNormal];
    self.carBuyPriceView.arrowImage.titleLabel.font = FourteenTypeface;
    [self.carBuyPriceView.arrowImage setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.carBuyPriceView.cellLabel.text = @"车辆购入价";
    self.carBuyPriceView.cellLabel.font = FifteenTypeface;
    self.carBuyPriceView.cellLabel.textColor = GrayH1;
    self.carBuyPriceView.viceTextFiled.placeholder = @"请输入车辆购入价";
    self.carBuyPriceView.viceTextFiled.borderStyle = UITextBorderStyleNone;
    self.carBuyPriceView.viceTextFiled.textAlignment = NSTextAlignmentLeft;
    self.carBuyPriceView.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.carBuyPriceView.viceTextFiled.textColor = Black;
    self.carBuyPriceView.viceTextFiled.font = ThirteenTypeface;
    self.carBuyPriceView.isCellImage = YES;
    self.carBuyPriceView.isSplistLine = YES;
    self.carBuyPriceView.isCellBtn = YES;
    [self.addValuationBackView addSubview:self.carBuyPriceView];
    /** 开始估值 */
    self.startValuationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startValuationBtn setTitle:@"开始估值" forState:UIControlStateNormal];
    self.startValuationBtn.titleLabel.font = FifteenTypeface;
    [self.startValuationBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.startValuationBtn.backgroundColor = ThemeColor;
    self.startValuationBtn.layer.masksToBounds = YES;
    self.startValuationBtn.layer.cornerRadius = 2;
    self.startValuationBtn.tag = StartValuationBtnAction;
    [self.addValuationBackView addSubview:self.startValuationBtn];
    /** 查询记录 */
    self.valuationRecordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 46) style:UITableViewStylePlain];
    self.valuationRecordTableView.delegate = self;
    self.valuationRecordTableView.dataSource = self;
    self.valuationRecordTableView.backgroundColor = CLEARCOLOR;
    self.valuationRecordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.usedCarTabBackView addSubview:self.valuationRecordTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 二手车查询标记view */
    [self.usedCarTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@44);
    }];
    /** 新增二手车估值记录 */
    [self.addUsedCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usedCarTabView.mas_top);
        make.bottom.equalTo(self.usedCarTabView.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_centerX);
    }];
    /** 二手车查询历史 */
    [self.usedCarHistoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usedCarTabView.mas_top);
        make.bottom.equalTo(self.usedCarTabView.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_centerX);
    }];
    /** 二手车查询标记view */
    [self.usedCarSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.usedCarTabView.mas_bottom);
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake((ScreenW / 2 - 32), 2));
    }];
    
    /** 保险选项卡ScrollView */
    [self.usedCarTabScorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usedCarTabView.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 保险选项卡填充背景View */
    [self.usedCarTabBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usedCarTabScorllView.mas_top);
        make.left.equalTo(self.usedCarTabScorllView.mas_left);
        make.bottom.equalTo(self.usedCarTabScorllView.mas_bottom);
        make.right.equalTo(self.usedCarTabScorllView.mas_right);
        make.height.equalTo(self.usedCarTabScorllView.mas_height);
        make.width.mas_equalTo(@(ScreenW * 2));
    }];
    /** 新增查询保险ScrollView */
    [self.addValuationScorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usedCarTabBackView.mas_top);
        make.left.equalTo(self.usedCarTabBackView.mas_left);
        make.bottom.equalTo(self.usedCarTabBackView.mas_bottom);
        make.right.equalTo(self.usedCarTabBackView.mas_centerX);
    }];
    /** 新增查询填充背景View */
    [self.addValuationBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addValuationScorllView.mas_top);
        make.left.equalTo(self.addValuationScorllView.mas_left);
        make.bottom.equalTo(self.addValuationScorllView.mas_bottom);
        make.right.equalTo(self.addValuationScorllView.mas_right);
        make.width.equalTo(self.addValuationScorllView.mas_width);
    }];
    /** 车辆型号 */
    [self.carBrandView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.addValuationBackView.mas_top);
        make.left.equalTo(self.addValuationBackView.mas_left);
        make.right.equalTo(self.addValuationBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    [self.carBrandTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.carBrandView.mas_centerY);
        make.left.equalTo(self.carBrandView.mas_left).offset(16);
        make.width.mas_equalTo(@62);
    }];
    [self.carBrandArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.carBrandView.mas_centerY);
        make.right.equalTo(self.carBrandView.mas_right).offset(-16);
    }];
    [self.carBrandDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.carBrandView.mas_centerY);
        make.right.equalTo(self.carBrandArrow.mas_left).offset(-16);
        make.left.equalTo(self.carBrandTitle.mas_right).offset(16);
    }];
    [self.carBrandLine mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.carBrandView.mas_left);
        make.right.equalTo(self.carBrandView.mas_right);
        make.bottom.equalTo(self.carBrandView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
    [self.carBrandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carBrandView.mas_top);
        make.left.equalTo(self.carBrandView.mas_left);
        make.right.equalTo(self.carBrandView.mas_right);
        make.bottom.equalTo(self.carBrandView.mas_bottom);
    }];
    /** 所在城市 */
    [self.cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carBrandView.mas_bottom);
        make.left.equalTo(self.addValuationBackView.mas_left);
        make.right.equalTo(self.addValuationBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 首次上牌 */
    [self.firstFailingView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.cityView.mas_bottom);
        make.left.equalTo(self.addValuationBackView.mas_left);
        make.right.equalTo(self.addValuationBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 行驶里程 */
    [self.mileageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.firstFailingView.mas_bottom);
        make.left.equalTo(self.addValuationBackView.mas_left);
        make.right.equalTo(self.addValuationBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 精确估值title */
    [self.exactValuationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mileageView.mas_bottom);
        make.left.equalTo(self.addValuationBackView.mas_left).offset(16);
        make.height.mas_equalTo(@40);
    }];
    /** 车况 */
    [self.conditionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.exactValuationTitleLabel.mas_bottom);
        make.left.equalTo(self.addValuationBackView.mas_left);
        make.right.equalTo(self.addValuationBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 车辆用途 */
    [self.carUseView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.conditionView.mas_bottom);
        make.left.equalTo(self.addValuationBackView.mas_left);
        make.right.equalTo(self.addValuationBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 车辆购入价 */
    [self.carBuyPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carUseView.mas_bottom);
        make.left.equalTo(self.addValuationBackView.mas_left);
        make.right.equalTo(self.addValuationBackView.mas_right);
        make.height.mas_equalTo(@48);
    }];
    /** 开始估值 */
    [self.startValuationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.carBuyPriceView.mas_bottom).offset(28);
        make.left.equalTo(self.addValuationBackView.mas_left).offset(16);
        make.right.equalTo(self.addValuationBackView.mas_right).offset(-16);
        make.height.mas_equalTo(@44);
    }];
    /** 新增查询填充背景View高度 */
    [self.addValuationBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.startValuationBtn.mas_bottom).offset(16);
    }];

    /** 查询记录 */
    [self.valuationRecordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.usedCarTabBackView.mas_top);
        make.left.equalTo(self.usedCarTabBackView.mas_centerX);
        make.bottom.equalTo(self.usedCarTabBackView.mas_bottom);
        make.right.equalTo(self.usedCarTabBackView.mas_right);
    }];

}
- (void)updateConstraints {
    @weakify(self)
    /** 二手车查询标记view */
    [self.usedCarSignView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake((ScreenW / 2 - 32), 2));
        make.bottom.equalTo(self.usedCarTabView.mas_bottom);
    }];
    [super updateConstraints];
}


#pragma mark - 手势代理，解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 判断是不是tableview触发的手势
    PDLog(@"%@", touch.view);
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"ValuationRecordView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}

#pragma mark - 回收键盘的方法
- (void)benTabTapAction:(UIButton *)button {
    [self endEditing:YES];
}
#pragma mark - 输入框响应
- (void)usedCarValuationTextFieldSignal {
    /** 行驶里程 */
    RACSignal *mileageSignal = self.mileageView.viceTextFiled.rac_textSignal;
    // 判断行驶里程输入框最大输入位数
    RACSignal *mileageMaxNumber =
    [mileageSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    // 限制行驶里程输入框可输入位数
    RAC(self.mileageView.viceTextFiled, text) =
    [mileageMaxNumber map:^id(NSNumber *mileageTF){
        return [mileageTF boolValue] ? [self.mileageView.viceTextFiled.text substringToIndex:6] : self.mileageView.viceTextFiled.text;
    }];
    
    /** 车辆购入价 */
    RACSignal *carBuyPriceSignal = self.carBuyPriceView.viceTextFiled.rac_textSignal;
    // 判断行驶里程输入框最大输入位数
    RACSignal *carBuyPriceMaxNumber =
    [carBuyPriceSignal map:^id(NSString *text) {
        return @(text.length > 5);
    }];
    // 限制行驶里程输入框可输入位数
    RAC(self.carBuyPriceView.viceTextFiled, text) =
    [carBuyPriceMaxNumber map:^id(NSNumber *carBuyPriceTF){
        return [carBuyPriceTF boolValue] ? [self.carBuyPriceView.viceTextFiled.text substringToIndex:6] : self.carBuyPriceView.viceTextFiled.text;
    }];
}


@end
