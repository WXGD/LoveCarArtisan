//
//  NewAddCardViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewAddCardViewController.h"
// view
#import "NewAddCardView.h"
// 网络请求
#import "NewAddCardNetWork.h"
// 下级控制器
#import "CardApplyViewController.h"
#import "CardCategoryViewController.h"


@interface NewAddCardViewController ()

/** 新增会员卡View */
@property (strong, nonatomic) NewAddCardView *addCardView;

/** 适用范围ID */
@property (copy, nonatomic) NSString *applyID;

/** 选中的商品 */
@property (strong, nonatomic) NSMutableArray *chooseCommodityArray;
/** 选中的服务 */
@property (strong, nonatomic) NSMutableArray *chooseServiceArray;
/** 全部服务商品 */
@property (strong, nonatomic) NSMutableArray *wholeCommodityArray;


/** 当前展示的会员卡类别 */
@property (strong, nonatomic) CardCategoryModel *defaultCardType;
/** 会员卡类别数据 */
@property (strong, nonatomic) NSMutableArray *cardCategoryArray;


@end

@implementation NewAddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self newAddCardLayoutNAV];
    // 布局视图
    [self newAddCardLayoutView];
    // 获取会员卡类型
    [self requestCardType];
}
#pragma mark - 网络请求
// 获取会员卡类型
- (void)requestCardType {
    CardCategoryDataSource *cardCategory = [[CardCategoryDataSource alloc] init];
    [cardCategory requestCardTypeData];
    self.cardCategoryArray = cardCategory.rowArray;
    // 获取默认展示会员卡类型
    self.defaultCardType = [self.cardCategoryArray firstObject];
    // 界面赋值
    [self newAddCardAssignment];
}
// 添加商户卡请求
- (void)newAddCardRequestData {
    /*/index.php?c=provider_card&a=add&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登录者id
     name 	string 	是 	卡名
     card_category_id 	int 	是 	卡类型id
     card_value 	string 	是 	卡面值（可以为次数、储值数或年数）
     price 	string 	是 	原价
     sale_price 	string 	是 	售价
     description 	string 	否 	卡描述
     rules 	string 	否 	适用的服务, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)   */
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    parame[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    parame[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登录者id
    parame[@"name"] = self.addCardView.cardName.viceTextFiled.text; // 卡名
    parame[@"card_category_id"] = [NSString stringWithFormat:@"%ld", self.defaultCardType.card_category_id]; // 卡类型id
    parame[@"card_value"] = self.addCardView.cardNumber.viceTextFiled.text; // 卡金额
    parame[@"price"] = self.addCardView.cardOriginalPrice.viceTextFiled.text; // 原价
    parame[@"sale_price"] = self.addCardView.cardSalesPrice.viceTextFiled.text; // 售价
    parame[@"rules"] = self.applyID; // 适用的服务
    [NewAddCardNetWork newAddCardTypeParame:parame success:^{
        if (_addCardSuccess) {
            _addCardSuccess();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
#pragma mark - 按钮点击方法
- (void)newAddCardBtnAction:(UIButton *)button {
    switch (button.tag) {
            /** 卡类别 */
        case CardTypeBtnAction: {
            CardCategoryViewController *cardCategoryVC = [[CardCategoryViewController alloc] init];
            cardCategoryVC.cardCategoryType = NOChangeCardCategoryAssignment;
            cardCategoryVC.cardCategoryArray = self.cardCategoryArray;
            cardCategoryVC.cardCategoryName = self.defaultCardType.name;
            cardCategoryVC.CardTypeChioceBlock = ^(CardCategoryModel *cardCategoryModel) {
                self.defaultCardType = cardCategoryModel;
                // 界面赋值
                [self newAddCardAssignment];
            };
            [self.navigationController pushViewController:cardCategoryVC animated:YES];
            break;
        }
            /** 卡适用范围 */
        case CardApplyBtnAction: {
            CardApplyViewController *cardApplyVC = [[CardApplyViewController alloc] init];
            cardApplyVC.cardApplyUseType = AddCardUseType;
            cardApplyVC.confirmApply = ^(NSMutableArray *wholeCommodityArray, NSMutableArray *chooseCommodityArray, NSMutableArray *chooseServiceArray) {
                // 保存选中的商品
                self.chooseCommodityArray = chooseCommodityArray;
                // 保存选中的服务
                self.chooseServiceArray = chooseServiceArray;
                /** 全部服务商品 */
                self.wholeCommodityArray = wholeCommodityArray;
                // 保存选中的商品，保存选中的服务为空时
                if (self.chooseCommodityArray.count == 0 && self.chooseServiceArray.count == 0) {
                    self.applyID = @"";
                    self.addCardView.canServiceContentLabel.text = @"全部服务";
                }else {
                    // 初始化两个字符串
                    NSString *apply = [[NSString alloc] init];
                    self.applyID = [[NSString alloc] init];
                    for (ServiceProviderModel *service  in chooseServiceArray) {
                        apply = [apply stringByAppendingFormat:@"%@,", service.name];
                        self.applyID = [self.applyID stringByAppendingFormat:@"goods_category_id=%ld,", (long)service.goods_category_id];
                    }
                    for (CommodityShowStyleModel *commodity in chooseCommodityArray) {
                        apply = [apply stringByAppendingFormat:@"%@,", commodity.name];
                        self.applyID = [self.applyID stringByAppendingFormat:@"goods_id=%ld,", (long)commodity.goods_id];
                    }
                    apply = [apply substringToIndex:[apply length]-1];
                    self.applyID = [self.applyID substringToIndex:[self.applyID length]-1];
                    self.addCardView.canServiceContentLabel.text = apply;
                }
            };
            /** 选中的商品 */
            cardApplyVC.chooseCommodityArray = self.chooseCommodityArray;
            /** 选中的服务 */
            cardApplyVC.chooseServiceArray = self.chooseServiceArray;
            /** 全部服务商品 */
            cardApplyVC.wholeCommodityArray = self.wholeCommodityArray;
            [self.navigationController pushViewController:cardApplyVC animated:YES];
            break;
        }
        default:
            break;
    }
}
// nav左边按钮
- (void)newAddCardNavBarLeftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}


// nav右边按钮
- (void)newAddCardRightBarButtonItmeAction {
    // 判断名称不能为空
    if (self.addCardView.cardName.viceTextFiled.text.length == 0) {
        [MBProgressHUD showError:@"名称不能为空"];
        return;
    }
    // 判断余额／余次／年数不能为空
    if (self.addCardView.cardNumber.viceTextFiled.text.length == 0) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@不能为空", self.addCardView.cardNumber.cellLabel.text]];
        return;
    }
    // 判断销售价不能为空
    if (self.addCardView.cardSalesPrice.viceTextFiled.text.length == 0) {
        [MBProgressHUD showError:@"销售价不能为空"];
        return;
    }
    // 判断是否有原价，如果没有默认等于销售价
    if (!self.addCardView.cardOriginalPrice.viceTextFiled.text || self.addCardView.cardOriginalPrice.viceTextFiled.text.length == 0) {
        self.addCardView.cardOriginalPrice.viceTextFiled.text = self.addCardView.cardSalesPrice.viceTextFiled.text;
    }
    // 判断原价是否小于销售价
    if ([self.addCardView.cardOriginalPrice.viceTextFiled.text floatValue] < [self.addCardView.cardSalesPrice.viceTextFiled.text floatValue]) {
        [MBProgressHUD showError:@"原价不能小于售价"];
        return;
    }
    // 网络请求
    [self newAddCardRequestData];
}
#pragma mark - 类型选择弹框点击
//- (void)alertModelChooseActionBoxView:(ElasticBoxView *)BoxView alertRow:(NSInteger)alertRow {
//    // 回收弹框
//    [self.cardTypeBoxView dismiss];
//    // 获取默认选中的服务
//    self.defaultCardType = self.cardTypeArray[alertRow];
//    // 界面赋值
////    [self newAddCardAssignment:self.defaultCardType];
//}
#pragma mark - 界面赋值
- (void)newAddCardAssignment {
    /** 卡类型 */
    self.addCardView.cardType.describeLabel.text = self.defaultCardType.name;
    /** 卡类型 */
    switch (self.defaultCardType.card_category_id) { // 卡类别（1次卡，2储值卡,3年卡）
        case 1: {
            self.addCardView.cardNumber.viceTextFiled.placeholder = @"请输入卡的初始次数";
            self.addCardView.cardNumber.cellLabel.text = @"次数";
            break;
        }
        case 2: {
            self.addCardView.cardNumber.viceTextFiled.placeholder = @"请输入卡的初始余额";
            self.addCardView.cardNumber.cellLabel.text = @"余额";
            self.addCardView.cardNumber.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            break;
        }
        case 3: {
            self.addCardView.cardNumber.viceTextFiled.placeholder = @"请输入卡可使用年限，如1、2";
            self.addCardView.cardNumber.cellLabel.text = @"年数";
            break;
        }
        default:
            break;
    }
}
#pragma mark - 布局nav
- (void)newAddCardLayoutNAV {
    self.navigationItem.title = @"新增卡";
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(newAddCardNavBarLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(newAddCardRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)newAddCardLayoutView {
    @weakify(self)
    /** 会员卡选择View */
    self.addCardView = [[NewAddCardView alloc] init];
    /** 卡类型 */
    [self.addCardView.cardType.usedCellBtn addTarget:self action:@selector(newAddCardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 卡适用范围 */
    [self.addCardView.canServiceBtn addTarget:self action:@selector(newAddCardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addCardView];
    [self.addCardView mas_makeConstraints:^(MASConstraintMaker *make) {
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
