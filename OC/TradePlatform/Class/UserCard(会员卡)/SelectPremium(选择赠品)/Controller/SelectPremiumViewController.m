//
//  SelectPremiumViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SelectPremiumViewController.h"
// view
#import "SelectPremiumView.h"
#import "CashierServiceChoiceView.h"
// 模型
#import "PremiumModel.h"

@interface SelectPremiumViewController ()<SelectPremiumDelegate, CashierServiceChoiceDelegate>

/** 选择赠品view */
@property (strong, nonatomic) SelectPremiumView *selectPremiumView;
/** 保存所有可用服务 */
@property (strong, nonatomic) NSMutableArray *holdUseServiceArray;

/** 更换服务类别时，选中的赠品 */
@property (strong, nonatomic) PremiumModel *replaceClassPremium;
/** 更换服务时，选中的赠品 */
@property (strong, nonatomic) PremiumModel *replaceGoodsPremium;

@end

@implementation SelectPremiumViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self selectPremiumLayoutNAV];
    // 布局视图
    [self selectPremiumLayoutView];
    // 网络请求
    [self selectPremiumRequestData];
    // 界面赋值
    [self selectPremiumAssignment];
}
#pragma mark - 网络请求
- (void)selectPremiumRequestData {
    // 判断是非有之前保存的赠品
    if (self.keepsGoodsArray.count == 0) {
        // 初始化保存所有可用服务数组
        self.holdUseServiceArray = [[NSMutableArray alloc] init];
        // 请求商品类型
        /*/index.php?c=goods_category&a=detail&v=1
         provider_id 	int 	是 	服务商id      */
        // 网络请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
        [ServiceProviderModel requestServiceCommodityParams:params success:^(NSMutableArray *serviceCommodityArray) {
            // 遍历所有服务，找出所有有商品的服务
            for (ServiceProviderModel *serviceModel in serviceCommodityArray) {
                if (serviceModel.goods.count != 0) {
                    [self.holdUseServiceArray addObject:serviceModel];
                }
            }
            // 判断还有没有更多服务
            if (self.holdUseServiceArray.count == 0) {
                [MBProgressHUD showError:@"还没有添加服务类型"];
                return;
            }
//            // 获取默认展示服务的商品
//            ServiceProviderModel *serviceModel = [self.holdUseServiceArray firstObject];
//            // 创建赠品模型
//            PremiumModel *premiumModel = [[PremiumModel alloc] init];
//            premiumModel.serviceModel = serviceModel;
//            premiumModel.goodsModel = [serviceModel.goods firstObject];
//            premiumModel.premiumNum = 1;
//            [self.selectPremiumView.giftGoodsArray addObject:premiumModel];
//            [self.selectPremiumView.giftServiceTable reloadData];
//            // 添加好赠品之后，从商品数组中删除该商品
//            [serviceModel.goods removeObject:[serviceModel.goods firstObject]];
//            // 判断此时是否还有可用商品
//            if (serviceModel.goods.count == 0) { // 没有可用商品
//                // 移除该服务类型
//                [self.holdUseServiceArray removeObject:serviceModel];
//            }
        }];
    }else {
        // 获取之前保存的服务
        self.holdUseServiceArray = self.currentServiceArray;
        // 获取之前保存的赠品
        self.selectPremiumView.giftGoodsArray = self.keepsGoodsArray;
//            // 遍历所有可用服务
//            [self.holdUseServiceArray enumerateObjectsUsingBlock:^(ServiceProviderModel *serviceModel, NSUInteger serviceID, BOOL *stop) {
//                // 遍历所有可用服务商品
//                [serviceModel.goods enumerateObjectsUsingBlock:^(CommodityShowStyleModel *goods, NSUInteger goodsID, BOOL *stop) {
//                    // 遍历保存的服务商品
//                    for (PremiumModel *premiumModel in self.keepsGoodsArray) {
//                        // 判断该商品是不是，之前保存的商品
//                        if (goods.goods_id == premiumModel.goodsModel.goods_id) {
//                            // 添加赠品
//                            [self.selectPremiumView.giftGoodsArray addObject:premiumModel];
//                            // 添加好赠品之后，从商品数组中删除该商品
//                            [serviceModel.goods removeObject:goods];
//                            // 判断此时是否还有可用商品
//                            if (serviceModel.goods.count == 0) { // 没有可用商品
//                                // 移除该服务类型
//                                [self.holdUseServiceArray removeObject:serviceModel];
//                            }
//                        }
//                    }
//                }];
//            }];
        [self.selectPremiumView.giftServiceTable reloadData];
    }

}

