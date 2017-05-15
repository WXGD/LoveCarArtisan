//
//  BenefitCarInfoModel.m
//  TradePlatform
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitCarInfoModel.h"

@implementation BenefitCarInfoModel


// 通过车牌号查询车辆信息接口
+ (void)usePlnQuiryCarInfo:(NSMutableDictionary *)params success:(void(^)(BenefitCarInfoModel *carInfo))success {
    /* /index.php?c=insurance_query&a=car_info&v=1
     provider_id 	int 	是 	服务商id
     car_plate_no 	int 	是 	车牌号       */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"car_info", APIEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = params;
    // 发送请求
    [TPNetRequest GET:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        PDLog(@"params%@", params);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            BenefitCarInfoModel *carInfo = [BenefitCarInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(carInfo);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}


// 上传行驶证图片，获取行驶证信息
+ (void)uploadDrivingLicenseImageRequestDrivingLicenseInfoImage:(UIImage *)modifyImage success:(void(^)(NSMutableDictionary *drivingLicenseInfo))success {
    
    NSString *URL = @"http://v.juhe.cn/certificates/query.php?key=a932cfbb0bc6bae2c415102e23ba0df4";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"cardType"] = @"6";
    [TPNetRequest tokenPOST:URL parameters:parameters ProgressHUD:@"正在识别图片..." falseDate:nil parentController:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        NSData *data = UIImageJPEGRepresentation(modifyImage, 0.2);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"f.jpg" mimeType:@"image/jpeg"];
    } success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"error_code"]] isEqualToString:@"0"]) {
            if (success) {
                success(responseObject[@"result"]);
            }
        }else {
            [MBProgressHUD showError:@"识别失败，请重新拍照"];
        }
    } failure:^(NSError *error) {
        PDLog(@"sigln%@", error);
        [MBProgressHUD showError:@"请求失败"];
    }];
}


@end
