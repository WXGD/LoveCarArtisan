//
//  CardInfoViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardInfoViewController.h"
// view
#import "CardInfoView.h"
// 会员卡类型
#import "CardCategoryDataSource.h"
// 下级控制器
#import "CardCategoryViewController.h"
#import "CardInfoChangeViewController.h"
#import "CardApplyViewController.h"
// 模型
#import "AllGoodsHandle.h"

@interface CardInfoViewController ()

/** 卡详情view */
@property (strong, nonatomic) CardInfoView *cardInfoView;
/** 卡类别数据 */
@property (strong, nonatomic) NSMutableArray *cardCategoryArray;
/** 默认展示会员卡类别 */
@property (strong, nonatomic) CardCategoryModel *defaultCardCategory;

/** 选中的商品 */
@property (strong, nonatomic) NSMutableArray *chooseCommodityArray;
/** 选中的服务 */
@property (strong, nonatomic) NSMutableArray *chooseServiceArray;
/** 全部服务商品 */
@property (strong, nonatomic) NSMutableArray *wholeCommodityArray;


@end

@implementation CardInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self cardInfoLayoutNAV];
    // 布局视图
    [self cardInfoLayoutView];
    // 界面赋值
    [self cardInfoAssignment];
    // 获取会员卡类别
    [self requestCardType];
}
#pragma mark - 网络请求
// 获取会员卡类别
- (void)requestCardType {
    CardCategoryDataSource *cardCategory = [[CardCategoryDataSource alloc] init];
    [cardCategory requestCardTypeData];
    self.cardCategoryArray = cardCategory.rowArray;
    // 遍历所有会员卡类别，展示当前会员卡类别
    for (CardCategoryModel *cardCategory in self.cardCategoryArray) {
        if (cardCategory.card_category_id == self.cardTypeInfoModel.card_category_id) {
            /** 卡类别view */
            self.cardInfoView.cardTypeView.describeLabel.text = cardCategory.name;
            // 获取默认展示会员卡类别
            self.defaultCardCategory = cardCategory;
        }
    }
}

