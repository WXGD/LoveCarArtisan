//
//  ConflictUserDetailsView.m
//  TradePlatform
//
//  Created by apple on 2017/3/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ConflictUserDetailsView.h"
// cell样式
#import "ConfictCarViewCell.h"
#import "ConfictCardViewCell.h"

@interface ConflictUserDetailsView ()<UITableViewDelegate, UITableViewDataSource>

/** 背景scrollview */
@property (strong, nonatomic) UIScrollView *conflictUserDetailsScrollView;


/** 基本信息标题 */
@property (strong, nonatomic) UIView *mainInfoView;
@property (strong, nonatomic) UILabel *mainInfoLabel;
/** 会员卡列表标题 */
@property (strong, nonatomic) UILabel *userCardLabel;
/** 车辆列表标题 */
@property (strong, nonatomic) UILabel *userCarLabel;

@end

@implementation ConflictUserDetailsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self conflictUserDetailsLayoutView];
    }
    return self;
}
#pragma mark - view布局
- (void)conflictUserDetailsLayoutView {
    /** 背景scrollview */
    self.conflictUserDetailsScrollView = [[UIScrollView alloc] init];
    self.conflictUserDetailsScrollView.backgroundColor = VCBackground;
    [self addSubview:self.conflictUserDetailsScrollView];
    /** 填充scrollview的view */
    self.conflictUserDetailsView = [[UIStackView alloc] init];
    self.conflictUserDetailsView.axis = UILayoutConstraintAxisVertical;
    [self.conflictUserDetailsScrollView addSubview:self.conflictUserDetailsView];
    
    /** 基本信息标题 */
    self.mainInfoView = [[UIView alloc] init];
    [self.conflictUserDetailsView addArrangedSubview:self.mainInfoView];
    self.mainInfoLabel = [[UILabel alloc] init];
    self.mainInfoLabel.textColor = GrayH1;
    self.mainInfoLabel.text = @"基本信息";
    self.mainInfoLabel.font = FourteenTypeface;
    [self.mainInfoView addSubview:self.mainInfoLabel];
    /** 姓名 */
    self.userNameView = [[UsedCellView alloc] init];
    self.userNameView.backgroundColor = WhiteColor;
    self.userNameView.cellLabel.text = @"姓名";
    self.userNameView.cellLabel.textColor = GrayH1;
    self.userNameView.cellLabel.font = FourteenTypeface;
    self.userNameView.describeLabel.textColor = Black;
    self.userNameView.describeLabel.font = FourteenTypeface;
    self.userNameView.dividingLineChoice = DividingLineFullScreenLayout;
    self.userNameView.isArrow = YES;
    self.userNameView.isCellImage = YES;
    self.userNameView.isCellBtn = YES;
    [self.conflictUserDetailsView addArrangedSubview:self.userNameView];
    /** 电话 */
    self.userPhoneView = [[UsedCellView alloc] init];
    self.userPhoneView.backgroundColor = WhiteColor;
    self.userPhoneView.cellLabel.text = @"电话";
    self.userPhoneView.cellLabel.textColor = GrayH1;
    self.userPhoneView.cellLabel.font = FourteenTypeface;
    self.userPhoneView.describeLabel.textColor = Black;
    self.userPhoneView.describeLabel.font = FourteenTypeface;
    self.userPhoneView.isSplistLine = YES;
    self.userPhoneView.isArrow = YES;
    self.userPhoneView.isCellImage = YES;
    self.userPhoneView.isCellBtn = YES;
    [self.conflictUserDetailsView addArrangedSubview:self.userPhoneView];
    /** 会员卡列表标题 */
    self.userCardView = [[UIView alloc] init];
    [self.conflictUserDetailsView addArrangedSubview:self.userCardView];
    self.userCardLabel = [[UILabel alloc] init];
    self.userCardLabel.font = FourteenTypeface;
    self.userCardLabel.textColor = GrayH1;
    self.userCardLabel.text = @"会员卡";
    [self.userCardView addSubview:self.userCardLabel];
    /** 会员卡列表数量 */
    self.userCardCountLabel = [[UILabel alloc] init];
    self.userCardCountLabel.font = TwelveTypeface;
    self.userCardCountLabel.textColor = ThemeColor;
    [self.userCardView addSubview:self.userCardCountLabel];
    /** 会员卡table */
    self.userCardTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.userCardTable.delegate = self;
    self.userCardTable.dataSource = self;
    self.userCardTable.backgroundColor = CLEARCOLOR;
    self.userCardTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userCardTable.bounces = NO;
    self.userCardTable.rowHeight = 109;
    [self.conflictUserDetailsView addArrangedSubview:self.userCardTable];
    /** 车辆列表标题 */
    self.userCarView = [[UIView alloc] init];
    [self.conflictUserDetailsView addArrangedSubview:self.userCarView];
    self.userCarLabel = [[UILabel alloc] init];
    self.userCarLabel.font = FourteenTypeface;
    self.userCarLabel.textColor = GrayH1;
    self.userCarLabel.text = @"车辆";
    [self.userCarView addSubview:self.userCarLabel];
    /**  车辆列表数量 */
    self.userCarCountLabel = [[UILabel alloc] init];
    self.userCarCountLabel.font = TwelveTypeface;
    self.userCarCountLabel.textColor = ThemeColor;
    [self.userCarView addSubview:self.userCarCountLabel];
    /** 车辆table */
    self.userCarTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.userCarTable.delegate = self;
    self.userCarTable.dataSource = self;
    self.userCarTable.backgroundColor = CLEARCOLOR;
    self.userCarTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userCarTable.bounces = NO;
    self.userCarTable.rowHeight = 50;
    [self.conflictUserDetailsView addArrangedSubview:self.userCarTable];
}


