//
//  MarketingProjectModel.h
//  TradePlatform
//
//  Created by apple on 2017/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarketingProjectModel : NSObject

/** "marketing_project_logo" : "marketing_safest_logo",
 "marketing_project_name" : "保险查询",
 "marketing_project_name_title_color" : "#2c80ff",
 "marketing_project_vice_title" : "快速查询用户保险到期时间",
 "marketing_project_id" : "1",  **/


/** 营销项目logo */
@property (copy, nonatomic) NSString *marketing_project_logo;
/** 营销项目名称 */
@property (copy, nonatomic) NSString *marketing_project_name;
/** 营销项目名称字体颜色 */
@property (copy, nonatomic) NSString *marketing_project_name_title_color;
/** 营销项目副标题 */
@property (copy, nonatomic) NSString *marketing_project_vice_title;
/** 营销项目id(1:保险 2:二手车) */
@property (copy, nonatomic) NSString *marketing_project_id;


@end