#pragma mark - 按钮点击方法
// nav左边按钮
- (void)cardInfoLeftBarBtnAction {
    if (_CardInfoBlock) {
        _CardInfoBlock(self.cardTypeInfoModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 卡详情页功能选择按钮
- (void)cardInfoBtnAvtion:(UIButton *)button {
    switch (button.tag) {
            /** 卡名称view */
        case CardNameBtnAction: {
            CardInfoChangeViewController *cardInfoChangeVC = [[CardInfoChangeViewController alloc] init];
            /** 卡信息模型 */
            cardInfoChangeVC.cardInfoModel = self.cardTypeInfoModel;
            /** 卡信息界面展示类型 */
            cardInfoChangeVC.changeCardInfoType = ChangeCardNameAssignment;
            /** 修改成功回调 */
            cardInfoChangeVC.CardInfoChangeSuccessBlock = ^(CardTypeModel *cardInfoModel) {
                /** 卡名称view */
                self.cardInfoView.cardNameView.describeLabel.text = cardInfoModel.name;
                self.cardTypeInfoModel.name = cardInfoModel.name;
            };
            [self.navigationController pushViewController:cardInfoChangeVC animated:YES];
            break;
        }
            /** 卡类型view */
        case CardTypeBtnAction: {
//            CardCategoryViewController *cardCategoryVC = [[CardCategoryViewController alloc] init];
//            cardCategoryVC.cardCategoryArray = self.cardCategoryArray;
//            cardCategoryVC.cardCategoryType = ChangeCardCategoryAssignment;
//            cardCategoryVC.cardCategoryName = self.defaultCardCategory.name;
//            cardCategoryVC.cardInfoModel = self.cardTypeInfoModel;
//            cardCategoryVC.CardTypeChioceBlock = ^(CardCategoryModel *cardCategoryModel) {
//                // 获取默认展示会员卡类别
//                self.defaultCardCategory = cardCategoryModel;
//                /** 卡类别view */
//                self.cardInfoView.cardTypeView.describeLabel.text = cardCategoryModel.name;
//                self.cardTypeInfoModel.name = cardCategoryModel.name;
//            };
//            [self.navigationController pushViewController:cardCategoryVC animated:YES];
            break;
        }
            /** 可用次数／可用金额view */
        case CanNumMoneyBtnAction: {
            /** 卡类型 */
            switch (self.cardTypeInfoModel.card_category_id) { // 卡类别（1次卡，2储值卡,3年卡）
                case 1: {
                    CardInfoChangeViewController *cardInfoChangeVC = [[CardInfoChangeViewController alloc] init];
                    /** 卡信息模型 */
                    cardInfoChangeVC.cardInfoModel = self.cardTypeInfoModel;
                    /** 卡信息界面展示类型 */
                    cardInfoChangeVC.changeCardInfoType = ChangeCardNumberAssignment;
                    /** 修改成功回调 */
                    cardInfoChangeVC.CardInfoChangeSuccessBlock = ^(CardTypeModel *cardInfoModel) {
                        /** 可用次数 */
                        self.cardInfoView.canNumMoneyView.describeLabel.text = [NSString stringWithFormat:@"%ld", cardInfoModel.available_num];
                        self.cardTypeInfoModel.available_num = cardInfoModel.available_num;
                    };
                    [self.navigationController pushViewController:cardInfoChangeVC animated:YES];
                    break;
                }
                case 2: {
                    CardInfoChangeViewController *cardInfoChangeVC = [[CardInfoChangeViewController alloc] init];
                    /** 卡信息模型 */
                    cardInfoChangeVC.cardInfoModel = self.cardTypeInfoModel;
                    /** 卡信息界面展示类型 */
                    cardInfoChangeVC.changeCardInfoType = ChangeCardMoneyAssignment;
                    /** 修改成功回调 */
                    cardInfoChangeVC.CardInfoChangeSuccessBlock = ^(CardTypeModel *cardInfoModel) {
                        /** 可用金额 */
                        self.cardInfoView.canNumMoneyView.describeLabel.text = [NSString stringWithFormat:@"%.2f", cardInfoModel.face_money];
                        self.cardTypeInfoModel.face_money = cardInfoModel.face_money;
                    };
                    [self.navigationController pushViewController:cardInfoChangeVC animated:YES];
                    break;
                }
                case 3: {
                    break;
                }
                default:
                    break;
            }
            break;
        }
            /** 售价view */
        case PriceBtnAction: {
            CardInfoChangeViewController *cardInfoChangeVC = [[CardInfoChangeViewController alloc] init];
            /** 卡信息模型 */
            cardInfoChangeVC.cardInfoModel = self.cardTypeInfoModel;
            /** 卡信息界面展示类型 */
            cardInfoChangeVC.changeCardInfoType = ChangeCardPresentPriceAssignment;
            /** 修改成功回调 */
            cardInfoChangeVC.CardInfoChangeSuccessBlock = ^(CardTypeModel *cardInfoModel) {
                /** 售价view */
                self.cardInfoView.priceView.describeLabel.text = [NSString stringWithFormat:@"%.2f", cardInfoModel.sale_price];
                self.cardTypeInfoModel.sale_price = cardInfoModel.sale_price;
            };
            [self.navigationController pushViewController:cardInfoChangeVC animated:YES];
            break;
        }
            /** 原价view */
        case CostPriceBtnAction: {
            CardInfoChangeViewController *cardInfoChangeVC = [[CardInfoChangeViewController alloc] init];
            /** 卡信息模型 */
            cardInfoChangeVC.cardInfoModel = self.cardTypeInfoModel;
            /** 卡信息界面展示类型 */
            cardInfoChangeVC.changeCardInfoType = ChangeCardOriginalPriceAssignment;
            /** 修改成功回调 */
            cardInfoChangeVC.CardInfoChangeSuccessBlock = ^(CardTypeModel *cardInfoModel) {
                /** 原价view */
                self.cardInfoView.costPriceView.describeLabel.text = [NSString stringWithFormat:@"%.2f", cardInfoModel.price];
                self.cardTypeInfoModel.price = cardInfoModel.price;
            };
            [self.navigationController pushViewController:cardInfoChangeVC animated:YES];
            break;
        }
            /** 可用服务view */
        case CanServiceBtnAction: {
            CardApplyViewController *cardApplyVC = [[CardApplyViewController alloc] init];
            cardApplyVC.cardApplyUseType = ChangeCardInfoUseType;
            /** 卡信息模型 */
            cardApplyVC.cardInfoModel = self.cardTypeInfoModel;
            /** 选中的商品 */
            cardApplyVC.chooseCommodityArray = self.chooseCommodityArray;
            /** 选中的服务 */
            cardApplyVC.chooseServiceArray = self.chooseServiceArray;
            /** 全部服务商品 */
            cardApplyVC.wholeCommodityArray = self.wholeCommodityArray;
            cardApplyVC.confirmApply = ^(NSMutableArray *wholeCommodityArray, NSMutableArray *chooseCommodityArray, NSMutableArray *chooseServiceArray) {
                // 保存选中的商品
                self.chooseCommodityArray = chooseCommodityArray;
                // 保存选中的服务
                self.chooseServiceArray = chooseServiceArray;
                /** 全部服务商品 */
                self.wholeCommodityArray = wholeCommodityArray;
                // 保存选中的商品，保存选中的服务为空时
                if (self.chooseCommodityArray.count == 0 && self.chooseServiceArray.count == 0) {
                    self.cardInfoView.canServiceContentLabel.text = @"全部服务";
                }else {
                    // 初始化两个字符串
                    NSString *apply = [[NSString alloc] init];
                    for (ServiceProviderModel *service  in chooseServiceArray) {
                        apply = [apply stringByAppendingFormat:@"%@,", service.name];
                    }
                    for (CommodityShowStyleModel *commodity in chooseCommodityArray) {
                        apply = [apply stringByAppendingFormat:@"%@,", commodity.name];
                    }
                    apply = [apply substringToIndex:[apply length]-1];
                    self.cardInfoView.canServiceContentLabel.text = apply;
                }
                self.cardTypeInfoModel.used_goods_text = self.cardInfoView.canServiceContentLabel.text;
            };
            [self.navigationController pushViewController:cardApplyVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 界面赋值
- (void)cardInfoAssignment {
    /** 卡名称view */
    self.cardInfoView.cardNameView.describeLabel.text = self.cardTypeInfoModel.name;
    /** 卡类型 */
    switch (self.cardTypeInfoModel.card_category_id) { // 卡类别（1次卡，2储值卡,3年卡）
        case 1: {
            /** 可用次数／可用金额view */
            self.cardInfoView.canNumMoneyView.cellLabel.text = @"可用次数";
            self.cardInfoView.canNumMoneyView.describeLabel.text = [NSString stringWithFormat:@"%ld", self.cardTypeInfoModel.available_num];
            break;
        }
        case 2: {
            /** 可用次数／可用金额view */
            self.cardInfoView.canNumMoneyView.cellLabel.text = @"可用金额";
            self.cardInfoView.canNumMoneyView.describeLabel.text = [NSString stringWithFormat:@"%.2f", self.cardTypeInfoModel.face_money];
            break;
        }
        case 3: {
            /** 可用次数／可用金额view */
            self.cardInfoView.canNumMoneyView.cellLabel.text = @"可用次数";
            self.cardInfoView.canNumMoneyView.describeLabel.text = @"无限";
            break;
        }
        default:
            break;
    }
    /** 售价view */
    self.cardInfoView.priceView.describeLabel.text = [NSString stringWithFormat:@"%.2f", self.cardTypeInfoModel.sale_price];
    /** 原价view */
    self.cardInfoView.costPriceView.describeLabel.text = [NSString stringWithFormat:@"%.2f", self.cardTypeInfoModel.price];
    /** 可用服务view */
    // 获取会员卡对应服务和商品名称
    [self obtainCradAppropriateServiceAddGoodsName];
}


#pragma mark - 布局nav
- (void)cardInfoLayoutNAV {
    self.navigationItem.title = @"卡详情";
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(cardInfoLeftBarBtnAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(cardInfoRightBarBtnAction)];
}

#pragma mark - 布局视图
- (void)cardInfoLayoutView {
    /** 卡详情view */
    self.cardInfoView = [[CardInfoView alloc] init];
    /** 卡名称view */
    [self.cardInfoView.cardNameView.usedCellBtn addTarget:self action:@selector(cardInfoBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 卡类型view */
    [self.cardInfoView.cardTypeView.usedCellBtn addTarget:self action:@selector(cardInfoBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 可用次数／可用金额view */
    [self.cardInfoView.canNumMoneyView.usedCellBtn addTarget:self action:@selector(cardInfoBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 售价view */
    [self.cardInfoView.priceView.usedCellBtn addTarget:self action:@selector(cardInfoBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 原价view */
    [self.cardInfoView.costPriceView.usedCellBtn addTarget:self action:@selector(cardInfoBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    /** 可用服务view */
    [self.cardInfoView.canServiceBtn addTarget:self action:@selector(cardInfoBtnAvtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cardInfoView];
    @weakify(self)
    [self.cardInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}


#pragma mark - 封装方法
// 获取会员卡对应服务和商品名称
- (void)obtainCradAppropriateServiceAddGoodsName {
    // 初始化服务数组
    self.chooseServiceArray = [[NSMutableArray alloc] init];
    // 初始化商品数组
    self.chooseCommodityArray = [[NSMutableArray alloc] init];
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    [AllGoodsHandle sharedInstance].requestSuccessBlock = ^ (NSMutableArray *allGoodsArray) {
        // 判断卡可用服务ID是否为空
        if (self.cardTypeInfoModel.all_service.goods_category_id.count == 0 && self.cardTypeInfoModel.all_service.goods_id.count == 0) {
            self.cardInfoView.canServiceContentLabel.text = @"全部服务";
        }else {
            // 初始化两个字符串
            NSString *apply = [[NSString alloc] init];
            // 遍历该卡对应的服务商品，拼接适用范围ID
            for (ServiceProviderModel *serviceModel in allGoodsArray) {
                // 遍历保存的服务ID
                for (NSString *serviceID  in self.cardTypeInfoModel.all_service.goods_category_id) {
                    if ([serviceID integerValue] == serviceModel.goods_category_id) {
                        /** 选中标记 */
                        serviceModel.checkMark = YES;
                        // 保存选中服务
                        [self.chooseServiceArray addObject:serviceModel];
                        // 拼接适用服务字段
                        apply = [apply stringByAppendingFormat:@"%@,", serviceModel.name];
                    }
                }
                for (CommodityShowStyleModel *goodsModel in serviceModel.goods) {
                    for (NSString *goodsID in self.cardTypeInfoModel.all_service.goods_id) {
                        // 判断是否包含本服务
                        if ([goodsID integerValue] == goodsModel.goods_id) {
                            /** 选中标记 */
                            goodsModel.checkMark = YES;
                            // 保存选中商品
                            [self.chooseCommodityArray addObject:goodsModel];
                            // 拼接适用服务字段
                            apply = [apply stringByAppendingFormat:@"%@,", goodsModel.name];
                        }
                    }
                }
            }
            // 保护，避免因为字符串为空，崩溃
            if (apply.length != 0) {
                apply = [apply substringToIndex:[apply length]-1];
                self.cardInfoView.canServiceContentLabel.text = apply;
            }
        }
        // 初始化全部服务商品
        self.wholeCommodityArray = allGoodsArray;
    };
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
