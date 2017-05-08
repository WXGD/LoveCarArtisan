//
//  DateReportCell.m
//  TradePlatform
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DateReportCell.h"
#import "DateReportCellView.h"

@interface DateReportCell ()

/** 日期报表订单cellview */
@property (strong, nonatomic) DateReportCellView *dateReportCellView;

@end

@implementation DateReportCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CLEARCOLOR;
        /** 日期报表订单cellview */
        self.dateReportCellView = [[DateReportCellView alloc] init];
        [self.contentView addSubview:self.dateReportCellView];
    }
    return self;
}

- (void)setReportModel:(ReportModel *)reportModel {
    _reportModel = reportModel;
    /** 日期 */
    self.dateReportCellView.dateLable.text = reportModel.date;
    /** 客户数量 */
    self.dateReportCellView.customerNmuLable.text = [NSString stringWithFormat:@"%ld", (long)reportModel.count];
    /** 客户数量增长率 */
//    self.dateReportCellView.customerNmuGrowthRateLable.text = [NSString stringWithFormat:@"%@", @"a"];
    /** 交易额 */
    self.dateReportCellView.turnoverLable.text = [NSString stringWithFormat:@"%.2f", reportModel.amount];
    /** 交易额增长率 */
//    self.dateReportCellView.turnoverGrowthRateLable.text = [NSString stringWithFormat:@"%@", @"a"];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 日期报表订单cellview */
    [self.dateReportCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).offset(1);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - UITableViewDelegate需要的时候重写
//+ (CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}
//+ (CGFloat)tableView:(UITableView *)tableView headerHeightInSection:(NSInteger)section {
//    return 30;
//}
//+ (UIView *)tableView:(UITableView *)tableView headerViewInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor yellowColor];
//    return view;
//}

@end

