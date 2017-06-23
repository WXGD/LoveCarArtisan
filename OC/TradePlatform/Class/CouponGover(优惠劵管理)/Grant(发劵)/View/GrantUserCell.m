//
//  GrantUserCell.m
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GrantUserCell.h"

@interface GrantUserCell ()

/** 用户信息view */
@property (nonatomic, strong) CustomCell *grantUsedCell;
/** 车牌view */
@property (nonatomic, strong) UIView *plnView;
/** 车牌号 */
@property (nonatomic, strong) UILabel *plnLabel;

@end

@implementation GrantUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 用户信息view */
        self.grantUsedCell = [[CustomCell alloc] init];
        self.grantUsedCell.lineStyle = FullScreenLayout;
        self.grantUsedCell.cellStyle = VerticallyLayoutHaveVImgAndNotVBtn;
        self.grantUsedCell.mainLabel.text = @"用户名";
        self.grantUsedCell.mainLabel.textColor = Black;
        self.grantUsedCell.mainLabel.font = FifteenTypeface;
        self.grantUsedCell.leftViceLabel.text = @"用户手机号";
        self.grantUsedCell.leftViceLabel.textColor = GrayH1;
        self.grantUsedCell.leftViceLabel.font = FourteenTypeface;
        [self.grantUsedCell.arrowImg setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        [self.grantUsedCell.arrowImg setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.grantUsedCell];
        [self.grantUsedCell.mainBtn setHidden:YES];
        /** 车牌view */
        self.plnView = [[UIView alloc] init];
        self.plnView.backgroundColor = HEXSTR_RGB(@"f0f9ff");
        self.plnView.layer.masksToBounds = YES;
        self.plnView.layer.cornerRadius = 2;
        self.plnView.layer.borderWidth = 0.5;
        self.plnView.layer.borderColor = DividingLine.CGColor;
        [self.contentView addSubview:self.plnView];
        [self.plnView setHidden:YES];
        /** 车牌号 */
        self.plnLabel = [[UILabel alloc] init];
        self.plnLabel.textColor = Black;
        self.plnLabel.font = TwelveTypeface;
        self.plnLabel.text = @"车牌号";
        [self.plnView addSubview:self.plnLabel];
    }
    return self;
}

- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
    /** 用户信息view */
    // 用户名
    self.grantUsedCell.mainLabel.text = userModel.name;
    // 用户手机号
    self.grantUsedCell.leftViceLabel.text = userModel.mobile;
    // 用户选中标记
    self.grantUsedCell.arrowImg.selected = userModel.checkMark;
    /** 车牌号 */
    if ([CustomObject isPlnNumber:userModel.car_plate_no]) {
        self.plnLabel.text = userModel.car_plate_no;
        [self.plnView setHidden:NO];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 用户信息view */
    [self.grantUsedCell mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    /** 车牌view */
    [self.plnView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.grantUsedCell.arrowImg.mas_left).offset(-16);
        make.centerY.equalTo(self.grantUsedCell.arrowImg.mas_centerY);
        make.left.equalTo(self.plnLabel.mas_left).offset(-10);
        make.height.mas_equalTo(@20);
    }];
    /** 车牌号 */
    [self.plnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.plnView.mas_centerY);
        make.centerX.equalTo(self.plnView.mas_centerX);
    }];
}



@end

