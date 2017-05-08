//
//  UserCell.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserCell.h"

@interface UserCell ()

/** 用户信息view */
@property (nonatomic, strong) UsedCellView *usedCell;
/** 车牌view */
@property (nonatomic, strong) UIView *plnView;
/** 车牌号 */
@property (nonatomic, strong) UILabel *plnLabel;

@end

@implementation UserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** 用户信息view */
        self.usedCell = [[UsedCellView alloc] init];
        self.usedCell.usedCellTypeChoice = BigPictureVerticallyLayout;
        self.usedCell.cellLabel.font = FifteenTypeface;
        self.usedCell.viceLabel.textColor = GrayH1;
        self.usedCell.isCellBtn = YES;
        self.usedCell.isCellImage = YES;
//        self.usedCell.isArrow = YES;
        self.usedCell.dividingLineChoice = DividingLineFullScreenLayout;
        [self.contentView addSubview:self.usedCell];
        /** 车牌view */
        self.plnView = [[UIView alloc] init];
        self.plnView.backgroundColor = HEXSTR_RGB(@"f0f9ff");
        self.plnView.layer.masksToBounds = YES;
        self.plnView.layer.cornerRadius = 2;
        self.plnView.layer.borderWidth = 0.5;
        self.plnView.layer.borderColor = DividingLine.CGColor;
        [self.contentView addSubview:self.plnView];
        /** 车牌号 */
        self.plnLabel = [[UILabel alloc] init];
        self.plnLabel.textColor = Black;
        self.plnLabel.font = TwelveTypeface;
        [self.plnView addSubview:self.plnLabel];
    }
    return self;
}

- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
    /** 用户名称 */
    if (userModel.name && userModel.name.length !=0) {
        self.usedCell.cellLabel.text = userModel.name;
    }else {
        self.usedCell.cellLabel.text = @"无姓名";
    }
    /** 用户手机号 */
    self.usedCell.viceLabel.text = userModel.mobile;
    /** 用户头像 */
    [self.usedCell.cellImage setImageWithImageUrl:userModel.avatar_thumb perchImage:@"placeholder_search_user"];
    /** 用户车牌号 */
    if (userModel.car_plate_no.length == 0) {
        [self.plnView setHidden:YES];
    }else {
        [self.plnView setHidden:NO];
        self.plnLabel.text = userModel.car_plate_no;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 用户信息view */
    [self.usedCell mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    /** 车牌view */
    [self.plnView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.usedCell.arrowImage.mas_left).offset(-16);
        make.centerY.equalTo(self.usedCell.arrowImage.mas_centerY);
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

#pragma mark - UITableViewDelegate需要的时候重写
+ (CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}
//+ (CGFloat)tableView:(UITableView *)tableView headerHeightInSection:(NSInteger)section {
//    return 30;
//}
//+ (UIView *)tableView:(UITableView *)tableView headerViewInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor yellowColor];
//    return view;
//}

@end

