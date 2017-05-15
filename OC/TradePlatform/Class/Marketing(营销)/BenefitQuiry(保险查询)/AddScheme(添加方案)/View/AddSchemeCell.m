//
//  AddSchemeCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddSchemeCell.h"

@interface AddSchemeCell ()

/** view */
@property (strong, nonatomic) UsedCellView *addSchemeView;
/** 保额 */
@property (strong, nonatomic) UILabel *coverageLabel;

@end

@implementation AddSchemeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        self.addSchemeView = [[UsedCellView alloc] init];
        self.addSchemeView.cellLabel.font = FourteenTypeface;
        self.addSchemeView.cellLabel.textColor = Black;
        self.addSchemeView.describeLabel.font = TwelveTypeface;
        self.addSchemeView.describeLabel.textColor = GrayH2;
        self.addSchemeView.isCellImage = YES;
        self.addSchemeView.isCellBtn = YES;
        self.addSchemeView.dividingLineChoice = DividingLineFullScreenLayout;
        [self.contentView addSubview:self.addSchemeView];
        /** 保额 */
        self.coverageLabel = [[UILabel alloc] init];
        self.coverageLabel.textColor = ThemeColor;
        self.coverageLabel.font = TwelveTypeface;
        [self.addSchemeView addSubview:self.coverageLabel];
    }
    return self;
}


- (void)setBenefitModel:(BenefitModel *)benefitModel {
    _benefitModel = benefitModel;
    /** 险种名称 */
    self.addSchemeView.cellLabel.text = benefitModel.name;
    /** 是否投保 0：不投保；1：投保；2：投保（不计免赔）  */
    switch (benefitModel.is_cover) {
        case 0: {
            self.addSchemeView.describeLabel.text = @"不投保";
            self.addSchemeView.describeLabel.textColor = GrayH2;
            /** 保额 */
            self.coverageLabel.text = @"";
            break;
        }
        case 1: {
            self.addSchemeView.describeLabel.text = @"投保";
            self.addSchemeView.describeLabel.textColor = GrayH1;
            /** 保额 */
            if (benefitModel.coverageDouble != 0) {
                self.coverageLabel.text = [NSString stringWithFormat:@"%.2f万", benefitModel.coverageDouble];
            }else {
                self.coverageLabel.text = @"";
            }
            break;
        }
        case 2: {
            self.addSchemeView.describeLabel.text = @"投保(不计免赔)";
            self.addSchemeView.describeLabel.textColor = GrayH1;
            /** 保额 */
            if (benefitModel.coverageDouble != 0) {
                self.coverageLabel.text = [NSString stringWithFormat:@"%.2f万", benefitModel.coverageDouble];
            }else {
                self.coverageLabel.text = @"";
            }
            break;
        }
        default:
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.addSchemeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    /** 保额 */
    [self.coverageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.addSchemeView.mas_centerY);
        make.right.equalTo(self.addSchemeView.describeLabel.mas_left).offset(-10);
    }];
}

@end
