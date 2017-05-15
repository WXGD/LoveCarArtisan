//
//  BenefitModel.h
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BenefitModel : NSObject

/*** coverage =                 (
 );
 "insurance_category_id": 3  #险种id,
 "name": "车船税险"  #险种名称,
 "is_free": 0  #是否不计免陪 0：否；1：是,
 "is_coverage": 1  #是否枚举可选保额。0：否；1：是, **/

/** 险种ID */
@property (assign, nonatomic) NSInteger insurance_category_id;
/** 险种名称 */
@property (copy, nonatomic) NSString *name;
/** 是否不计免陪 0：否；1：是, */
@property (assign, nonatomic) NSInteger is_free;
/** 是否枚举可选保额 0：否；1：是, */
@property (assign, nonatomic) NSInteger is_coverage;
/** 保额列表, */
@property (strong, nonatomic) NSMutableArray *coverage;
/** 自加字段 */
/** 是否投保 0：不投保；1：投保；2：投保（不计免赔）  */
@property (assign, nonatomic) NSInteger is_cover;
/** 保额 */
@property (assign, nonatomic) double coverageDouble;

@end
