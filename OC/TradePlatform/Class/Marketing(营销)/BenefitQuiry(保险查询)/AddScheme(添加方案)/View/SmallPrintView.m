//
//  SmallPrintView.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SmallPrintView.h"
// view
#import "SmallPrintCell.h"

@interface SmallPrintView ()<UITableViewDelegate, UITableViewDataSource>

/** 弹框view */
@property (strong, nonatomic) UIView *bombBoxView;
/** 头部view */
@property (strong, nonatomic) UIView *headerView;
/** 险种名称 */
@property (strong, nonatomic) UILabel *typeLabel;
/** 不计免赔view */
@property (strong, nonatomic) UIView *exceptView;
@property (strong, nonatomic) UILabel *exceptLable;
@property (strong, nonatomic) UISwitch *exceptSwitch;
/** 中间Table */
@property (strong, nonatomic) UITableView *middleTable;
/** 底部view */
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *confirmBtn;
/** 保存当前选中险种模型 */
@property (strong, nonatomic) BenefitModel *keepBenefitModel;


@end

@implementation SmallPrintView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        [self smallPrintLayoutView];
    }
    return self;
}

#pragma mark - 按钮点击方法
/** 取消 */
- (void)cancelBtnAction:(UIButton *)button {
    /** 取消 */
    if (_delegate && [_delegate respondsToSelector:@selector(cancelBtnDelegate:)]) {
        [_delegate cancelBtnDelegate:button];
    }
}
/** 确定 */
- (void)confirmBtnAction:(UIButton *)button {
    // 保存修改后的险种模型
    /** 险种ID */
    self.benefitModel.insurance_category_id = self.keepBenefitModel.insurance_category_id;
    /** 险种名称 */
    self.benefitModel.name = self.keepBenefitModel.name;
    /** 是否不计免陪 0：否；1：是, */
    self.benefitModel.is_free = self.keepBenefitModel.is_free;
    /** 是否枚举可选保额 0：否；1：是, */
    self.benefitModel.is_coverage = self.keepBenefitModel.is_coverage;
    /** 保额列表, */
    self.benefitModel.coverage = [NSMutableArray arrayWithArray:self.keepBenefitModel.coverage];
    /** 自加字段 */
    /** 是否投保 0：不投保；1：投保；2：投保（不计免赔）  */
    self.benefitModel.is_cover = self.keepBenefitModel.is_cover;
    /** 保额 */
    self.benefitModel.coverageDouble = self.keepBenefitModel.coverageDouble;
    /** 取消 */
    if (_delegate && [_delegate respondsToSelector:@selector(confirmBtnDelegate:)]) {
        [_delegate confirmBtnDelegate:button];
    }
}

#pragma mark - 赋值
// 保险模型set方法
- (void)setBenefitModel:(BenefitModel *)benefitModel {
    _benefitModel = benefitModel;
    // 拷贝一份保险险种信息
    self.keepBenefitModel = [[BenefitModel alloc] init];
    /** 险种ID */
    self.keepBenefitModel.insurance_category_id = benefitModel.insurance_category_id;
    /** 险种名称 */
    self.keepBenefitModel.name = benefitModel.name;
    /** 是否不计免陪 0：否；1：是, */
    self.keepBenefitModel.is_free = benefitModel.is_free;
    /** 是否枚举可选保额 0：否；1：是, */
    self.keepBenefitModel.is_coverage = benefitModel.is_coverage;
    /** 保额列表, */
    self.keepBenefitModel.coverage = [NSMutableArray arrayWithArray:benefitModel.coverage];
    /** 自加字段 */
    /** 是否投保 0：不投保；1：投保；2：投保（不计免赔）  */
    self.keepBenefitModel.is_cover = benefitModel.is_cover;
    /** 保额 */
    self.keepBenefitModel.coverageDouble = benefitModel.coverageDouble;
    /** 险种名称 */
    self.typeLabel.text = self.keepBenefitModel.name;
    /** 不计免赔view */
    if (self.keepBenefitModel.is_cover == 1) {
        self.exceptSwitch.on = NO;
    }
}




