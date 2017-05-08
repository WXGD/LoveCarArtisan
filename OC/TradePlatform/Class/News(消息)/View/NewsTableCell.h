//
//  NewsTableCell.h
//  TradePlatform
//
//  Created by apple on 2017/2/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsTableCell : UITableViewCell

/** 消息数据模型 */
@property (strong, nonatomic) NewsModel *newsModel;

@end
