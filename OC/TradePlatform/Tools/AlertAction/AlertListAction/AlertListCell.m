//
//  AlertListCell.m
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AlertListCell.h"

@interface AlertListCell ()

/* 名称 */
@property (strong, nonatomic) UILabel *typeName;
/* 选中标记 */
@property (strong, nonatomic) UIButton *typeChoiceMark;
/* cell分割线 */
@property (strong, nonatomic) UIView *typeCellView;

@end

@implementation AlertListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self typeTableCellLayoutView];
    }
    return self;
}

- (void)typeTableCellLayoutView {
    /* 订单类型名称 */
    self.typeName = [[UILabel alloc] init];
    self.typeName.font = FourteenTypeface;
    self.typeName.textColor = Black;
    [self.contentView addSubview:self.typeName];
    /* 订单类型选中标记 */
    self.typeChoiceMark = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.typeChoiceMark setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [self.typeChoiceMark setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [self.typeChoiceMark setTitleColor:GrayH1 forState:UIControlStateNormal];
    self.typeChoiceMark.titleLabel.font = FourteenTypeface;
    [self.contentView addSubview:self.typeChoiceMark];
    /* 订单类型cell分割线 */
    self.typeCellView = [[UIView alloc] init];
    self.typeCellView.backgroundColor = GrayH1;
    [self.contentView addSubview:self.typeCellView];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /* 服务项目名称 */
    [self.typeName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(30);
    }];
    /** 箭头 */
    [self.typeChoiceMark mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    /* 订单类型cell分割线 */
    [self.typeCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.contentView.mas_right);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
}

- (void)setAlertListModel:(AlertListModel *)alertListModel {
    _alertListModel = alertListModel;
    /* 服务项目名称 */
    self.typeName.text = alertListModel.chioceCategoriesName;
    /** 选中标记 */
    self.typeChoiceMark.selected = alertListModel.currentTitle;
}

@end
