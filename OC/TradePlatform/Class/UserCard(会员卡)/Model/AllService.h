//
//  AllService.h
//  TradePlatform
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllService : NSObject

/**
 "goods_categorey_id" =   ( );
 "goods_id" =                 ();
 "used_service_text" = "洗车222,美容1,";
 **/

/** 服务ID */
@property (nonatomic, strong) NSMutableArray *goods_category_id;
/** 商品ID */
@property (nonatomic, strong) NSMutableArray *goods_id;
/** 服务／商品名称 */
@property (nonatomic, copy) NSString *used_service_text;

@end
