//
//  ValuationRecordCell.m
//  TradePlatform
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ValuationRecordCell.h"
#import "ValuationRecordView.h"

@interface ValuationRecordCell ()

@property (strong, nonatomic) ValuationRecordView *valuationRecordView;

@end

@implementation ValuationRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = CLEARCOLOR;
        self.valuationRecordView = [[ValuationRecordView alloc] init];
        [self.contentView addSubview:self.valuationRecordView];
    }
    return self;
}


- (void)setValuationNotesModel:(ValuationNotesModel *)valuationNotesModel {
    _valuationNotesModel = valuationNotesModel;
    /** 车牌号 */
    self.valuationRecordView.plnLabel.text = valuationNotesModel.car_plate_no;
    /** 车牌型号 */
    self.valuationRecordView.carBrandLabel.text = valuationNotesModel.car_model_name;
    /** 车辆所在地区 */
    self.valuationRecordView.cityLabel.text = valuationNotesModel.city_name;
    /** 上牌时间 */
    self.valuationRecordView.failingTimeLabel.text = valuationNotesModel.create_time;
    /** 收购价格 */
    self.valuationRecordView.tecoveryPriceLabel.rightText.text = [NSString stringWithFormat:@"%.2f万", valuationNotesModel.purchase_price];
    /** 个人交易价格 */
    self.valuationRecordView.sellingPriceLabel.rightText.text = [NSString stringWithFormat:@"%.2f万", valuationNotesModel.deal_price];
    /** 估价失败 */
//    self.valuationRecordView.valuationErrorView.text = valuationNotesModel.car_plate_no;
}




- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.valuationRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}


@end
