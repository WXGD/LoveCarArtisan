//
//  GJBaseDataSource.h
//  GJTabelView
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GJBaseDataSourceDelegate <UITableViewDataSource>

@optional
/** 设置cell样式 */
// 设置成代理，主要是为了在GJBaseTabelView中可以调用
- (Class)tableViewCellClass;

@end

@interface GJBaseDataSource : NSObject<GJBaseDataSourceDelegate>
/** cell数 */
@property (nonatomic, strong) NSMutableArray *rowArray;
/** 分区数 */
@property (nonatomic, strong) NSArray *sectionArray;

@end
