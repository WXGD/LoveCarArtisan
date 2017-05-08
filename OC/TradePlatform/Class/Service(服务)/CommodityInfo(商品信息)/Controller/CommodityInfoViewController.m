//
//  CommodityInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommodityInfoViewController.h"
// view
#import "CommodityInfoView.h"


@interface CommodityInfoViewController ()

/** 商品信息View */
@property (strong, nonatomic) CommodityInfoView *commodityInfoView;

@end

@implementation CommodityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局视图
    [self commodityInfolayoutView];
    // 布局NAV
    [self commodityInfoLayoutNav];
    // 界面赋值
    [self commodityInfoAssignment];
}

#pragma mark - 点击方法
- (void)commodityInfoBtnAction:(UIButton *)button {
    switch (button.tag) {
            /** 商品名称 */
        case CommodityNameBtnAction:{
            EditCommodityViewController *editCommodityVC = [[EditCommodityViewController alloc] init];
            editCommodityVC.commodityShowModel = self.commodityShowModel;
            editCommodityVC.changeCommodityInfoType = ChangeCommodityNameAssignment;
            editCommodityVC.editCommoditySuccessBlock = ^(NSString *editContent) {
                /** 商品名称 */
                self.commodityInfoView.commodityName.describeLabel.text = editContent;
                self.commodityShowModel.name = editContent;
            };
            [self.navigationController pushViewController:editCommodityVC animated:YES];
            break;
        }
            /** 销售价 */
        case PresentPriceBtnAction:{
            EditCommodityViewController *editCommodityVC = [[EditCommodityViewController alloc] init];
            editCommodityVC.commodityShowModel = self.commodityShowModel;
            editCommodityVC.changeCommodityInfoType = ChangePresentPriceAssignment;
            editCommodityVC.editCommoditySuccessBlock = ^(NSString *editContent) {
                /** 销售价 */
                self.commodityInfoView.presentPrice.describeLabel.text = [NSString stringWithFormat:@"%.2f", [editContent doubleValue]];
                self.commodityShowModel.sale_price = [editContent doubleValue];
            };
            [self.navigationController pushViewController:editCommodityVC animated:YES];
            break;
            
        }
            /** 原价 */
        case OriginalPriceBtnAction:{
            EditCommodityViewController *editCommodityVC = [[EditCommodityViewController alloc] init];
            editCommodityVC.commodityShowModel = self.commodityShowModel;
            editCommodityVC.changeCommodityInfoType = ChangeOriginalPriceAssignment;
            editCommodityVC.editCommoditySuccessBlock = ^(NSString *editContent) {
                /** 原价 */
                self.commodityInfoView.originalPrice.describeLabel.text = [NSString stringWithFormat:@"%.2f", [editContent doubleValue]];
                self.commodityShowModel.price = [editContent doubleValue];
            };
            [self.navigationController pushViewController:editCommodityVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 界面赋值
- (void)commodityInfoAssignment {
    /** 商品名称 */
    self.commodityInfoView.commodityName.describeLabel.text = self.commodityShowModel.name;
    /** 销售价 */
    self.commodityInfoView.presentPrice.describeLabel.text = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.sale_price];
    /** 原价 */
    self.commodityInfoView.originalPrice.describeLabel.text = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.price];
}


#pragma mark - 布局nav
- (void)commodityInfoLayoutNav {
    self.navigationItem.title = @"服务详情";
}
#pragma mark - 布局视图
- (void)commodityInfolayoutView {
    /** 商品信息View */
    self.commodityInfoView = [[CommodityInfoView alloc] init];
    /** 商品名称 */
    [self.commodityInfoView.commodityName.usedCellBtn addTarget:self action:@selector(commodityInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 销售价 */
    [self.commodityInfoView.presentPrice.usedCellBtn addTarget:self action:@selector(commodityInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 原价 */
    [self.commodityInfoView.originalPrice.usedCellBtn addTarget:self action:@selector(commodityInfoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commodityInfoView];
    @weakify(self)
    [self.commodityInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
