//
//  SmallPrintCell.h
//  TradePlatform
//
//  Created by apple on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallPrintCell : UITableViewCell

/** 标题 */
@property (copy, nonatomic) NSString *titleStr;
/** 选中标记 */
@property (nonatomic, assign) BOOL checkMark;

@end
