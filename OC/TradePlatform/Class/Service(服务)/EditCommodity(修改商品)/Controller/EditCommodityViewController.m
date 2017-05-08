//
//  EditCommodityViewController.m
//  TradePlatform
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditCommodityViewController.h"
#import "EditCommodityView.h"
// 网络请求
#import "EditCommodityNetwork.h"

@interface EditCommodityViewController ()

/** 修改商品view */
@property (strong, nonatomic) EditCommodityView *editCommodityView;

@end

@implementation EditCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self editServiceLayoutNAV];
    // 布局视图
    [self editServiceLayoutView];
    // 网络请求
    [self editServiceRepustData];
    // 界面赋值
    [self editServiceAssignment];
}
#pragma mark - 网络请求
- (void)editServiceRepustData {
    
}
#pragma mark - 按钮点击方法
//  账户页面按钮点击方法
- (void)editServiceBtnAction:(UIButton *)button {
    
}
// 保存服务右边按钮
- (void)editServiceRightBarButtonItmeAction {
    switch (self.changeCommodityInfoType) {
            /** 商品名称 */
        case ChangeCommodityNameAssignment: {
            // 判断是输入框内容和原内容是否一致
            if ([self.editCommodityView.changeTextField.text isEqualToString:self.commodityShowModel.name]) {
                [MBProgressHUD showError:@"没有任何修改"];
                return;
            }
            /*/index.php?c=goods&a=edit&v=1
             goods_id 	int 	是 	商品id
             price 	string 	是 	原价
             sale_price 	string 	是 	售价
             goods_name 	string 	是 	商品名称
             staff_user_id string 	是 	登陆者ID */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"goods_id"] = [NSString stringWithFormat:@"%ld", self.commodityShowModel.goods_id]; // 商品id
            params[@"price"] = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.price]; // 原价
            params[@"sale_price"] = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.sale_price]; // 售价
            params[@"goods_name"] = self.editCommodityView.changeTextField.text; // 商品名称
            params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者ID
            [EditCommodityNetwork editCommodity:params success:^{
                if (_editCommoditySuccessBlock) {
                    _editCommoditySuccessBlock(self.editCommodityView.changeTextField.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 销售价 */
        case ChangePresentPriceAssignment: {
            // 判断是输入框内容和原内容是否一致
            if ([self.editCommodityView.changeTextField.text doubleValue] == self.commodityShowModel.sale_price) {
                [MBProgressHUD showError:@"没有任何修改"];
                return;
            }
            /*/index.php?c=goods&a=edit&v=1
             goods_id 	int 	是 	商品id
             price 	string 	是 	原价
             sale_price 	string 	是 	售价
             goods_name 	string 	是 	商品名称
             staff_user_id string 	是 	登陆者ID */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"goods_id"] = [NSString stringWithFormat:@"%ld", self.commodityShowModel.goods_id]; // 商品id
            params[@"price"] = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.price]; // 原价
            params[@"sale_price"] = self.editCommodityView.changeTextField.text; // 售价
            params[@"goods_name"] = self.commodityShowModel.name; // 商品名称
            params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者ID
            [EditCommodityNetwork editCommodity:params success:^{
                if (_editCommoditySuccessBlock) {
                    _editCommoditySuccessBlock(self.editCommodityView.changeTextField.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
            /** 原价 */
        case ChangeOriginalPriceAssignment: {
            // 判断是输入框内容和原内容是否一致
            if ([self.editCommodityView.changeTextField.text doubleValue] == self.commodityShowModel.price) {
                [MBProgressHUD showError:@"没有任何修改"];
                return;
            }
            /*/index.php?c=goods&a=edit&v=1
             goods_id 	int 	是 	商品id
             price 	string 	是 	原价
             sale_price 	string 	是 	售价
             goods_name 	string 	是 	商品名称
             staff_user_id string 	是 	登陆者ID */
            // 网络请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"goods_id"] = [NSString stringWithFormat:@"%ld", self.commodityShowModel.goods_id]; // 商品id
            params[@"price"] = self.editCommodityView.changeTextField.text; // 原价
            params[@"sale_price"] = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.sale_price]; // 售价
            params[@"goods_name"] = self.commodityShowModel.name; // 商品名称
            params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者ID
            [EditCommodityNetwork editCommodity:params success:^{
                if (_editCommoditySuccessBlock) {
                    _editCommoditySuccessBlock(self.editCommodityView.changeTextField.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
            break;
        }
        default:
            break;
    }

    
    
    
    
    
//    // 判断是非有原价，如果没有默认在销售价上加5
//    if (!self.editCommodityView.editOriginalPrice.viceTextFiled.text || self.editCommodityView.editOriginalPrice.viceTextFiled.text.length == 0) {
////        self.editCommodityView.editOriginalPrice.viceTextFiled.text = [NSString stringWithFormat:@"%.2f", [self.editCommodityView.editPresentPrice.viceTextFiled.text doubleValue] + 5.0];
//        self.editCommodityView.editOriginalPrice.viceTextFiled.text = self.editCommodityView.editPresentPrice.viceTextFiled.text;
//    }
//    // 判断原价是否小于销售价
//    if ([self.editCommodityView.editOriginalPrice.viceTextFiled.text doubleValue] < [self.editCommodityView.editPresentPrice.viceTextFiled.text doubleValue]) {
//        [MBProgressHUD showError:@"原价不能小于销售价"];
//        return;
//    }
//    // 判断原价和销售价是否有修改
//    if ([self.editCommodityView.editOriginalPrice.viceTextFiled.text doubleValue] == self.commodityShowModel.price && [self.editCommodityView.editPresentPrice.viceTextFiled.text doubleValue] == self.commodityShowModel.sale_price && [self.editCommodityView.editCommodityName.viceTextFiled.text isEqualToString:self.commodityShowModel.name]) {
//        [MBProgressHUD showError:@"没有任何修改"];
//        return;
//    }
//    /*/index.php?c=goods&a=edit&v=1
//     goods_id 	int 	是 	商品id
//     price 	string 	是 	原价
//     sale_price 	string 	是 	售价   
//     goods_name 	string 	是 	商品名称 
//     staff_user_id string 	是 	登陆者ID */
//    // 网络请求参数
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    params[@"goods_id"] = self.commodityShowModel.goods_id; // 商品id
//    params[@"price"] = self.editCommodityView.editOriginalPrice.viceTextFiled.text; // 原价
//    params[@"sale_price"] = self.editCommodityView.editPresentPrice.viceTextFiled.text; // 售价
//    params[@"goods_name"] = self.editCommodityView.editCommodityName.viceTextFiled.text; // 商品名称
//    params[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者ID
//    [EditCommodityNetwork editCommodity:params success:^{
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
}
#pragma mark - 类型选择弹框点击


#pragma mark - 界面赋值
- (void)editServiceAssignment {
    switch (self.changeCommodityInfoType) {
            /** 商品名称 */
        case ChangeCommodityNameAssignment: {
            self.editCommodityView.changeTextField.placeholder = @"请输入服务名称";
            self.editCommodityView.changeTextField.text = self.commodityShowModel.name;
            self.navigationItem.title = @"服务名称";
            // 修改手机号的输入框限制
            RACSignal *phoneSig = [self.editCommodityView changeCommodityNameTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [phoneSig map:^id(NSNumber *aggregationInfoTF){
                return@([aggregationInfoTF boolValue]);
            }];
            break;
        }
            /** 销售价 */
        case ChangePresentPriceAssignment: {
            self.editCommodityView.changeTextField.placeholder = @"请输入售价";
            self.editCommodityView.changeTextField.text = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.sale_price];
            self.editCommodityView.changeTextField.keyboardType = UITextBorderStyleNone;
            self.navigationItem.title = @"售价";
            // 修改手机号的输入框限制
            RACSignal *phoneSig = [self.editCommodityView changePresentPriceTextFieldSignal];
            // 根据账户输入框，修改保存按钮是否可点击属性
            RAC(self.navigationItem.rightBarButtonItem, enabled) =
            [phoneSig map:^id(NSNumber *aggregationInfoTF){
                return@([aggregationInfoTF boolValue]);
            }];
            break;
        }
            /** 原价 */
        case ChangeOriginalPriceAssignment: {
            self.editCommodityView.changeTextField.placeholder = @"请输入原价";
            self.editCommodityView.changeTextField.text = [NSString stringWithFormat:@"%.2f", self.commodityShowModel.price];
            self.editCommodityView.changeTextField.keyboardType = UITextBorderStyleNone;
            self.navigationItem.title = @"原价";
            // 修改手机号的输入框限制
            RACSignal *phoneSig = [self.editCommodityView changeOriginalPriceTextFieldSignal];
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
- (void)editServiceLayoutNAV {
    self.navigationItem.title = @"修改服务";
    // 左边
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:@selector(statisticsNavLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(editServiceRightBarButtonItmeAction)];
}
#pragma mark - 布局视图
- (void)editServiceLayoutView {
    /** 修改商品view */
    self.editCommodityView = [[EditCommodityView alloc] init];
    [self.view addSubview:self.editCommodityView];
    @weakify(self)
    [self.editCommodityView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    // 输入框成为第一响应者
    [self.editCommodityView.changeTextField becomeFirstResponder];
}

#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
