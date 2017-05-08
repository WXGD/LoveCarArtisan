//
//  PendOrderCell.m
//  TradePlatform
//
//  Created by 祝豪杰 on 17/5/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PendOrderCell.h"
#import "PendOrderView.h"

@interface PendOrderCell ()
@property(weak, nonatomic) IBOutlet UIView *viewContent;
@property(weak, nonatomic) IBOutlet UILabel *labLeft;
@property(weak, nonatomic) IBOutlet UILabel *labright;
@property(weak, nonatomic) IBOutlet UILabel *labTotal;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewHeight;
@property(weak, nonatomic) IBOutlet UIButton *btnConfirmCash;
@property (weak, nonatomic) IBOutlet UIImageView *serviceTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *serviceTypeLab;

@end
@implementation PendOrderCell
- (IBAction)clickDelete:(UIButton *)sender {
  PDLog(@"删除");
  if (_deletependOrderClick) {
    _deletependOrderClick(_model, _indP);
  }
}
- (IBAction)clickConfirmCash:(id)sender {
  PDLog(@"确认收银");
  if (_confirmCashClick) {
    _confirmCashClick(_model, _indP);
  }
}

- (void)awakeFromNib {
  [super awakeFromNib];
  _btnConfirmCash.titleLabel.textColor = ThemeColor;
  _btnConfirmCash.layer.borderColor = ThemeColor.CGColor;
  _labLeft.font = TwelveTypeface;
  _labLeft.textColor = GrayH2;
  _labright.font = TwelveTypeface;
  _labright.textColor = GrayH2;
  _labTotal.font = ThirteenTypeface;
  _labTotal.textColor = Black;
}
- (void)setModel:(PendOrderModel *)model {
  _model = model;
  for (UIView *vi in [_viewContent subviews]) {
    [vi removeFromSuperview];
  }
  NSInteger count = model.detail.count;
  _constraintViewHeight.constant = count * 22; //内容高度22
    _labLeft.text = [NSString stringWithFormat:@"%@ %@",model.car_plate_no,model.mobile];
    _labright.text = model.create_time;
    _labTotal.text = [NSString stringWithFormat:@"合计：%.02f元",model.total_price];

    //服务内容
  for (int i = 0; i < count; i++) {
      ShoppingCartModel *detailModel = model.detail[i];
      CommodityShowStyleModel *goodModel = detailModel.goods;
      PendOrderView *vi = [[PendOrderView alloc] init];
      vi.labLeft.text = goodModel.goods_name;
      vi.labCenter.text = [NSString stringWithFormat:@"x %ld", (long)goodModel.buy_num];
      vi.labRight.text = [NSString stringWithFormat:@"%.02f元", goodModel.actual_sale_price];
      [_viewContent addSubview:vi];
      [vi mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(_viewContent.mas_left);
      make.right.equalTo(_viewContent.mas_right);
      make.top.equalTo(_viewContent.mas_top).offset(i * 22);
      make.height.mas_equalTo(@22);
    }];
  }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
