//
//  GJBaseTabelView.h
//  GJTabelView
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJBaseDataSource.h"

@protocol GJTableViewDelegate<UITableViewDelegate>

@optional
/** cell点击方法 */
- (void)tableView:(UITableView *)tableView rowDidSelectAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GJBaseTabelView : UITableView <UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *rowArray;

@property (nonatomic, strong) id<GJBaseDataSourceDelegate>GJDataSource;
@property (nonatomic, assign) id<GJTableViewDelegate>GJDelegate;

@end
