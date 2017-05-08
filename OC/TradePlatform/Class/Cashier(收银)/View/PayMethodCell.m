//
//  PayMethodCell.m
//  TradePlatform
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PayMethodCell.h"

@interface PayMethodCell ()

/** cell样式 */
@property (strong, nonatomic) UsedCellView  *payMethodView;

@end

@implementation PayMethodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /** cell样式 */
        self.payMethodView = [[UsedCellView alloc] init];
        self.payMethodView.isCellImageSize = YES;
        self.payMethodView.cellLabel.textColor = Black;
        self.payMethodView.cellLabel.font = FourteenTypeface;
        self.payMethodView.isCellBtn = YES;
        [self.contentView addSubview:self.payMethodView];
    }
    return self;
}

- (void)setPayMethodModel:(PaymentMethodModel *)payMethodModel {
    _payMethodModel = payMethodModel;
    self.payMethodView.cellImage.image = [UIImage imageNamed:payMethodModel.image_url];
    self.payMethodView.cellLabel.text = payMethodModel.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** cell样式 */
    [self.payMethodView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}


@end
