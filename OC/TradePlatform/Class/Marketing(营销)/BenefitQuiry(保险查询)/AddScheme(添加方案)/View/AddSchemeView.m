//
//  AddSchemeView.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddSchemeView.h"


@interface AddSchemeView ()<UITableViewDelegate, UITableViewDataSource>

/** 确认view */
@property (strong, nonatomic) UIView *confirmView;
/** 交强险 */
@property (strong, nonatomic) UILabel *forceBenefitTitle;
@property (strong, nonatomic) UIView *forceBenefitView;
@property (strong, nonatomic) UILabel *forceBenefitMainLabel;
/** 交强险 */
@property (strong, nonatomic) UISwitch *forceBenefitSwitch;
/** 商业险 */
@property (strong, nonatomic) UILabel *tradeBenefitTitle;
/** 商业险列表数据 */
@property (strong, nonatomic) NSMutableArray *bizSafeArray;

@end

@implementation AddSchemeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSchemeLayoutView];
    }
    return self;
}

#pragma mark - 保险数组set方法
- (void)setSafeTypeModel:(SafeTypeModel *)safeTypeModel {
    _safeTypeModel = safeTypeModel;
    // 商业险数据
    self.bizSafeArray = safeTypeModel.syx;
    [self.tradeBenefitTable reloadData];
    // 遍历交强险数据，默认选中交强险和车船税
    for (BenefitModel *benefitModel in safeTypeModel.jqx) {
        // 判断交强险是否选中
        if (benefitModel.is_cover == 1) {
            self.forceBenefitSwitch.on = YES;
        }else if (benefitModel.is_cover == 0) {
            self.forceBenefitSwitch.on = NO;
        }
    }
}
#pragma mark - 交强险选择点击按钮
- (void)forceBenefitSwitchAction:(UISwitch *)sender {
    // 遍历交强险数据，默认选中交强险和车船税
    for (BenefitModel *benefitModel in self.safeTypeModel.jqx) {
        // 判断交强险是否选中
        if (sender.isOn) {
            benefitModel.is_cover = 1;
        }else {
            benefitModel.is_cover = 0;
        }
    }
}

#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bizSafeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"addSchemeCell";
    AddSchemeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AddSchemeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.benefitModel = [self.bizSafeArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取当前选中cell
    AddSchemeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 获取当前选中模型
    BenefitModel *benefitModel = [self.bizSafeArray objectAtIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(addSchemeDidSelect:indexPath:cell:)]) {
        [_delegate addSchemeDidSelect:benefitModel indexPath:indexPath cell:cell];
    }
}

#pragma mark - view布局
- (void)addSchemeLayoutView {
    /** 提交view */
    self.confirmView = [[UIView alloc] init];
    self.confirmView.backgroundColor = WhiteColor;
    [self addSubview:self.confirmView];
    /** 提交查询btn */
    self.confirmAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmAddBtn.backgroundColor = ThemeColor;
    self.confirmAddBtn.layer.cornerRadius = 2;
    self.confirmAddBtn.clipsToBounds = YES;
    [self.confirmAddBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmAddBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.confirmAddBtn.layer.masksToBounds = YES;
    self.confirmAddBtn.layer.cornerRadius = 2;
    self.confirmAddBtn.titleLabel.font = SixteenTypeface;
    [self.confirmView addSubview:self.confirmAddBtn];
    /** 交强险 */
    self.forceBenefitTitle = [[UILabel alloc] init];
    self.forceBenefitTitle.text = @"交强险和车船税（国家规定的强制保险）";
    self.forceBenefitTitle.textColor = GrayH1;
    self.forceBenefitTitle.font = ThirteenTypeface;
    [self addSubview:self.forceBenefitTitle];
    
    self.forceBenefitView = [[UIView alloc] init];
    self.forceBenefitView.backgroundColor = WhiteColor;
    [self addSubview:self.forceBenefitView];

    self.forceBenefitMainLabel = [[UILabel alloc] init];
    self.forceBenefitMainLabel.text = @"交强险和车船税";
    self.forceBenefitMainLabel.textColor = Black;
    self.forceBenefitMainLabel.font = FourteenTypeface;
    [self.forceBenefitView addSubview:self.forceBenefitMainLabel];
    
    self.forceBenefitSwitch = [[UISwitch alloc] init];
    [self.forceBenefitSwitch addTarget:self action:@selector(forceBenefitSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.forceBenefitView addSubview:self.forceBenefitSwitch];
    /** 商业险 */
    self.tradeBenefitTitle = [[UILabel alloc] init];
    self.tradeBenefitTitle.text = @"商业险";
    self.tradeBenefitTitle.textColor = GrayH1;
    self.tradeBenefitTitle.font = ThirteenTypeface;
    [self addSubview:self.tradeBenefitTitle];
    /** 商业险Table */
    self.tradeBenefitTable = [[UITableView alloc] init];
    self.tradeBenefitTable.delegate = self;
    self.tradeBenefitTable.dataSource = self;
    self.tradeBenefitTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tradeBenefitTable.backgroundColor = CLEARCOLOR;
    self.tradeBenefitTable.rowHeight = 48;
    self.tradeBenefitTable.bounces = NO;
    [self addSubview:self.tradeBenefitTable];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 提交view */
    [self.confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 提交查询btn */
    [self.confirmAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.confirmView.mas_top).offset(5);
        make.left.equalTo(self.confirmView.mas_left).offset(16);
        make.bottom.equalTo(self.confirmView.mas_bottom).offset(-5);
        make.right.equalTo(self.confirmView.mas_right).offset(-16);
    }];
    
    /** 交强险 */
    [self.forceBenefitTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(16);
    }];
    [self.forceBenefitView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(40);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    [self.forceBenefitMainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.forceBenefitView.mas_centerY);
        make.left.equalTo(self.forceBenefitView.mas_left).offset(16);
    }];
    [self.forceBenefitSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.forceBenefitView.mas_centerY);
        make.right.equalTo(self.forceBenefitView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(53, 27));
    }];
    /** 商业险 */
    [self.tradeBenefitTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.forceBenefitView.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(16);
    }];
    /** 商业险Table */
    [self.tradeBenefitTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.forceBenefitView.mas_bottom).offset(40);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.confirmView.mas_top).offset(-0.5);
    }];
}

#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
- (void)addSchemeTapAction {
    [self endEditing:YES];
}

@end
