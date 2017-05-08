//
//  CustomKeyboard.m
//  jianpan
//
//  Created by 爱车e家 on 16/4/6.
//  Copyright © 2016年 爱车e家. All rights reserved.
//

#import "CustomKeyboard.h"

@interface CustomKeyboard ()


@end

@implementation CustomKeyboard

+ (CustomKeyboard *)loadBlueViewFromXIB {
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CustomKeyboard" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

// 删除按钮
- (IBAction)buttonAction:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"customKeyboardDelete" object:nil];
}
// 选中
- (IBAction)choiceBtnAction:(UIButton *)sender {
    
    //添加 字典，将label的值通过key值设置传递
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:sender.titleLabel.text, @"choiceBtnContent", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"customKeyboardAddContent" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
// 下一步
- (IBAction)btnAction:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"customKeyboardNextStep" object:nil];
}


@end
