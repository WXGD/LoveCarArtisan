//
//  ProvinceBtn.m
//  LoveCarEHome
//
//  Created by 弓杰 on 16/3/18.
//  Copyright © 2016年 弓杰. All rights reserved.
//

#import "ProvinceBtn.h"

@interface ProvinceBtn ()

@end

@implementation ProvinceBtn

+(ProvinceBtn *)loadBlueViewFromXIB {
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ProvinceBtn" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


- (IBAction)provinceBtnAction:(UIButton *)sender {
    
    //添加 字典，将label的值通过key值设置传递
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:sender.titleLabel.text, @"province", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"ProvinceBtnNotification" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}



- (NSString *)selectBtnProvince:(NSInteger)btnTag {
    
    switch (btnTag) {
        case 1450:{
            
            return @"京";
            break;
        }
        case 1451:{
            
            return @"沪";
            break;
        }
        case 1452:{
            
            return @"浙";
            break;
        }
        case 1453:{
            
            return @"苏";
            break;
        }
        case 1454:{
            
            return @"粤";
            break;
        }
        case 1455:{
            
            return @"鲁";
            break;
        }
        case 1456:{
            
            return @"晋";
            break;
        }
        case 1457:{
            
            return @"冀";
            break;
        }
        case 1458:{
            
            return @"豫";
            break;
        }
        case 1459:{
            
            return @"川";
            break;
        }
        case 1460:{
            
            return @"渝";
            break;
        }
        case 1461:{
            
            return @"辽";
            break;
        }
        case 1462:{
            
            return @"吉";
            break;
        }
        case 1463:{
            
            return @"黑";
            break;
        }
        case 1464:{
            
            return @"皖";
            break;
        }
        case 1465:{
            
            return @"鄂";
            break;
        }
        case 1466:{
            
            return @"湘";
            break;
        }
        case 1467:{
            
            return @"赣";
            break;
        }
        case 1468:{
            
            return @"闽";
            break;
        }
        case 1469:{
            
            return @"陕";
            break;
        }
        case 1470:{
            
            return @"甘";
            break;
        }
        case 1471:{
            
            return @"宁";
            break;
        }
        case 1472:{
            
            return @"蒙";
            break;
        }
        case 1473:{
            
            return @"津";
            break;
        }
        case 1474:{
            
            return @"贵";
            break;
        }
        case 1475:{
            
            return @"云";
            break;
        }
        case 1476:{
            
            return @"桂";
            break;
        }
        case 1477:{
            
            return @"琼";
            break;
        }
        case 1478:{
            
            return @"青";
            break;
        }
        case 1479:{
            
            return @"新";
            break;
        }
        case 1480:{
            
            return @"藏";
            break;
        }
        case 1481:{
            
            return @"港";
            break;
        }
        case 1482:{
            
            return @"澳";
            break;
        }
        case 1483:{
            
            return nil;
            break;
        }
        case 1484:{
            
            return nil;
            break;
        }
        case 1485:{
            
            return nil;
            break;
        }
        default:
            break;
    }
    return nil;
}

@end
