//
//  GJBaseTableViewCell.h
//  GJTabelView
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJBaseModel.h"

@interface GJBaseTableViewCell : UITableViewCell

/** 每一个cell的高度 */
+ (CGFloat)tableView:(UITableView*)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath;
/** 分区头的高度 */
+ (CGFloat)tableView:(UITableView*)tableView headerHeightInSection:(NSInteger)section;
/** 分区头内容 */
+ (UIView *)tableView:(UITableView*)tableView headerViewInSection:(NSInteger)section;
/** 数据模型 */
@property (nonatomic, strong) id baseModel;

@end