#pragma mark - 布局视图
- (void)smallPrintLayoutView {
    /** 弹框view */
    self.bombBoxView = [[UIView alloc] init];
    self.bombBoxView.backgroundColor = VCBackground;
    [self addSubview:self.bombBoxView];
    /** 头部view */
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor = WhiteColor;
    [self.bombBoxView addSubview:self.headerView];
    /** 险种view */
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.textColor = Black;
    self.typeLabel.font = SixteenTypefaceBold;
    [self.headerView addSubview:self.typeLabel];
    /** 不计免赔view */
    self.exceptView = [[UIView alloc] init];
    [self.bombBoxView addSubview:self.exceptView];

    self.exceptLable = [[UILabel alloc] init];
    self.exceptLable.text = @"不计免赔";
    self.exceptLable.textColor = Black;
    self.exceptLable.font = FourteenTypeface;
    [self.exceptView addSubview:self.exceptLable];

    self.exceptSwitch = [[UISwitch alloc] init];
    self.exceptSwitch.on = YES;
    [self.exceptView addSubview:self.exceptSwitch];
    /** 中间Table */
    self.middleTable = [[UITableView alloc] init];
    self.middleTable.delegate = self;
    self.middleTable.dataSource = self;
    self.middleTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.middleTable.backgroundColor = CLEARCOLOR;
    self.middleTable.rowHeight = 48;
    self.middleTable.bounces = NO;
    [self.bombBoxView addSubview:self.middleTable];
    /** 底部view */
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = WhiteColor;
    [self.bombBoxView addSubview:self.bottomView];
    /** 取消 */
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = SixteenTypeface;
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 2;
    self.cancelBtn.layer.borderWidth = 0.5;
    self.cancelBtn.layer.borderColor = ThemeColor.CGColor;
    self.cancelBtn.backgroundColor = WhiteColor;
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.cancelBtn];
    /** 确定 */
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font = SixteenTypeface;
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 2;
    self.confirmBtn.backgroundColor = ThemeColor;
    [self.confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.confirmBtn];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 弹框view */
    [self.bombBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.bottomView.mas_bottom);
    }];
    /** 头部view */
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.bombBoxView.mas_left);
        make.top.equalTo(self.bombBoxView.mas_top);
        make.right.equalTo(self.bombBoxView.mas_right);
        make.bottom.equalTo(self.exceptView.mas_bottom);
    }];
    /** 险种view */
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.headerView.mas_left).offset(16);
        make.top.equalTo(self.headerView.mas_top).offset(20);
    }];
    // 判断是否有不计免赔
    if (self.keepBenefitModel.is_free == 0) { // 没有
        // 隐藏不计免赔view
        [self.exceptView setHidden:YES];
        /** 不计免赔view */
        [self.exceptView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.bombBoxView.mas_left);
            make.top.equalTo(self.typeLabel.mas_bottom).offset(20);
            make.right.equalTo(self.bombBoxView.mas_right);
            make.height.mas_equalTo(@0);
        }];
    }else if (self.keepBenefitModel.is_free == 1) { // 有
        /** 不计免赔view */
        [self.exceptView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.bombBoxView.mas_left);
            make.top.equalTo(self.typeLabel.mas_bottom).offset(20);
            make.right.equalTo(self.bombBoxView.mas_right);
            make.height.mas_equalTo(@48);
        }];
        // 不隐藏不计免赔view
        [self.exceptView setHidden:NO];
    }
    [self.exceptLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.exceptView.mas_left).offset(16);
        make.centerY.equalTo(self.exceptView.mas_centerY);
    }];
    [self.exceptSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.exceptView.mas_right).offset(-16);
        make.centerY.equalTo(self.exceptView.mas_centerY);
    }];
    // 判断保额列表数据量
    if (self.keepBenefitModel.coverage.count > 4) {
        /** 中间Table */
        [self.middleTable mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.bombBoxView.mas_left);
            make.top.equalTo(self.headerView.mas_bottom).offset(10);
            make.right.equalTo(self.bombBoxView.mas_right);
            make.height.mas_equalTo(@(48 * 4 + 24));
        }];
    }else {
        /** 中间Table */
        [self.middleTable mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.equalTo(self.bombBoxView.mas_left);
            make.top.equalTo(self.headerView.mas_bottom).offset(10);
            make.right.equalTo(self.bombBoxView.mas_right);
            make.height.mas_equalTo(@(48 * self.keepBenefitModel.coverage.count));
        }];
    }
    /** 底部view */
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.middleTable.mas_bottom).offset(10);
        make.left.equalTo(self.bombBoxView.mas_left);
        make.right.equalTo(self.bombBoxView.mas_right);
        make.height.mas_equalTo(@50);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.left.equalTo(self.bottomView.mas_left).offset(16);
        make.width.equalTo(self.cancelBtn.mas_width);
        make.height.mas_equalTo(@40);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.left.equalTo(self.cancelBtn.mas_right).offset(32);
        make.right.equalTo(self.bottomView.mas_right).offset(-16);
        make.width.equalTo(self.cancelBtn.mas_width);
        make.height.mas_equalTo(@40);
    }];
}


