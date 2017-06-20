//
//  EditUserInfoViewController.h
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

// 编辑用户信息类型
typedef NS_ENUM(NSInteger, EditUserInfoType) {
    /** 编辑用户姓名 */
    EditUserName,
    /** 编辑用户手机号 */
    EditUserPhone,
};


#import "RootViewController.h"
// 模型
#import "UserModel.h"

@interface EditUserInfoViewController : RootViewController

/** 编辑信息页面标题 */
@property (copy, nonatomic) NSString *navTitleStr;
/** 编辑信息类型标题 */
@property (copy, nonatomic) NSString *typeTitleStr;
/** 编辑信息提示文字 */
@property (copy, nonatomic) NSString *placeholderStr;
/** 编辑信息回显文字 */
@property (copy, nonatomic) NSString *echoStr;
/** 用户信息模型 */
@property (strong, nonatomic) UserModel *userModel;
/** 输入框响应类型 */
@property (assign, nonatomic) EditUserInfoType editUserInfoType;

@end
