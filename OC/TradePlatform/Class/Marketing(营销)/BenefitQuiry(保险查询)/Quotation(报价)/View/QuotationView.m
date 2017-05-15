//
//  QuotationView.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "QuotationView.h"
// view
#import "FirmQuotationCell.h"

@interface QuotationView ()<UITableViewDelegate, UITableViewDataSource>

/** 车辆信息 */
@property (strong, nonatomic) UIView *carInfoView;
/** 车牌号 */
@property (strong, nonatomic) UILabel *plnLabel;
/** 车辆品牌 */
@property (strong, nonatomic) UILabel *carBrandLabel;
/** 车辆所有人 */
@property (strong, nonatomic) UILabel *carholdManLabel;
/** 方案列表 */
@property (strong, nonatomic) UIScrollView *schemeScroll;
@property (strong, nonatomic) UIView *schemeBackView;
/** 当前选中方案 */
@property (strong, nonatomic) UIButton *currentSchemeBtn;
/** 方案标记 */
@property (strong, nonatomic) UIView *schemeSignView;
/** 保险内容 */
@property (strong, nonatomic) UIView *policyContentView;
/** 保险内容 */
@property (strong, nonatomic) UILabel *policyContentLabel;
/** 报价公司 */
@property (strong, nonatomic) UITableView *quotationFirmTable;
/** 各方案银行数据 */
@property (strong, nonatomic) NSMutableArray *bankArray;
@end

@implementation QuotationView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self quotationLayoutView];
    }
    return self;
}
#pragma mark - 按钮点击方法
// 方案点击
- (void)schemeBtnAction:(UIButton *)button {
    self.currentSchemeBtn.selected = NO;
    self.currentSchemeBtn = button;
    self.currentSchemeBtn.selected = YES;
    /** 方案标记 */
    UIButton *btn = [self viewWithTag:button.tag];
    [self.schemeSignView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.schemeBackView.mas_bottom);
        make.height.mas_equalTo(@2);
        make.left.equalTo(btn.mas_left).offset(8);
        make.right.equalTo(btn.mas_right).offset(-8);
    }];
    /** 各方案信息 */
    PDLog(@"%ld",(long)button.tag);
    QuotationModel *quotationModel = self.dataArray[button.tag-2130];
    self.policyContentLabel.text = quotationModel.insurance_categorys;
    self.bankArray = quotationModel.insurance_quote.mutableCopy;
    [_quotationFirmTable reloadData];
}

#pragma mark - 方案数
- (void)setSchemeArray:(NSMutableArray *)schemeArray {
    _schemeArray = schemeArray;
    for (int i = 0; i < schemeArray.count; i++) {
        NSString *btnTitle = [schemeArray objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:GrayH1 forState:UIControlStateNormal];
        [btn setTitleColor:ThemeColor forState:UIControlStateSelected];
        btn.backgroundColor = HEXSTR_RGB(@"fafafa");
        btn.titleLabel.font = FourteenTypeface;
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.tag = 2130 + i;
        [btn addTarget:self action:@selector(schemeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.schemeBackView addSubview:btn];
        @weakify(self)
        /** 车辆信息 */
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.schemeBackView.mas_left).offset(62 * i);
            make.top.equalTo(self.schemeBackView.mas_top);
            make.bottom.equalTo(self.schemeBackView.mas_bottom);
            make.width.mas_equalTo(@62);
        }];
    }
    /** 方案标记 */
    UIButton *btn = [self viewWithTag:2130];
    btn.selected = YES;
    // 保存当前选中方案
    self.currentSchemeBtn = btn;
    [self.schemeSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btn.mas_bottom);
        make.height.mas_equalTo(@2);
        make.left.equalTo(btn.mas_left).offset(8);
        make.right.equalTo(btn.mas_right).offset(-8);
    }];
}
#pragma mark - 方案数据初始化
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    if (dataArray.count > 0) {
        QuotationModel *quotationModel = self.dataArray[0];
        self.policyContentLabel.text = quotationModel.insurance_categorys;
        self.bankArray = quotationModel.insurance_quote.mutableCopy;
        [_quotationFirmTable reloadData];
    }
}
#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bankArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"quotationFirmCell";
    FirmQuotationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FirmQuotationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.insuranceQuoteModel = _bankArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_policyDetail) {
        _policyDetail(_bankArray[indexPath.row]);
    }
}