#pragma mark - 按钮点击方法
/** 删除赠品 */
- (void)delPremiumBtnDelegate:(UIButton *)button {
    // 回收键盘
    [self.selectPremiumView endEditing:YES];
    // 获取该赠品模型
    PremiumModel *premiumModel = [self.selectPremiumView.giftGoodsArray objectAtIndex:button.tag];
    // 遍历服务数组，判断此时是否还存在该服务，如果不存在，添加该服务，如果存在，在该服务下添加该商品
    // 判断服务数组是否为空
    if (self.holdUseServiceArray.count == 0) {
        [self.holdUseServiceArray addObject:premiumModel.serviceModel];
        ServiceProviderModel *serviceModel = [self.holdUseServiceArray firstObject];
        [serviceModel.goods removeAllObjects];
        [serviceModel.goods addObject:premiumModel.goodsModel];
    }else {
        // 判断服务类型数组中，是否存在该服务类型
        if ([self.holdUseServiceArray containsObject:premiumModel.serviceModel]) {
            for (ServiceProviderModel *useServiceModel in self.holdUseServiceArray) {
                if (useServiceModel.goods_category_id == premiumModel.serviceModel.goods_category_id) {
                    [useServiceModel.goods addObject:premiumModel.goodsModel];
                }
            }
        }else {
            [self.holdUseServiceArray addObject:premiumModel.serviceModel];
            for (ServiceProviderModel *useServiceModel in self.holdUseServiceArray) {
                if (useServiceModel.goods_category_id == premiumModel.serviceModel.goods_category_id) {
                    [useServiceModel.goods removeAllObjects];
                    [useServiceModel.goods addObject:premiumModel.goodsModel];
                }
            }
        }
    }
    [self.selectPremiumView.giftGoodsArray removeObject:premiumModel];
    [self.selectPremiumView.giftServiceTable reloadData];
}
/** 服务类别 */
- (void)serviceClassBtnDelegate:(UIButton *)button {
    // 回收键盘
    [self.selectPremiumView endEditing:YES];
    /** 更换服务类别时，选中的赠品 */
    self.replaceClassPremium = [self.selectPremiumView.giftGoodsArray objectAtIndex:button.tag];
    // 遍历所有服务，找到当前选中的服务
    for (ServiceProviderModel *service in self.holdUseServiceArray) {
        service.checkMark = NO;
        if (service.goods_category_id == self.replaceClassPremium.serviceModel.goods_category_id) {
            service.checkMark = YES;
        }
    }
    // 判断还有没有更多服务
    if (self.holdUseServiceArray.count == 0) {
        [MBProgressHUD showError:@"没有更多服务类型了"];
        return;
    }
    // 弹出
    CashierServiceChoiceView *classChoiceBoxView = [[CashierServiceChoiceView alloc] init];
    classChoiceBoxView.choiceArray = self.holdUseServiceArray;
    classChoiceBoxView.serviceChoice = ServiceTypeChoiceBtnAction;
    classChoiceBoxView.delegate = self;
    [classChoiceBoxView show];
}
/** 服务 */
- (void)serviceGoodsBtnDelegate:(UIButton *)button {
    // 回收键盘
    [self.selectPremiumView endEditing:YES];
    /** 更换服务时，选中的赠品 */
    self.replaceGoodsPremium = [self.selectPremiumView.giftGoodsArray objectAtIndex:button.tag];
    // 找到当前赠品对应的服务
    // 遍历所有服务，找到当前选中的服务
    for (CommodityShowStyleModel *commodity in self.replaceGoodsPremium.serviceModel.goods) {
        commodity.checkMark = NO;
        if (commodity.goods_id == self.replaceGoodsPremium.goodsModel.goods_id) {
            commodity.checkMark = YES;
        }
    }
    // 判断还有没有更多服务
    if (self.replaceGoodsPremium.serviceModel.goods.count == 0) {
        [MBProgressHUD showError:@"没有更多服务了"];
        return;
    }
    ServiceProviderModel *serviceModel = [self.holdUseServiceArray firstObject];
    CashierServiceChoiceView *goodsChoiceBoxView = [[CashierServiceChoiceView alloc] init];
    goodsChoiceBoxView.choiceArray = serviceModel.goods;
    goodsChoiceBoxView.serviceChoice = ServiceGoodsChoiceBtnAction;
    goodsChoiceBoxView.delegate = self;
    [goodsChoiceBoxView show];
}
// 服务，服务商品，服务师傅，支付方式，选择代理方法
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    switch (serviceChoice) {
            /** 服务类型选择 */
        case ServiceTypeChoiceBtnAction:{
            // 将要被更换掉的服务，重新添加
            // 判断服务类型数组中，是否存在该服务类型
            if ([self.holdUseServiceArray containsObject:self.replaceClassPremium.serviceModel]) {
                // 如果存在，在该服务下添加该商品
                for (ServiceProviderModel *useServiceModel in self.holdUseServiceArray) {
                    if (useServiceModel.goods_category_id == self.replaceClassPremium.serviceModel.goods_category_id) {
                        [useServiceModel.goods addObject:self.replaceClassPremium.goodsModel];
                    }
                }
            }else {
                // 如果不存在，添加该服务
                [self.holdUseServiceArray addObject:self.replaceClassPremium.serviceModel];
                for (ServiceProviderModel *useServiceModel in self.holdUseServiceArray) {
                    if (useServiceModel.goods_category_id == self.replaceClassPremium.serviceModel.goods_category_id) {
                        [useServiceModel.goods removeAllObjects];
                        [useServiceModel.goods addObject:self.replaceClassPremium.goodsModel];
                    }
                }
            }
            // 获取当前选中的服务类型模型
            ServiceProviderModel *serviceModel = [self.holdUseServiceArray objectAtIndex:indexPath.row];
            self.replaceClassPremium.serviceModel = serviceModel;
            self.replaceClassPremium.goodsModel = [serviceModel.goods firstObject];
            [self.selectPremiumView.giftServiceTable reloadData];
            // 添加好赠品之后，从商品数组中删除该商品
            [serviceModel.goods removeObject:[serviceModel.goods firstObject]];
            // 判断此时是否还有可用商品
            if (serviceModel.goods.count == 0) { // 没有可用商品
                // 移除该服务类型
                [self.holdUseServiceArray removeObject:serviceModel];
            }

            break;
        }
            /** 服务商品选择 */
        case ServiceGoodsChoiceBtnAction:{
            // 遍历所有服务，找到当前修改商品对应的服务
            for (ServiceProviderModel *useServiceModel in self.holdUseServiceArray) {
                if (useServiceModel.goods_category_id == self.replaceGoodsPremium.serviceModel.goods_category_id) {
                    // 获取当前选中的服务商品模型
                    CommodityShowStyleModel *goodsModel = [useServiceModel.goods objectAtIndex:indexPath.row];
                    // 将本来保存好的赠送服务商品，重写保存回数组中
                    [useServiceModel.goods addObject:self.replaceGoodsPremium.goodsModel];
                    // 更新保存好的，服务商品
                    self.replaceGoodsPremium.goodsModel = goodsModel;
                    [self.selectPremiumView.giftServiceTable reloadData];
                    // 添加好赠品之后，从商品数组中删除该商品
                    [useServiceModel.goods removeObject:goodsModel];
                }
            }
            break;
        }
        default:
            break;
    }
}

