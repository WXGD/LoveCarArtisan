//
//  GrantRecordCell.h
//  TradePlatform
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrantRecordModel.h"

@interface GrantRecordCell : UITableViewCell

/** 发劵记录 */
@property (strong, nonatomic) GrantRecordModel *grantRecordModel;
/** 作废按钮 */
@property (strong, nonatomic) UIButton *invalidBtn;

@end
