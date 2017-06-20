//
//  ChangeInfoViewController.h
//  TradePlatform
//
//  Created by apple on 2016/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

// 修改信息界面展示类型
typedef NS_ENUM(NSInteger, ChangeInfoExhibitionType) {
    /** 名称 */
    ChangeNameAssignment,
    /** 商户名称 */
    ChangeMerchantNameAssignment,
    /** 性别 */
    ChangeSexAssignment,
    /** 客服电话 */
    ChangePhoneAssignment,
    /** 短信通知电话 */
    ChangeMessagePhoneAssignment,
    /** 营业时间 */
    ChangeTimeAssignment,
    /** 地址 */
    ChangeAddressAssignment,
    /** 生日 */
    ChangeUserBirthdayAssignment,
    /** 会员车辆 */
    ChangeUserCarAssignment,
    /** 会员卡 */
    ChangeUserCodeAssignment,
    /** 会员电话 */
    ChangeUserPhoneAssignment,
    /** 修改密码 */
    ChangeUserDelPasswordAssignment,
    /** 修改车辆信息 */
    ChangeCarInfoAssignment,
};


#import "RootViewController.h"
#import "UserModel.h"
// 车辆信息模型
#import "UserCarModel.h"
#import "StoreModel.h"


@interface ChangeInfoViewController : RootViewController

/** 信息界面展示类型 */
@property (assign, nonatomic) ChangeInfoExhibitionType changeInfoExhibitionType;
/** 用户信息(修改用户信息时需要) */
@property (strong, nonatomic) UserModel *userInfo;
/** 门店信息 */
@property (strong, nonatomic) StoreModel *storeModel;
@property (copy, nonatomic) NSString *provider_user_id;
/** 用户车辆信息 */
@property (strong, nonatomic) UserCarModel *userCar;

/** 修改成功回调 */
@property (copy, nonatomic) void(^editSuccessBlock)(UserModel *userInfo);
/** 门店修改成功回调 */
@property (copy, nonatomic) void(^storeEditSuccessBlock)(StoreModel *storeModel);
@end
