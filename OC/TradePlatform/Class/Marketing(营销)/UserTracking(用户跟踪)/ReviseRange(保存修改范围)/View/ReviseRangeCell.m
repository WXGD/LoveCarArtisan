//
//  ReviseRangeCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ReviseRangeCell.h"

@interface ReviseRangeCell ()


@end

@implementation ReviseRangeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self reviseRangeCellLayoutView];
    }
    return self;
}

- (void)reviseRangeCellLayoutView {
    /** cell样式 */
    self.rangeView = [[RangeView alloc] init];
    [self.rangeView.handleBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.rangeView.handleBtn setTitleColor:HEXSTR_RGB(@"ff6d00") forState:UIControlStateNormal];
    [self.rangeView.handleBtn setImage:[UIImage imageNamed:@"marketing_del"] forState:UIControlStateNormal];
    self.rangeView.startTF.enabled = NO;
    self.rangeView.endTF.enabled = NO;
    [self.contentView addSubview:self.rangeView];
}


- (void)setExpireModel:(ExpireModel *)expireModel {
    _expireModel = expireModel;
    /** 开始时间 */
    self.rangeView.startTF.text = [NSString stringWithFormat:@"%@%@", expireModel.min_value, expireModel.unit];
    /** 结束时间 */
    if ([expireModel.max_value doubleValue] == 0) {
        self.rangeView.endTF.text = @"最大值";
    }else{
        self.rangeView.endTF.text = [NSString stringWithFormat:@"%@%@", expireModel.max_value, expireModel.unit];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** cell样式 */
    [self.rangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
}

@end