#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.keepBenefitModel.coverage.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"smallPrintCell";
    SmallPrintCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SmallPrintCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.titleStr = [self.keepBenefitModel.coverage objectAtIndex:indexPath.row];
    cell.checkMark = NO;
    if (self.keepBenefitModel.is_cover == 0) {
        if ([cell.titleStr isEqualToString:@"不投保"]) {/** 保险模型 */
            cell.checkMark = YES;
        }
    }else {
        if ([cell.titleStr isEqualToString:@"不投保"]) {
            cell.checkMark = NO;
        }else if ([cell.titleStr doubleValue] == self.keepBenefitModel.coverageDouble || [cell.titleStr isEqualToString:@"投保"]) {
            cell.checkMark = YES;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSInteger isCover = 0;
//    double coverage = 0;
    if ([[self.keepBenefitModel.coverage objectAtIndex:indexPath.row] isEqualToString:@"不投保"]) {
        self.keepBenefitModel.is_cover = 0;
        self.keepBenefitModel.coverageDouble = 0;
    }else if ([[self.keepBenefitModel.coverage objectAtIndex:indexPath.row] isEqualToString:@"投保"]){
        if (self.keepBenefitModel.is_free == 1) {
            if (self.exceptSwitch.isOn){
                self.keepBenefitModel.is_cover = 2;
            }else {
                self.keepBenefitModel.is_cover = 1;
            }
        }else {
            self.keepBenefitModel.is_cover = 1;
        }
    }else {
        if (self.keepBenefitModel.is_free == 1) {
            if (self.exceptSwitch.isOn){
                self.keepBenefitModel.is_cover = 2;
                self.keepBenefitModel.coverageDouble = [[self.keepBenefitModel.coverage objectAtIndex:indexPath.row] doubleValue];
            }else {
                self.keepBenefitModel.is_cover = 1;
                self.keepBenefitModel.coverageDouble = [[self.keepBenefitModel.coverage objectAtIndex:indexPath.row] doubleValue];
            }
        }else {
            self.keepBenefitModel.is_cover = 1;
            self.keepBenefitModel.coverageDouble = [[self.keepBenefitModel.coverage objectAtIndex:indexPath.row] doubleValue];
        }
    }
    [self.middleTable reloadData];
}
#pragma mark - 显示
- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
    } completion:nil];
}

#pragma mark - 销毁
- (void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{
        
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}


@end