/** 数量操作 */
- (void)addSubPremiumDelegate:(UIButton *)button {
    // 回收键盘
    [self.selectPremiumView endEditing:YES];
    // 获取该赠品模型
    PremiumModel *premiumModel = [self.selectPremiumView.giftGoodsArray objectAtIndex:button.tag];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    GiftServiceCell *cell = [self.selectPremiumView.giftServiceTable cellForRowAtIndexPath:indexPath];
    premiumModel.premiumNum = [cell.numOperBtn.numTF.text integerValue];
}
/** 添加赠品 */
- (void)addGiftBtnAction:(UIButton *)button {
    // 回收键盘
    [self.selectPremiumView endEditing:YES];
    // 判断是否还有可用服务
    if (self.holdUseServiceArray.count == 0) { // 没有可用服务
        [MBProgressHUD showError:@"没有可以添加的赠品了"];
        return;
    }
    // 获取默认展示服务的商品
    ServiceProviderModel *serviceModel = [[ServiceProviderModel alloc] init];
    serviceModel = [self.holdUseServiceArray firstObject];
    // 创建赠品模型
    PremiumModel *premiumModel = [[PremiumModel alloc] init];
    premiumModel.serviceModel = serviceModel;
    premiumModel.goodsModel = [serviceModel.goods firstObject];
    premiumModel.premiumNum = 1;
    [self.selectPremiumView.giftGoodsArray addObject:premiumModel];
    [self.selectPremiumView.giftServiceTable reloadData];
    // 添加好赠品之后，从商品数组中删除该商品
    [serviceModel.goods removeObject:[serviceModel.goods firstObject]];
    // 判断此时是否还有可用商品
    if (serviceModel.goods.count == 0) { // 没有可用商品
        // 移除该服务类型
        [self.holdUseServiceArray removeObject:serviceModel];
    }
    // 自动滚到到最下面的一行
    [self.selectPremiumView.giftServiceTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectPremiumView.giftGoodsArray.count-1 inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}


// nav左边按钮
- (void)selectPremiumNavBarLeftBtnAction {
    // 回收键盘
    [self.selectPremiumView endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
// nav右边按钮
- (void)selectPremiumNavBarRightBtnAction {
    // 回收键盘
    [self.selectPremiumView endEditing:YES];
    // 初始化两个字符串，用来保存赠品名称和ID
    NSString *premiumName = [[NSString alloc] init];
    NSString *premiumID = [[NSString alloc] init];
    /** 卡类型 */
    switch (self.cardCategoryID) { // 卡类别（1次卡，2储值卡,3年卡）
        case 1: {
            // 判断是否有赠送次数
            if (self.selectPremiumView.giveNumPriceView.viceTextFiled.text.length != 0) {
                // 赠送次数
                premiumName = [NSString stringWithFormat:@"赠送%@次", self.selectPremiumView.giveNumPriceView.viceTextFiled.text];
            }
            break;
        }
        case 2: {
            // 判断是否有赠送金额
            if (self.selectPremiumView.giveNumPriceView.viceTextFiled.text.length != 0) {
                // 赠送金额
                premiumName = [NSString stringWithFormat:@"赠送%@元", self.selectPremiumView.giveNumPriceView.viceTextFiled.text];
            }
            break;
        }
        default:
            break;
    }
    // 判断是否有赠品，
    // 遍历所有赠品
    for (PremiumModel *premiumModel in self.selectPremiumView.giftGoodsArray) {
        // 赠品显示
        if (premiumName.length == 0) {
            premiumName = [NSString stringWithFormat:@"赠送%@%ld次", premiumModel.goodsModel.name, premiumModel.premiumNum];
        }else {
            premiumName = [premiumName stringByAppendingString:[NSString stringWithFormat:@",赠送%@%ld次", premiumModel.goodsModel.name, premiumModel.premiumNum]];
        }
        // 赠品ID
        if (premiumID.length == 0) {
            premiumID = [premiumID stringByAppendingString:[NSString stringWithFormat:@"%ld=%ld", premiumModel.goodsModel.goods_id, premiumModel.premiumNum]];
        }else {
            premiumID = [premiumID stringByAppendingString:[NSString stringWithFormat:@",%ld=%ld", premiumModel.goodsModel.goods_id, premiumModel.premiumNum]];
        }
    }
    if (_KeepsPremiumBlock) {
        _KeepsPremiumBlock(premiumName, premiumID, self.selectPremiumView.giveNumPriceView.viceTextFiled.text, self.selectPremiumView.giftGoodsArray, self.holdUseServiceArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 界面赋值
- (void)selectPremiumAssignment {
    /** 卡类型 */
    switch (self.cardCategoryID) { // 卡类别（1次卡，2储值卡,3年卡）
        case 1: {
            // 赠送次数
            self.selectPremiumView.giveNumPriceView.viceTextFiled.placeholder = @"请输入赠送次数";
            self.selectPremiumView.giveNumPriceView.cellLabel.text = @"赠送次数";
            break;
        }
        case 2: {
            // 赠送金额
            self.selectPremiumView.giveNumPriceView.viceTextFiled.placeholder = @"请输入赠送金额";
            self.selectPremiumView.giveNumPriceView.cellLabel.text = @"赠送金额";
            self.selectPremiumView.giveNumPriceView.viceTextFiled.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            break;
        }
        case 3: {
            [self.selectPremiumView.giveNumPriceBackView removeFromSuperview];
            [self.selectPremiumView.selectPremiumStackView removeArrangedSubview:self.selectPremiumView.giveNumPriceBackView];
            break;
        }
        default:
            break;
    }
    // 之前保存的赠送次数／赠送金额
    self.selectPremiumView.giveNumPriceView.viceTextFiled.text = self.premiumNumMon;
}


#pragma mark - 布局nav
- (void)selectPremiumLayoutNAV {
    self.navigationItem.title = @"选择赠品";
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(selectPremiumNavBarLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(selectPremiumNavBarRightBtnAction)];
}

#pragma mark - 布局视图
- (void)selectPremiumLayoutView {
    /** 选择赠品view */
    self.selectPremiumView = [[SelectPremiumView alloc] init];
    self.selectPremiumView.delegate = self;
    /** 添加赠品 */
    [self.selectPremiumView.addGiftBtn addTarget:self action:@selector(addGiftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectPremiumView];
    @weakify(self)
    [self.selectPremiumView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 回收键盘
    [self.selectPremiumView endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
