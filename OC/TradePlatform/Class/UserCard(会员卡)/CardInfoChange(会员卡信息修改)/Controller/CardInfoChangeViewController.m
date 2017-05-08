//
//  CardInfoChangeViewController.m
//  TradePlatform
//
//  Created by apple on 2017/3/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CardInfoChangeViewController.h"
#import "CardInfoChangeView.h"
// 网络请求
#import "CardInfoChangeNetwork.h"

@interface CardInfoChangeViewController ()

/** 修改卡信息view */
@property (strong, nonatomic) CardInfoChangeView *cardInfoChangeView;

@end

@implementation CardInfoChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self CardInfoChangeLayoutNAV];
    // 布局视图
    [self CardInfoChangeLayoutView];
    // 网络请求
    [self CardInfoChangeRepustData];
    // 界面赋值
    [self CardInfoChangeAssignment];
}
#pragma mark - 网络请求
- (void)CardInfoChangeRepustData {
    
}
#pragma mark - 按钮点击方法
//  账户页面按钮点击方法
- (void)cardInfoChangeBtnAction:(UIButton *)button {
    
}

// nav左边按钮
- (void)cardInfoChangeLeftBarButtonItmeAction {
    [self.navigationController popViewControllerAnimated:YES];
}

// 保存服务右边按钮
- (void)cardInfoChangeRightBarButtonItmeAction {
    switch (self.changeCardInfoType) {
            /** 卡名称 */
        case ChangeCardNameAssignment: {
            // 判断编辑前后内容一致
            if ([self.cardInfoChangeView.changeTextField.text isEqualToString:self.cardInfoModel.name]) {
                [MBProgressHUD showSuccess:@"没有任何修改"];
                return;
            }
            /*/index.php?c=provider_card&a=edit&v=1
             provider_card_id 	int 	是 	服务商卡id
             data 	string 	否 	编辑除了可适用的服务以外的数据必传（格式: 数据库字段名=值，字段名参考备注）
             rules 	string 	否 	编辑适用的服务必传, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)  */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardInfoModel.provider_card_id]; // 商品id
            params[@"data"] = [NSString stringWithFormat:@"name=%@", self.cardInfoChangeView.changeTextField.text]; // 卡名
            [CardInfoChangeNetwork cardInfoChange:params success:^{
                if (_CardInfoChangeSuccessBlock) {
                    self.cardInfoModel.name = self.cardInfoChangeView.changeTextField.text;
                    _CardInfoChangeSuccessBlock(self.cardInfoModel);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 卡次数 */
        case ChangeCardNumberAssignment: {
            // 判断编辑前后内容一致
            if ([self.cardInfoChangeView.changeTextField.text integerValue] == self.cardInfoModel.available_num) {
                [MBProgressHUD showSuccess:@"没有任何修改"];
                return;
            }
            /*/index.php?c=provider_card&a=edit&v=1
             provider_card_id 	int 	是 	服务商卡id
             data 	string 	否 	编辑除了可适用的服务以外的数据必传（格式: 数据库字段名=值，字段名参考备注）
             rules 	string 	否 	编辑适用的服务必传, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)  */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardInfoModel.provider_card_id]; // 商品id
            params[@"data"] = [NSString stringWithFormat:@"available_num=%@", self.cardInfoChangeView.changeTextField.text]; // 可用次数
            [CardInfoChangeNetwork cardInfoChange:params success:^{
                if (_CardInfoChangeSuccessBlock) {
                    self.cardInfoModel.available_num = [self.cardInfoChangeView.changeTextField.text integerValue];
                    _CardInfoChangeSuccessBlock(self.cardInfoModel);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 卡可用金额 */
        case ChangeCardMoneyAssignment: {
            // 判断编辑前后内容一致
            if ([self.cardInfoChangeView.changeTextField.text doubleValue] == self.cardInfoModel.face_money) {
                [MBProgressHUD showSuccess:@"没有任何修改"];
                return;
            }
            /*/index.php?c=provider_card&a=edit&v=1
             provider_card_id 	int 	是 	服务商卡id
             data 	string 	否 	编辑除了可适用的服务以外的数据必传（格式: 数据库字段名=值，字段名参考备注）
             rules 	string 	否 	编辑适用的服务必传, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)  */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardInfoModel.provider_card_id]; // 商品id
            params[@"data"] = [NSString stringWithFormat:@"face_money=%@", self.cardInfoChangeView.changeTextField.text]; // 面值
            [CardInfoChangeNetwork cardInfoChange:params success:^{
                if (_CardInfoChangeSuccessBlock) {
                    self.cardInfoModel.face_money = [self.cardInfoChangeView.changeTextField.text doubleValue];
                    _CardInfoChangeSuccessBlock(self.cardInfoModel);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 卡销售价 */
        case ChangeCardPresentPriceAssignment: {
            // 判断编辑前后内容一致
            if ([self.cardInfoChangeView.changeTextField.text doubleValue] == self.cardInfoModel.sale_price) {
                [MBProgressHUD showSuccess:@"没有任何修改"];
                return;
            }
            /*/index.php?c=provider_card&a=edit&v=1
             provider_card_id 	int 	是 	服务商卡id
             data 	string 	否 	编辑除了可适用的服务以外的数据必传（格式: 数据库字段名=值，字段名参考备注）
             rules 	string 	否 	编辑适用的服务必传, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)  */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardInfoModel.provider_card_id]; // 商品id
            params[@"data"] = [NSString stringWithFormat:@"sale_price=%@", self.cardInfoChangeView.changeTextField.text]; // 售价
            [CardInfoChangeNetwork cardInfoChange:params success:^{
                if (_CardInfoChangeSuccessBlock) {
                    self.cardInfoModel.sale_price = [self.cardInfoChangeView.changeTextField.text doubleValue];
                    _CardInfoChangeSuccessBlock(self.cardInfoModel);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 卡原价 */
        case ChangeCardOriginalPriceAssignment: {
            // 判断编辑前后内容一致
            if ([self.cardInfoChangeView.changeTextField.text doubleValue] == self.cardInfoModel.price) {
                [MBProgressHUD showSuccess:@"没有任何修改"];
                return;
            }
            /*/index.php?c=provider_card&a=edit&v=1
             provider_card_id 	int 	是 	服务商卡id
             data 	string 	否 	编辑除了可适用的服务以外的数据必传（格式: 数据库字段名=值，字段名参考备注）
             rules 	string 	否 	编辑适用的服务必传, 数据格式: 参数名=值,参数名1=值1 (参数名对应值见备注,如“goods_category_id=1,goods_id=2,goods_id=3”)  */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"provider_card_id"] = [NSString stringWithFormat:@"%ld", self.cardInfoModel.provider_card_id]; // 商品id
            params[@"data"] = [NSString stringWithFormat:@"price=%@", self.cardInfoChangeView.changeTextField.text]; // 原价
            [CardInfoChangeNetwork cardInfoChange:params success:^{
                if (_CardInfoChangeSuccessBlock) {
                    self.cardInfoModel.price = [self.cardInfoChangeView.changeTextField.text doubleValue];
                    _CardInfoChangeSuccessBlock(self.cardInfoModel);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 类型选择弹框点击


#pragma mark - 界面赋值
- (void)CardInfoChangeAssignment {
    switch (self.changeCardInfoType) {
            /** 卡名称 */
        case ChangeCardNameAssignment: {
            self.cardInfoChangeView.changeTextField.placeholder = @"请输入卡名称";
            self.cardInfoChangeView.changeTextField.text = self.cardInfoModel.name;
            self.navigationItem.title = @"卡名称";
            // 修改卡名称的输入框限制
            RACSignal *phoneSig = [self.cardInfoChangeView changeCardNameTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [phoneSig map:^id(NSNumber *aggregationInfoTF){
                return@([aggregationInfoTF boolValue]);
            }];
            break;
        }
            /** 卡次数 */
        case ChangeCardNumberAssignment: {
            self.cardInfoChangeView.changeTextField.placeholder = @"请输入次数";
            self.cardInfoChangeView.changeTextField.text = [NSString stringWithFormat:@"%ld", self.cardInfoModel.available_num];
            self.cardInfoChangeView.changeTextField.keyboardType = UITextBorderStyleNone;
            self.navigationItem.title = @"次数";
            // 修改手机号的输入框限制
            RACSignal *phoneSig = [self.cardInfoChangeView changeCardPriceTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [phoneSig map:^id(NSNumber *aggregationInfoTF){
                return@([aggregationInfoTF boolValue]);
            }];
            break;
        }
            /** 卡可用金额 */
        case ChangeCardMoneyAssignment: {
            self.cardInfoChangeView.changeTextField.placeholder = @"请输入金额";
            self.cardInfoChangeView.changeTextField.text = [NSString stringWithFormat:@"%.2f", self.cardInfoModel.face_money];
            self.cardInfoChangeView.changeTextField.keyboardType = UITextBorderStyleNone;
            self.navigationItem.title = @"金额";
            // 修改价格的输入框限制
            RACSignal *phoneSig = [self.cardInfoChangeView changeCardPriceTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [phoneSig map:^id(NSNumber *aggregationInfoTF){
                return@([aggregationInfoTF boolValue]);
            }];
            break;
        }
            /** 卡销售价 */
        case ChangeCardPresentPriceAssignment: {
            self.cardInfoChangeView.changeTextField.placeholder = @"请输入售价";
            self.cardInfoChangeView.changeTextField.text = [NSString stringWithFormat:@"%.2f", self.cardInfoModel.sale_price];
            self.cardInfoChangeView.changeTextField.keyboardType = UITextBorderStyleNone;
            self.navigationItem.title = @"售价";
            // 修改卡销售价的输入框限制
            RACSignal *phoneSig = [self.cardInfoChangeView changeCardPriceTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [phoneSig map:^id(NSNumber *aggregationInfoTF){
                return@([aggregationInfoTF boolValue]);
            }];
            break;
        }
            /** 卡原价 */
        case ChangeCardOriginalPriceAssignment: {
            self.cardInfoChangeView.changeTextField.placeholder = @"请输入原价";
            self.cardInfoChangeView.changeTextField.text = [NSString stringWithFormat:@"%.2f", self.cardInfoModel.price];
            self.cardInfoChangeView.changeTextField.keyboardType = UITextBorderStyleNone;
            self.navigationItem.title = @"原价";
            // 修改手机号的输入框限制
            RACSignal *phoneSig = [self.cardInfoChangeView changeCardPriceTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [phoneSig map:^id(NSNumber *aggregationInfoTF){
                return@([aggregationInfoTF boolValue]);
            }];
            break;
        }
        default:
            break;
    }
}
#pragma mark - 布局nav
- (void)CardInfoChangeLayoutNAV {
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cardInfoChangeLeftBarButtonItmeAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(cardInfoChangeRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)CardInfoChangeLayoutView {
    /** 修改卡信息view */
    self.cardInfoChangeView = [[CardInfoChangeView alloc] init];
    [self.view addSubview:self.cardInfoChangeView];
    @weakify(self)
    [self.cardInfoChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    // 输入框成为第一响应者
    [self.cardInfoChangeView.changeTextField becomeFirstResponder];
}

#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
