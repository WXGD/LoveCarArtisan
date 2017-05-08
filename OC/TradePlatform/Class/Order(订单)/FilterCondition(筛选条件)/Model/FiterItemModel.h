//
//  FiterItemModel.h
//  TradePlatform
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FiterItemModel : NSObject

/**  name = "服务";
 "id" = 2;   **/

/** 分类名称 */
@property (nonatomic, copy) NSString *name;
/** 分类名称 */
@property (nonatomic, assign) NSInteger ID;
/** 标记商品是否选中 */
@property (nonatomic, assign) BOOL checkMark;

@end
