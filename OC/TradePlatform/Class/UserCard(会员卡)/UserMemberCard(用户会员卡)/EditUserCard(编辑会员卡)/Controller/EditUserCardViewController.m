//
//  EditUserCardViewController.m
//  TradePlatform
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditUserCardViewController.h"
// view
#import "EditUserCardView.h"
#import "CashierServiceChoiceView.h"

// 网络请求
#import "EditUserCardNetwork.h"

@interface EditUserCardViewController ()<CashierServiceChoiceDelegate>

/** 编辑会员卡View */
@property (strong, nonatomic) EditUserCardView *editUserCardView;

@end

@implementation EditUserCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self editUserCardLayoutNAV];
    // 布局视图
    [self editUserCardLayoutView];
    // 界面赋值
    [self editUserCardAssignment];
}
#pragma mark - 网络请求

#pragma mark - 按钮点击方法
- (void)editUserCardBtnAction:(UIButton *)button {
}
// nav左边按钮
- (void)editUserCardNavBarLeftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
// nav右边按钮
- (void)editUserCardNavBarRightBtnAction {
    [self.editUserCardView endEditing:YES];
    // 判断是否有修改信息
//    if ([self.editUserCardView.editUserPhone.viceTextFiled.text isEqualToString:self.userCard.mobile]) {
        if (self.userCard.end_time.length == 0) {
            if ([self.editUserCardView.editExpiryDate.viceLabel.text isEqualToString:@"永久"]) {
                [MBProgressHUD showSuccess:@"请确认修改后，在提交"];
                return;
            }
        }else {
            if ([self.editUserCardView.editExpiryDate.viceLabel.text isEqualToString:self.userCard.end_time]) {
                [MBProgressHUD showSuccess:@"请确认修改后，在提交"];
                return;
            }
        }
//    }
    // 编辑信息
    NSString *data = [[NSString alloc] init];
    if ([self.editUserCardView.editExpiryDate.viceLabel.text isEqualToString:@"永久"] && self.userCard.end_time.length == 0) {
        data = [NSString stringWithFormat:@"mobile=,end_time=%@", self.userCard.end_time];
    }else {
        data = [NSString stringWithFormat:@"mobile=,end_time=%@", self.editUserCardView.editExpiryDate.describeLabel.text];
    }
    /*/index.php?c=user_card&a=edit&v=1
     provider_id 	int 	是 	服务商id
     staff_user_id 	int 	是 	登陆者id
     sale_user_id 	int 	是 	销售者id
     provider_user_card_id 	int 	是 	用户卡id
     data 	string 	是 	编辑的信息 格式： 数据库字段名=值, 数据库字段名1=值1(对应数据库字段名见备注)
     price 	string 	否 	实收金额(充值时必传)    */
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    parame[@"provider_id"] = self.merchantInfo.provider_id; // 服务商id
    parame[@"staff_user_id"] = self.merchantInfo.staff_user_id; // 登陆者id
    parame[@"sale_user_id"] = self.merchantInfo.staff_user_id; // 销售者id
    parame[@"provider_user_card_id"] = self.userCard.provider_user_card_id; // 用户卡id
    parame[@"data"] = data; // 编辑的信息
    [EditUserCardNetwork preservedEditUserCardParame:parame isCashPay:YES success:^(NSMutableDictionary *thirdPartyDic) {
        // 制作一个编辑过之后的会员卡
        UserMemberCardModel *userCard = self.userCard;
        userCard.is_expire = 0;
        if (userCard.end_time.length == 0) {
            if ([self.editUserCardView.editExpiryDate.viceLabel.text isEqualToString:@"永久"]) {
                userCard.end_time = @"";
            }else {
                userCard.end_time = self.editUserCardView.editExpiryDate.describeLabel.text;
            }
        }else {
            userCard.end_time = self.editUserCardView.editExpiryDate.describeLabel.text;
        }
        if (_EditUserCardSuccessBlock) {
            _EditUserCardSuccessBlock(userCard);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

// 点击日历
- (void)editExpiryDateBtnAction:(UIButton *)button {
    // 日历
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 选择框
    NSString *title = @"\n\n\n\n\n\n\n\n\n\n" ;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定日期
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd";
        NSString *timestamp = [formatter stringFromDate:datePicker.date];
        self.editUserCardView.editExpiryDate.describeLabel.text = timestamp;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:confirm];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    // 将日期滚轮添加到选择框上
    [alertController.view addSubview:datePicker];
}

#pragma mark - 界面赋值
- (void)editUserCardAssignment {
    /** 卡号 */
    self.editUserCardView.editCardNum.describeLabel.text = self.userCard.card_no;
    // 判断是次卡还是储值卡
    if (self.userCard.card_category_id == 1) { // 次卡
        self.editUserCardView.editNoreThan.cellLabel.text = @"余次";
        /** 余次 */
        self.editUserCardView.editNoreThan.describeLabel.text = [NSString stringWithFormat:@"%ld次", (long)self.userCard.num];
    }else if (self.userCard.card_category_id == 2) { // 储值卡
        self.editUserCardView.editNoreThan.cellLabel.text = @"面额";
        /** 面额 */
        self.editUserCardView.editNoreThan.describeLabel.text = [NSString stringWithFormat:@"%.2f元", self.userCard.money];
    }else if (self.userCard.card_category_id == 3) { // 年卡
        self.editUserCardView.editNoreThan.cellLabel.text = @"余次";
        /** 余次 */
        self.editUserCardView.editNoreThan.describeLabel.text = @"无限";
    }
    /** 有效期 */
    if (self.userCard.end_time.length != 0) {
        self.editUserCardView.editExpiryDate.describeLabel.text = self.userCard.end_time;
    }else {
        self.editUserCardView.editExpiryDate.describeLabel.text = @"永久";
    }
}
#pragma mark - 布局nav
- (void)editUserCardLayoutNAV {
    self.navigationItem.title = @"编辑会员卡";
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(editUserCardNavBarLeftBtnAction)];
    // 右边
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(editUserCardNavBarRightBtnAction)];
}
#pragma mark - 布局视图
- (void)editUserCardLayoutView {
    @weakify(self)
    /** 编辑会员卡View */
    self.editUserCardView = [[EditUserCardView alloc] init];
    /** 有效期 */
    [self.editUserCardView.editExpiryDate.usedCellBtn addTarget:self action:@selector(editExpiryDateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editUserCardView];
    [self.editUserCardView mas_makeConstraints:^(MASConstraintMaker *make) {
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
