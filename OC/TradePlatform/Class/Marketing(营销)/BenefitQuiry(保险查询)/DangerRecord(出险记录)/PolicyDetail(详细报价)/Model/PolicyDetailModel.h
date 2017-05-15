//
//  PolicyDetailModel.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InsuranceCategorysModel,JqxModel,JqxInsuranceCategorys,SyxModel,SyxInsuranceCategorys,InsuranceEndTimeModel,InsuranceStartTimeModel;
@interface PolicyDetailModel : NSObject

@property (nonatomic, strong) NSArray<InsuranceEndTimeModel *> *insurance_end_time;

@property (nonatomic, strong) NSArray<InsuranceStartTimeModel *> *insurance_start_time;

@property (nonatomic, strong) InsuranceCategorysModel *insurance_categorys;

-(void)PolicyDetailRefreshRequestData:(UITableView *)tableView params:(NSMutableDictionary *)params viewController:(UIViewController *)viewController success:(void (^)(PolicyDetailModel *))success;


@end

@interface InsuranceCategorysModel : NSObject

@property (nonatomic, strong) JqxModel *jqx;

@property (nonatomic, strong) SyxModel *syx;

@end

@interface JqxModel : NSObject

@property (nonatomic, copy) NSString *free;

@property (nonatomic, strong) NSArray<JqxInsuranceCategorys *> *insurance_categorys;

@end

@interface JqxInsuranceCategorys : NSObject

@property (nonatomic, assign) double coverage;

@property (nonatomic, copy) NSString *insurance_category_name;

@property (nonatomic, assign) NSInteger is_free;

@property (nonatomic, assign) double premium;

@end

@interface SyxModel : NSObject

@property (nonatomic, assign) NSInteger free;

@property (nonatomic, strong) NSArray<SyxInsuranceCategorys *> *insurance_categorys;

@end

@interface SyxInsuranceCategorys : NSObject

@property (nonatomic, assign) double coverage;

@property (nonatomic, copy) NSString *insurance_category_name;

@property (nonatomic, assign) NSInteger is_free;

@property (nonatomic, assign) double premium;

@end

@interface InsuranceEndTimeModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *used_by_time;

@end

@interface InsuranceStartTimeModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *restart_by_time;

@end
