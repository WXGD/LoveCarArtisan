//
//  EditStoreInfoViewController.h
//  TradePlatform
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 apple. All rights reserved.
//

// 编辑店面信息类型
typedef NS_ENUM(NSInteger, EditStoreInfoType) {
    /** 编辑店面名 */
    EditStoreName,
    /** 编辑店面客服电话 */
    EditStoreServicePhone,
    /** 编辑店面短信通知电话 */
    EditStoreNoticePhone,
    /** 编辑店面地址 */
    EditStoreAddress,
};


#import "RootViewController.h"
// 模型
#import "StoreModel.h"

@interface EditStoreInfoViewController : RootViewController

/** 编辑信息页面标题 */
@property (copy, nonatomic) NSString *navTitleStr;
/** 编辑信息类型标题 */
@property (copy, nonatomic) NSString *typeTitleStr;
/** 编辑信息提示文字 */
@property (copy, nonatomic) NSString *placeholderStr;
/** 编辑信息回显文字 */
@property (copy, nonatomic) NSString *echoStr;
/** 门店信息 */
@property (strong, nonatomic) StoreModel *storeModel;
/** 输入框响应类型 */
@property (assign, nonatomic) EditStoreInfoType editStoreInfoType;
/** 修改成功回调 */
@property (copy, nonatomic) void(^EditStoreInfoSuccess)(StoreModel *storeModel);

@end

