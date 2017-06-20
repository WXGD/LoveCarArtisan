//
//  AdminChoseCell.h
//  TradePlatform
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminChoseCell : UICollectionViewCell

/** 标题 */
@property (strong, nonatomic) UILabel *adminChoseTitleLabel;
/** cell标记（yes:已选择。no:未选择） */
@property (assign, nonatomic) BOOL isAdminSelected;
/** 删除管理按钮 */
@property (strong, nonatomic) UIButton *delAdminBtn;

@end
