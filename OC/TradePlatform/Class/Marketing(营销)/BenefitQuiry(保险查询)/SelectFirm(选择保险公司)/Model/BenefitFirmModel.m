//
//  BenefitFirmModel.m
//  TradePlatform
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BenefitFirmModel.h"

@implementation BenefitFirmModel

// 请求保险公司
+ (void)requestBenefitFirmSuccess:(void(^)(NSMutableArray *benefitFirmArray))success {
    /* /index.php?c=insurance_company&a=list&v=1     */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_company", @"list", APIEdition];
    // 发送请求
    [TPNetRequest GET:URL parameters:nil ProgressHUD:@"加载中..." falseDate:@"success" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            NSMutableArray *benefitFirmArray = [BenefitFirmModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            // 请求成功
            if (success) {
                success(benefitFirmArray);
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
}



// 添加保险询价
+ (void)addBenefitInquiryParame:(NSMutableDictionary *)parame modifyImage:(UIImage *)modifyImage success:(void(^)())success {
    /*/index.php?c=insurance_query&a=add&v=2
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     car_plate_no 	string 	是 	车牌号
     license_brand_model 	string 	是 	车牌型号
     engine_num 	string 	是 	发动机号
     vin 	string 	是 	车架号
     register_time 	string 	是 	注册日期
     license_img 	file 	否 	上传图片的名称
     name 	string 	是 	所有人名称
     insurances_data 	string 	是 	险种信息，数据格式： 方案序号_车险id_是否免赔_保额，多个用逗号分割 eg: 1_1_1_20,1_2_0_0
     companys_data 	string 	是 	保险公司信息，数据格式：公司id集合，(多个用逗号分割）    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"insurance_query", @"add", APITWOEdition];
    // 拼接请求参数
    NSMutableDictionary *parameters = parame;
    // 发送请求
    [TPNetRequest tokenPOST:URL parameters:parameters ProgressHUD:@"加载中..." falseDate:nil parentController:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (modifyImage) {
            // 拼接文件数据
            NSData *data = UIImageJPEGRepresentation(modifyImage, 0.2);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"f.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            // 请求成功
            if (success) {
                success();
            }
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        PDLog(@"sigln%@", error);
        [MBProgressHUD showError:@"请求失败"];
    }];
}


@end
