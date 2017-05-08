//
//  AlertListCell.h
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertListModel.h"

@interface AlertListCell : UITableViewCell

/* 用户标签数据模型 */
@property (strong, nonatomic) AlertListModel *alertListModel;

@end