#pragma mark - view布局
- (void)quotationLayoutView {
    /** 车辆信息 */
    self.carInfoView = [[UIView alloc] init];
    self.carInfoView.backgroundColor = WhiteColor;
    [self addSubview:self.carInfoView];
    /** 车牌号 */
    self.plnLabel = [[UILabel alloc] init];
    self.plnLabel.text = @"车牌号";
    self.plnLabel.textColor = Black;
    self.plnLabel.font = FourteenTypeface;
    [self addSubview:self.plnLabel];
    /** 车辆品牌 */
    self.carBrandLabel = [[UILabel alloc] init];
    self.carBrandLabel.text = @"车辆品牌";
    self.carBrandLabel.textColor = GrayH2;
    self.carBrandLabel.font = TwelveTypeface;
    [self addSubview:self.carBrandLabel];
    /** 车辆所有人 */
    self.carholdManLabel = [[UILabel alloc] init];
    self.carholdManLabel.text = @"车辆所有人";
    self.carholdManLabel.textColor = GrayH1;
    self.carholdManLabel.font = FourteenTypeface;
    [self addSubview:self.carholdManLabel];
    /** 方案列表 */
    self.schemeScroll = [[UIScrollView alloc] init];
    self.schemeScroll.backgroundColor = HEXSTR_RGB(@"fafafa");
    self.schemeScroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.schemeScroll];
    
    self.schemeBackView = [[UIView alloc] init];
    [self.schemeScroll addSubview:self.schemeBackView];
    /** 方案标记 */
    self.schemeSignView = [[UIView alloc] init];
    self.schemeSignView.backgroundColor = ThemeColor;
    [self.schemeScroll addSubview:self.schemeSignView];
    /** 保险内容 */
    self.policyContentView = [[UIView alloc] init];
    self.policyContentView.backgroundColor = WhiteColor;
    [self addSubview:self.policyContentView];
    /** 保险内容 */
    self.policyContentLabel = [[UILabel alloc] init];
    self.policyContentLabel.text = @"";
    self.policyContentLabel.textColor = GrayH1;
    self.policyContentLabel.font = TwelveTypeface;
    self.policyContentLabel.numberOfLines = 0;
    [self addSubview:self.policyContentLabel];
    /** 报价公司 */
    self.quotationFirmTable = [[UITableView alloc] init];
    self.quotationFirmTable.delegate = self;
    self.quotationFirmTable.dataSource = self;
    self.quotationFirmTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.quotationFirmTable.backgroundColor = CLEARCOLOR;
    self.quotationFirmTable.rowHeight = 72;
    [self addSubview:self.quotationFirmTable];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 车辆信息 */
    [self.carInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.carBrandLabel.mas_bottom).offset(20);
    }];
    /** 车牌号 */
    [self.plnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.carInfoView.mas_left).offset(16);
        make.top.equalTo(self.carInfoView.mas_top).offset(20);
    }];
    /** 车辆品牌 */
    [self.carBrandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.plnLabel.mas_left);
        make.top.equalTo(self.plnLabel.mas_bottom).offset(10);
    }];
    /** 车辆所有人 */
    [self.carholdManLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnLabel.mas_centerY);
        make.right.equalTo(self.carInfoView.mas_right).offset(-16);
    }];
    /** 方案列表 */
    [self.schemeScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.carInfoView.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@44);
    }];
    [self.schemeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.schemeScroll.mas_top);
        make.left.equalTo(self.schemeScroll.mas_left);
        make.bottom.equalTo(self.schemeScroll.mas_bottom);
        make.right.equalTo(self.schemeScroll.mas_right);
        make.height.equalTo(self.schemeScroll.mas_height);
//        make.width.equalTo(self.schemeScroll.mas_width);
        make.width.mas_equalTo(@(62 * self.schemeArray.count));
    }];
    /** 保险内容 */
    [self.policyContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.schemeScroll.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.policyContentLabel.mas_bottom).offset(20);
    }];
    /** 保险内容 */
    [self.policyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.policyContentView.mas_left).offset(16);
        make.top.equalTo(self.policyContentView.mas_top).offset(20);
        make.right.equalTo(self.policyContentView.mas_right).offset(-16);
    }];
    /** 报价公司 */
    [self.quotationFirmTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.policyContentView.mas_bottom).offset(0.5);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
/** 车辆信息 */
-(void)setInquiryModel:(InquiryRecordModel *)inquiryModel{
    _inquiryModel = inquiryModel;
    _plnLabel.text = inquiryModel.car_plate_no;
    _carBrandLabel.text = inquiryModel.license_brand_model;
    _carholdManLabel.text = inquiryModel.name;
}
@end
