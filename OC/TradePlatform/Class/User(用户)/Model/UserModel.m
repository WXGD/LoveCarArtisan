//
//  UserModel.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"car" : [UserCarModel class]};
}



- (void)setName:(NSString *)name {
    _name = name;
    if (name.length == 0) {
        _name = @"无姓名";
    }
}

// 给车牌号赋值
- (void)setCar_plate_no:(NSString *)car_plate_no {
    _car_plate_no = car_plate_no;
    if (car_plate_no.length > 2) {
        self.province_CAFTA = [car_plate_no substringToIndex:1]; //截取掉下标1之前的字符串
        self.car_plate_num = [car_plate_no substringFromIndex:1]; //截取掉下标1之后的字符串
    }
}

/** 获取用户手机号和车牌号 （开卡，自定义开卡） */
+ (void)requestUserPhoneAndPln:(NSMutableDictionary *)params success:(void(^)(UserModel *userInfo))success {
    /*/index.php?c=provider_user&a=user_info&v=1
     provider_id 	int 	是 	服务商id
     user_input 	string 	否 	用户输入的值      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"user_info", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在获取用户信息..." falseDate:@"providerUserDetails" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            UserModel *userInfo = [UserModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(userInfo);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}
/** 获取用户详细信息 （会员信息详情） */
+ (void)requestUserDetailsInfo:(NSMutableDictionary *)params success:(void(^)(UserModel *userInfo))success {
    /*/index.php?c=provider_user&a=detail&v=1
     provider_user_id 	int 	否 	用户id(通过用户列表获取用户信息时必传,开卡时不必传)
     provider_id 	int 	否 	服务商获取用户时必传，用户获取自身信息时不传
     mobile 	string 	否 	分配卡的时候必传     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"detail", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"正在获取用户信息..." falseDate:@"providerUserDetails" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 获取数据模型数组
            UserModel *userInfo = [UserModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(userInfo);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
    
}

/** 删除用户 （会员信息详情）*/
+ (void)deleteUserParams:(NSMutableDictionary *)params success:(void(^)())success {
    /*/index.php?c=provider_user&a=del&v=1
     provider_user_id 	int 	是 	删除用户的id      */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"provider_user", @"del", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest POST:URL parameters:parameters ProgressHUD:@"正在删除用户..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 请求成功
            if (success) {
                success();
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


@end


