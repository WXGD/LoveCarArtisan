//
//  RecordTableCell.h
//  TradePlatform
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WithdrawRecordModel.h"

@interface RecordTableCell : UITableViewCell

/** 体现记录模型 */
@property (strong, nonatomic) WithdrawRecordModel *withdrawRecordModel;

@end
