//
//  GJBaseTableViewCell.m
//  GJTabelView
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GJBaseTableViewCell.h"

@implementation GJBaseTableViewCell

/** 重写数据模型set方法 */
- (void)setBaseModel:(GJBaseModel *)baseModel {
    _baseModel = baseModel;
    self.textLabel.text = baseModel.textLabel;
    self.detailTextLabel.text = baseModel.detailTextLabel;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:baseModel.imageView] placeholderImage:[UIImage imageNamed:@"banner640"]];
}
/** 每一个cell的高度 */
+ (CGFloat)tableView:(UITableView*)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
/** 分区头的高度 */
+ (CGFloat)tableView:(UITableView*)tableView headerHeightInSection:(NSInteger)section {
    return 0;
}
/** 分区头内容 */
+ (UIView *)tableView:(UITableView*)tableView headerViewInSection:(NSInteger)section {
    return nil;
}

@end
