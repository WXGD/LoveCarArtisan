//
//  CardApplyView.m
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardApplyView.h"
#import "CardApplyCommodityCellView.h"

@interface CardApplyView () <UITableViewDelegate, UITableViewDataSource>

/** 服务项目区头 */
@property (strong, nonatomic) UIView *headerView;
/** 服务项目标题 */
@property (strong, nonatomic) UILabel *serviceTitle;
/** 服务项目选中标记 */
@property (strong, nonatomic) UIButton *serviceChoiceBtn;
/** 服务项目选择 */
@property (strong, nonatomic) UIButton *headerBtn;

@end

@implementation CardApplyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.chooseCommodityArray = [[NSMutableArray alloc] init];
        self.chooseServiceArray = [[NSMutableArray alloc] init];
        [self cardApplyLayoutView];
    }
    return self;
}

- (void)setCommodityScrvieStr:(ServiceProviderModel *)commodityScrvieStr {
    _commodityScrvieStr = commodityScrvieStr;
    self.serviceTitle.text = [NSString stringWithFormat:@"全部%@服务", self.commodityScrvieStr.name];
    if (commodityScrvieStr.checkMark) {
        self.serviceChoiceBtn.selected = YES;
        self.commodityTable.userInteractionEnabled = NO;
        [self.commodityTable reloadData];
    }
}


#pragma mark - view布局
- (void)cardApplyLayoutView {
    
    /** 服务项目区头 */
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    self.headerView.backgroundColor = VCBackground;
    [self addSubview:self.headerView];
    /** 服务项目标题 */
    self.serviceTitle = [[UILabel alloc] init];
    self.serviceTitle.textColor = GrayH2;
    self.serviceTitle.font = TwelveTypeface;
    [self.headerView addSubview:self.serviceTitle];
    /** 服务项目选中标记 */
    self.serviceChoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceChoiceBtn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [self.serviceChoiceBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.headerView addSubview:self.serviceChoiceBtn];
    /** 服务项目选择 */
    self.headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headerBtn addTarget:self action:@selector(headerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.headerBtn];
    /** 服务类别 */
    self.serviceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, ScreenH) style:UITableViewStylePlain];
    self.serviceTable.delegate = self;
    self.serviceTable.dataSource = self;
    self.serviceTable.rowHeight = 50;
    [self addSubview:self.serviceTable];
    // tableview高度随数据高度变化而变化
    [self.serviceTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    /** 商品 */
    self.commodityTable = [[UITableView alloc] initWithFrame:CGRectMake(100, 0, 100, ScreenH) style:UITableViewStylePlain];
    self.commodityTable.delegate = self;
    self.commodityTable.dataSource = self;
    self.commodityTable.backgroundColor = CLEARCOLOR;
    self.commodityTable.rowHeight = 50;
    [self addSubview:self.commodityTable];
    // tableview高度随数据高度变化而变化
    [self.commodityTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 服务类别 */
    [self.serviceTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(@100);
    }];
    /** 服务项目区头 */
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.serviceTable.mas_right);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    /** 服务项目标题 */
    [self.serviceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.headerView.mas_centerY);
        make.centerX.equalTo(self.headerView.mas_centerX);
    }];
    /** 服务项目选中标记 */
    [self.serviceChoiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerView.mas_centerY);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
    }];
    /** 服务项目选择 */
    [self.headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView.mas_left);
        make.right.equalTo(self.headerView.mas_right);
        make.top.equalTo(self.headerView.mas_top);
        make.bottom.equalTo(self.headerView.mas_bottom);
    }];
    
    
    
    /** 商品 */
    [self.commodityTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.serviceTable.mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

#pragma mark - tablview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 判断是服务还是商品table
    if ([tableView isEqual:self.serviceTable]) {
        return 1;
    }else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 判断是服务还是商品table
    if ([tableView isEqual:self.serviceTable]) {
        return self.serviceArray.count;
    }else {
        return self.commodityArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 判断是服务还是商品table
    if ([tableView isEqual:self.serviceTable]) {
        static NSString *cellID = @"serviceTableViewCell";
        CardApplyCommodityCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CardApplyCommodityCellView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = VCBackground;
        }
        ServiceProviderModel *service = [self.serviceArray objectAtIndex:indexPath.row];
        cell.cardApplyName.text = service.name;
        cell.cardApplyName.highlightedTextColor = ThemeColor;
        [cell.commodityChoiceBtn setHidden:YES];
        return cell;
    }else {
        static NSString *cellID = @"commodityTableViewCell";
        CardApplyCommodityCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CardApplyCommodityCellView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        CommodityShowStyleModel *commodity = [self.commodityArray objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cardApplyName.text = commodity.name;
        cell.cardApplyName.font = TwelveTypeface;
        cell.commodityChoiceBtn.selected = NO;
        cell.commodityChoiceBtn.selected = commodity.checkMark;
        if (self.commodityTable.userInteractionEnabled) {
            cell.textLabel.textColor = Black;
        }else {
            cell.textLabel.textColor = GrayH1;
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 判断是服务还是商品table
    if ([tableView isEqual:self.serviceTable]) {
        // 获取当前选中服务项目cell
        CardApplyCommodityCellView *cell = [tableView cellForRowAtIndexPath:indexPath];
        // 判断点击的cell是不是当前选中的cell
        if (self.selectedServiceCell == cell) {
            return;
        }
        // 更换当前选中的cell
        self.selectedServiceCell = cell;
        self.serviceChoiceBtn.selected = NO;
        self.commodityTable.userInteractionEnabled = YES;
        [self.commodityTable reloadData];
        if (_delegate && [_delegate respondsToSelector:@selector(servicedidSelectIndexPath:)]) {
            [_delegate servicedidSelectIndexPath:indexPath];
        }
    }else {
        // 获取当前选中商品cell
        CardApplyCommodityCellView *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.commodityChoiceBtn.selected = !cell.commodityChoiceBtn.selected;
        // 获取当前商品模型
        CommodityShowStyleModel *commodity = [self.commodityArray objectAtIndex:indexPath.row];
        commodity.checkMark = !commodity.checkMark;
        if (commodity.checkMark) {
            [self.chooseCommodityArray addObject:commodity];
        }else {
            [self.chooseCommodityArray removeObject:commodity];
        }
    }
}


- (void)headerBtnAction:(UIButton *)button {
    // 选中当前服务项目
    self.serviceChoiceBtn.selected = !self.serviceChoiceBtn.selected;
    self.commodityTable.userInteractionEnabled = !self.commodityTable.userInteractionEnabled;
    // 获取当前商品模型
    NSIndexPath *indexPath = [self.serviceTable indexPathForSelectedRow];
    ServiceProviderModel *commodityType = [self.serviceArray objectAtIndex:indexPath.row];
    commodityType.checkMark = !commodityType.checkMark;
    // 取消之前商品的选中
    for (CommodityShowStyleModel *commodityShow in commodityType.goods) {
        commodityShow.checkMark = NO;
        [self.chooseCommodityArray removeObject:commodityShow];
    }
    // 刷新table
    [self.commodityTable reloadData];
    // 判断当前服务项目，是选中还是取消选中
    if (commodityType.checkMark) {
        [self.chooseServiceArray addObject:commodityType];
    }else {
        [self.chooseServiceArray removeObject:commodityType];
    }
}

@end
