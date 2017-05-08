//
//  GJBaseTabelView.m
//  GJTabelView
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GJBaseTabelView.h"
#import "GJBaseTableViewCell.h"

@implementation GJBaseTabelView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
    }
    return self;
}
- (void)setGJDataSource:(id<GJBaseDataSourceDelegate>)GJDataSource {
    if (_GJDataSource != GJDataSource) {
        _GJDataSource = GJDataSource;
        self.dataSource = GJDataSource;
    }
}
#pragma mark - UITableViewDelegate
/** 分区头高 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<GJBaseDataSourceDelegate> dataSource = (id<GJBaseDataSourceDelegate>)tableView.dataSource;
    Class cls = [dataSource tableViewCellClass];
    return [cls tableView:tableView headerHeightInSection:section];
}
/** cell高度 */
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    id<GJBaseDataSourceDelegate> dataSource = (id<GJBaseDataSourceDelegate>)tableView.dataSource;
    Class cls = [dataSource tableViewCellClass];
    return [cls tableView:tableView rowHeightAtIndexPath:indexPath];
}
/** 分区头内容 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<GJBaseDataSourceDelegate> dataSource = (id<GJBaseDataSourceDelegate>)tableView.dataSource;
    Class cls = [dataSource tableViewCellClass];
    return [cls tableView:tableView headerViewInSection:section];
}
/** cell点击方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_GJDelegate && [_GJDelegate respondsToSelector:@selector(tableView:rowDidSelectAtIndexPath:)]) {
        [_GJDelegate tableView:tableView rowDidSelectAtIndexPath:indexPath];
    }
}

@end
