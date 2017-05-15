//
//  DangerRecordCell.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DangerRecordModel.h"

@interface DangerRecordCell : UITableViewCell
@property (strong, nonatomic) DangerRecordModel *dangerModel;
/** 车牌号 */
@property (weak, nonatomic) IBOutlet UILabel *carNumLab;
/** 出保状态 */
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/** 车型 */
@property (weak, nonatomic) IBOutlet UILabel *carTypeLab;
/** 车险类型 */
@property (weak, nonatomic) IBOutlet UILabel *insuranceTypeLab;
/** 金额 */
@property (weak, nonatomic) IBOutlet UILabel *insuranceMoneyLab;
/** 生效日期 */
@property (weak, nonatomic) IBOutlet UILabel *effectiveDateLab;
/** 查看保单高度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lookDetailHeightConst;
/** 查看保单按钮 */
@property (weak, nonatomic) IBOutlet UIButton *lookDetailBtn;
/** 查看保单view */
@property (weak, nonatomic) IBOutlet UIView *lookDetailView;
/** 查看保单block */
@property(copy, nonatomic) void (^lookDetailClick)(NSString *str);
@end
