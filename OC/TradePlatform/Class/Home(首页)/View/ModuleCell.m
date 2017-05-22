//
//  ModuleCell.m
//  TradePlatform
//
//  Created by apple on 2017/5/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ModuleCell.h"

@implementation ModuleCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self moduleViewLayoutView];
    }
    return self;
}

#pragma mark - 数据set方法
- (void)setBtnArray:(NSArray *)btnArray {
    _btnArray = btnArray;
    switch (btnArray.count) {
        case 1:{
            ServiceModuleModel *module1 = [btnArray firstObject];
            /** 按钮1 */
            self.btnOne.moduleImage.image = [UIImage imageNamed:module1.image_url];
            self.btnOne.moduleLabel.text = module1.name;
            /** 按钮2 */
            [self.btnTwo setHidden:YES];
            /** 按钮3 */
            [self.btnThree setHidden:YES];
            break;
        }
        case 2:{
            ServiceModuleModel *module1 = [btnArray firstObject];
            ServiceModuleModel *module2 = [btnArray objectAtIndex:1];
            /** 按钮1 */
            self.btnOne.moduleImage.image = [UIImage imageNamed:module1.image_url];
            self.btnOne.moduleLabel.text = module1.name;
            /** 按钮2 */
            self.btnTwo.moduleImage.image = [UIImage imageNamed:module2.image_url];
            self.btnTwo.moduleLabel.text = module2.name;
            /** 按钮3 */
            [self.btnThree setHidden:YES];
            break;
        }
        case 3:{
            ServiceModuleModel *module1 = [btnArray firstObject];
            ServiceModuleModel *module2 = [btnArray objectAtIndex:1];
            ServiceModuleModel *module3 = [btnArray lastObject];
            /** 按钮1 */
            self.btnOne.moduleImage.image = [UIImage imageNamed:module1.image_url];
            self.btnOne.moduleLabel.text = module1.name;
            /** 按钮2 */
            self.btnTwo.moduleImage.image = [UIImage imageNamed:module2.image_url];
            self.btnTwo.moduleLabel.text = module2.name;
            /** 按钮3 */
            self.btnThree.moduleImage.image = [UIImage imageNamed:module3.image_url];
            self.btnThree.moduleLabel.text = module3.name;
            break;
        }
        default:
            break;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    /** 按钮1 */
    self.btnOne.moduleBtn.tag = 50000 + indexPath.section * 1000 + indexPath.row * 100 + 50 + 0;
    /** 按钮2 */
    self.btnTwo.moduleBtn.tag = 50000 + indexPath.section * 1000 + indexPath.row * 100 + 50 + 1;
    /** 按钮3 */
    self.btnThree.moduleBtn.tag = 50000 + indexPath.section * 1000 + indexPath.row * 100 + 50 + 2;
}

#pragma mark - view布局
- (void)moduleViewLayoutView {
    /** 按钮1 */
    self.btnOne = [[ModuleView alloc] init];
    [self addSubview:self.btnOne];
    /** 按钮2 */
    self.btnTwo = [[ModuleView alloc] init];
    [self addSubview:self.btnTwo];
    /** 按钮3 */
    self.btnThree = [[ModuleView alloc] init];
    [self addSubview:self.btnThree];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 按钮1 */
    [self.btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.btnOne.mas_width);
    }];
    /** 按钮2 */
    [self.btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.btnOne.mas_right);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.btnOne.mas_width);
    }];
    /** 按钮3 */
    [self.btnThree mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.btnTwo.mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.btnOne.mas_width);
    }];
}

@end
