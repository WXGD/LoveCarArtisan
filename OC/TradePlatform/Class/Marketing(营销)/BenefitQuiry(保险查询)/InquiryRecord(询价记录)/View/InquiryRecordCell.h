//
//  InquiryRecordCell.h
//  TradePlatform
//
//  Created by 祝豪杰 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InquiryRecordModel.h"

@interface InquiryRecordCell : UITableViewCell
/** 询价model */
@property (strong, nonatomic) InquiryRecordModel *inquiryModel;
/** 车牌号 */
@property (weak, nonatomic) IBOutlet UILabel *carNumLab;
/** 出保状态 */
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
/** 车型 */
@property (weak, nonatomic) IBOutlet UILabel *carTypeLab;
/** 失败原因 */
@property (weak, nonatomic) IBOutlet UILabel *reasonLab;
/** 备注 */
@property (weak, nonatomic) IBOutlet UILabel *noteLab;
/** 原因高度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reasonHeightConst;
/** 查看保单高度约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lookDetailHeightConst;
/** 查看保单block */
@property(copy, nonatomic) void (^lookDetailClick)(InquiryRecordModel *inquiryModel);
@end
