//
//  CardCategoryDataSource.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardCategoryDataSource.h"

@implementation CardCategoryDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

// 请求会员卡类别数据
- (void)requestCardTypeData {
    // 次卡
    CardCategoryModel *numberCard = [[CardCategoryModel alloc] init];
    numberCard.name = @"次卡";
    numberCard.card_category_id = 1;
    // 储值卡
    CardCategoryModel *moneyCard = [[CardCategoryModel alloc] init];
    moneyCard.name = @"储值卡";
    moneyCard.card_category_id = 2;
    // 年卡
    CardCategoryModel *yearCard = [[CardCategoryModel alloc] init];
    yearCard.name = @"年卡";
    yearCard.card_category_id = 3;
    self.rowArray = (NSMutableArray *)@[numberCard, moneyCard, yearCard];
}

- (Class)tableViewCellClass {
    return [CardCategoryCell class];
}

// 重写下面这个方法，指定cell对应的数据模型
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    ((CardCategoryCell *)cell).cardCategoryModel = self.rowArray[indexPath.row];
    return cell;
}



@end
