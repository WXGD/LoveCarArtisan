//
//  GJBaseDataSource.m
//  GJTabelView
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GJBaseDataSource.h"
#import "GJBaseTableViewCell.h"
#import "GJBaseModel.h"
#import <objc/runtime.h>

@implementation GJBaseDataSource

// 子类实现，用来去定cell类型
- (Class)tableViewCellClass {
    return [GJBaseTableViewCell class];
}
#pragma mark - UITableViewDataSource
/** 分区数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray ? self.sectionArray.count : 1;
}
/** cell数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowArray ? self.rowArray.count : 0;
}
/** cell样式 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = [self tableViewCellClass];
    NSString *className = [NSString stringWithUTF8String:class_getName(class)];
    GJBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[class alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:className];
    }
    GJBaseModel *model = [self.rowArray objectAtIndex:indexPath.row];
    [cell setBaseModel:model];
    return cell;
}

@end

