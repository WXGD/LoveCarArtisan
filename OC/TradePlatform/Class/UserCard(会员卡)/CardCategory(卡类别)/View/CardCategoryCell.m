//
//  CardCategoryCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardCategoryCell.h"

@interface CardCategoryCell ()

/** 选择标记 */
@property (strong, nonatomic) UIButton *chioceTitle;

@end

@implementation CardCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 选择标记 */
        self.chioceTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.chioceTitle setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        [self.chioceTitle setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.chioceTitle];
    }
    return self;
}

- (void)setCardCategoryModel:(CardCategoryModel *)cardCategoryModel {
    _cardCategoryModel = cardCategoryModel;
    self.textLabel.text = cardCategoryModel.name;
    self.chioceTitle.selected = cardCategoryModel.checkMark;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 选择标记 */
    [self.chioceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
}

#pragma mark - UITableViewDelegate需要的时候重写
//+ (CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath {
//    return 165;
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

