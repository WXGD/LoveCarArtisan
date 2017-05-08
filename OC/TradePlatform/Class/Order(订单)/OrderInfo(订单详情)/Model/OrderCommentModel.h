//
//  OrderCommentModel.h
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderCommentModel : NSObject

/*  "score": "5"  #评价分数,
 "content": ""  #评价内容 */

/** 评价分数 */
@property (nonatomic, assign) float score;
/** 评价内容 */
@property (nonatomic, copy) NSString *content;

@end