#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.userCarTable]) {
        return self.userCarArray.count;
    }else {
        return self.userCardArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.userCarTable]) {
        static NSString *cellID = @"ConfictCarViewCell";
        ConfictCarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ConfictCarViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.confictCarModel = [self.userCarArray objectAtIndex:indexPath.row];
        return cell;
    }else {
        static NSString *cellID = @"ConfictCardViewCell";
        ConfictCardViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ConfictCardViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.confictCardModel = [self.userCardArray objectAtIndex:indexPath.row];
        return cell;
    }
}



- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景scrollview */
    [self.conflictUserDetailsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 填充scrollview的view */
    [self.conflictUserDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.conflictUserDetailsScrollView.mas_top);
        make.left.equalTo(self.conflictUserDetailsScrollView.mas_left);
        make.bottom.equalTo(self.conflictUserDetailsScrollView.mas_bottom);
        make.right.equalTo(self.conflictUserDetailsScrollView.mas_right);
        make.width.equalTo(self.conflictUserDetailsScrollView.mas_width);
    }];
    
    /** 基本信息标题 */
    [self.mainInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    [self.mainInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mainInfoView.mas_centerY);
        make.left.equalTo(self.mainInfoView.mas_left).offset(16);
    }];
    /** 姓名 */
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 电话 */
    [self.userPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@50);
    }];
    /** 会员卡列表标题 */
    [self.userCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    [self.userCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userCardView.mas_centerY);
        make.left.equalTo(self.userCardView.mas_left).offset(16);
    }];
    /** 会员卡列表数量 */
    [self.userCardCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.userCardLabel.mas_centerY);
        make.left.equalTo(self.userCardLabel.mas_right).offset(8);
    }];
    /** 会员卡table */
    [self.userCardTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(109 * self.userCardArray.count));
    }];
    /** 车辆列表标题 */
    [self.userCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@40);
    }];
    [self.userCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userCarView.mas_centerY);
        make.left.equalTo(self.userCarView.mas_left).offset(16);
    }];
    /**  车辆列表数量 */
    [self.userCarCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.userCarLabel.mas_centerY);
        make.left.equalTo(self.userCarLabel.mas_right).offset(8);
    }];
    /** 车辆table */
    [self.userCarTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.height.mas_equalTo(@(50 * self.userCarArray.count));
    }];
    /** 填充scrollview的view的高度 */
    [self.conflictUserDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.userCarTable.mas_bottom);
    }];
}

@end
