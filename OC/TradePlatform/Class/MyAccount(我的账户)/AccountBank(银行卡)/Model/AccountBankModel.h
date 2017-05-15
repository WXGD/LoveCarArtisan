//
//  AccountBankModel.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 {
 "default":
 {
 "provider_bank_account_id": 6  #银行账户列表id,
 "card_no": "6222100992993"  #卡号,
 "name": "李江"  #姓名,
 "bank": "中国银行"  #银行名称
 },
 "common":
 [
 {
 "provider_bank_account_id": 7,
 "card_no": "1029039393",
 "name": "许",
 "bank": "中国银行"
 }
 ]
 }
 **/
@class BankDefaultModel,BankCommonModel;
@interface AccountBankModel : NSObject

@property (nonatomic, strong) BankCommonModel *DefaultModel;

@property (nonatomic, strong) NSArray<BankCommonModel *> *common;
- (void)AccountBankRefreshRequestData:(UITableView *)tableView
                               params:(NSMutableDictionary *)params
                       viewController:(UIViewController *)viewController
                              success:(void (^)(AccountBankModel *accountBankModel))success;
@end
@interface BankDefaultModel : NSObject

@property (nonatomic, copy) NSString *card_no;

@property (nonatomic, copy) NSString *bank;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *provider_bank_account_id;

@end

@interface BankCommonModel : NSObject

@property (nonatomic, copy) NSString *card_no;

@property (nonatomic, copy) NSString *bank;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *provider_bank_account_id;

@end

