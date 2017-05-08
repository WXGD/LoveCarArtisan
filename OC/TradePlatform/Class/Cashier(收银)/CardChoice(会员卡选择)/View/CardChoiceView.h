//
//  CardChoiceView.h
//  TradePlatform
//
//  Created by apple on 2017/1/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardChoicedidSelectDelegate <NSObject>

@optional
- (void)cardChoicedidSelectAction:(NSIndexPath *)indexPath;

@end

@interface CardChoiceView : UIView

/** 会员卡 */
@property (nonatomic, strong) NSMutableArray *cardArray;
/** 会员卡table */
@property (strong, nonatomic) UITableView *cardTableView;
/** 代理 */
@property (strong, nonatomic) id<CardChoicedidSelectDelegate>delegate;

@end
