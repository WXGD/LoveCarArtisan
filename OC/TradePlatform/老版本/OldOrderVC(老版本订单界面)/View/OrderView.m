//
//  OrderView.m
//  TradePlatform
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderView.h"
#import "FilterConditionBtn.h"
// 服务师傅数据
#import "ServiceMasterHandle.h"

@interface OrderView ()<GJTableViewDelegate, AlertModelChooseActionDelegate>
/** 筛选条件view */
@property (strong, nonatomic) UIView *filterConditionView;
/** 订单支付状态按钮 */
@property (strong, nonatomic) FilterConditionBtn *orderPayStateBtn;
/** 分割线1 */
@property (strong, nonatomic) UIView *dividingLineOneView;
/** 订单类型按钮 */
@property (strong, nonatomic) FilterConditionBtn *orderPayClassBtn;
/** 分割线2 */
@property (strong, nonatomic) UIView *dividingLineTwoView;
/** 服务师傅 */
@property (strong, nonatomic) FilterConditionBtn *serviceMasterBtn;

/** 订单支付状态弹框 */
@property (strong, nonatomic) AlertListAction *orderPayStateAlert;
/** 订单类型弹框 */
@property (strong, nonatomic) AlertListAction *orderPayClassAlert;
/** 服务师傅弹框 */
@property (strong, nonatomic) AlertListAction *serviceMasterAlert;

/** 订单支付状态数据 */
@property (strong, nonatomic) NSMutableArray *orderPayStateArray;

@end

@implementation OrderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 自定义订单类型和订单支付状态数据
        [self customOrderPayArray];
        
        [self orderLayoutView];
    }
    return self;
}

// 自定义订单类型和订单支付状态数据
- (void)customOrderPayArray {
    /************************************** 订单支付状态数据(1未支付，2待使用，3待评价，4已完成 6退款) ************************************************/
    self.orderPayStateArray = [[NSMutableArray alloc] init];
    AlertListModel *whole = [[AlertListModel alloc] init];
    /** 名称 */
    whole.chioceCategoriesName = @"全部状态";
    /** 别id */
    whole.chioceCategoriesId = 0;
    [self.orderPayStateArray addObject:whole];
    // 默认选中全部
    self.orderPayStateModel = whole;
    
    AlertListModel *notPaid  = [[AlertListModel alloc] init];
    /** 名称 */
    notPaid.chioceCategoriesName = @"未支付";
    /** 别id */
    notPaid.chioceCategoriesId = 1;
    [self.orderPayStateArray addObject:notPaid];
    
    AlertListModel *alreadyPaid  = [[AlertListModel alloc] init];
    /** 名称 */
    alreadyPaid.chioceCategoriesName = @"待使用";
    /** 别id */
    alreadyPaid.chioceCategoriesId = 2;
    [self.orderPayStateArray addObject:alreadyPaid];
    
    AlertListModel *alreadyUsed  = [[AlertListModel alloc] init];
    /** 名称 */
    alreadyUsed.chioceCategoriesName = @"待评价";
    /** 别id */
    alreadyUsed.chioceCategoriesId = 3;
    [self.orderPayStateArray addObject:alreadyUsed];
    
    AlertListModel *noEvaluated = [[AlertListModel alloc] init];
    /** 名称 */
    noEvaluated.chioceCategoriesName = @"已完成";
    /** 别id */
    noEvaluated.chioceCategoriesId = 4;
    [self.orderPayStateArray addObject:noEvaluated];
    
    /********************************************** 订单类型数据 ***********************************************/
//    self.orderPayClassArray = [[NSMutableArray alloc] init];
//    AlertListModel *wholeClass = [[AlertListModel alloc] init];
//    /** 名称 */
//    wholeClass.chioceCategoriesName = @"全部";
//    /** 别id */
//    wholeClass.chioceCategoriesId = @"0";
//    [self.orderPayClassArray addObject:wholeClass];
//    // 默认选中全部
//    self.orderPayClassModel = wholeClass;
//    
//    AlertListModel *carWash = [[AlertListModel alloc] init];
//    /** 名称 */
//    carWash.chioceCategoriesName = @"洗车";
//    /** 别id */
//    carWash.chioceCategoriesId = @"1";
//    [self.orderPayClassArray addObject:carWash];
}

- (void)setOrderPayClassArray:(NSMutableArray *)orderPayClassArray {
    _orderPayClassArray = orderPayClassArray;
    self.orderPayClassModel = [orderPayClassArray firstObject];
    self.orderPayClassBtn.titleLabel.text = self.orderPayClassModel.name;
}

#pragma mark - 类型选择弹框点击
- (void)alertModelChooseActionBoxView:(ElasticBoxView *)BoxView alertRow:(NSInteger)alertRow {
    /** 订单类型按钮 */
    [self.orderPayClassAlert dismiss];
    /** 订单支付状态按钮 */
    [self.orderPayStateAlert dismiss];
    /** 服务师傅弹框 */
    [self.serviceMasterAlert dismiss];
    // 判断点击的是那个
    if (BoxView == self.orderPayStateAlert) { // 点击的是订单支付状态
        // 获取选中
        AlertListModel *defaultModel = self.orderPayStateAlert.alertListArray[alertRow];
        self.orderPayStateBtn.titleLabel.text = defaultModel.chioceCategoriesName;
        // 保存新选中的订单支付状态
        self.orderPayStateModel = defaultModel;
    }else if (BoxView == self.orderPayClassAlert) { // 点击的是订单支付类型
        // 获取选中
        OrderTypeListModel *defaultModel = self.orderPayClassAlert.alertListArray[alertRow];
        self.orderPayClassBtn.titleLabel.text = defaultModel.chioceCategoriesName;
        // 保存新选中的订单类型
        self.orderPayClassModel = defaultModel;
    }else if (BoxView == self.serviceMasterAlert) { // 点击的是服务师傅弹框
        // 服务师傅数据
        NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].wholeServiceMasterArray;
        // 获取选中服务师傅
        MerchantInfoModel *currentMerchantModel = serviceMasterArray[alertRow];
        self.serviceMasterBtn.titleLabel.text = currentMerchantModel.chioceCategoriesName;
        // 保存新选中的服务师傅
        self.currentMerchantModel = currentMerchantModel;
    }
    // 修改订单状态或类型
    if (_delegate && [_delegate respondsToSelector:@selector(alertModelChooseActionBoxView)]) {
        [_delegate alertModelChooseActionBoxView];
    }
}

#pragma mark - GJTableViewDelegate
- (void)tableView:(UITableView *)tableView rowDidSelectAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(orderRowDidSelectAtIndexPath:)]) {
        [_delegate orderRowDidSelectAtIndexPath:indexPath];
    }
}

/** 订单支付状态按钮 */
- (void)orderPayStateBtnAction:(UIButton *)button {
    /** 订单支付状态按钮 */
    self.orderPayStateAlert = [[AlertListAction alloc] init];
    self.orderPayStateAlert.boxAlert.backgroundColor = WhiteColor;
    self.orderPayStateAlert.typeChooseTi.text = @"订单状态";
    // 便利所有订单类型
    for (AlertListModel *alertModel in self.orderPayStateArray) {
        if (alertModel.chioceCategoriesId == self.orderPayStateModel.chioceCategoriesId) {
            alertModel.currentTitle = YES;
        }
    }
    self.orderPayStateAlert.alertListArray = self.orderPayStateArray;
    self.orderPayStateAlert.delegate = self;
    [self.orderPayStateAlert show];
    
}
/** 订单类型按钮 */
- (void)orderPayClassBtnAction:(UIButton *)button {
    self.orderPayClassAlert = [[AlertListAction alloc] init];
    self.orderPayClassAlert.boxAlert.backgroundColor = WhiteColor;
    self.orderPayClassAlert.typeChooseTi.text = @"订单类型";
    // 便利所有订单类型
    for (AlertListModel *alertModel in self.orderPayClassArray) {
        if (alertModel.chioceCategoriesId == self.orderPayClassModel.chioceCategoriesId) {
            alertModel.currentTitle = YES;
        }
    }
    self.orderPayClassAlert.alertListArray = self.orderPayClassArray;
    self.orderPayClassAlert.delegate = self;
    [self.orderPayClassAlert show];
}

/** 订单服务师傅选择按钮 */
- (void)serviceMasterBtnAction:(UIButton *)button {
    /** 服务师傅数据 */
    NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].wholeServiceMasterArray;
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (serviceMasterArray.count == 0) {
        [ServiceMasterHandle sharedInstance].requestSuccessBlock = ^ () {
            /** 服务列表数据 */
            NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].wholeServiceMasterArray;
            
            self.serviceMasterAlert = [[AlertListAction alloc] init];
            self.serviceMasterAlert.boxAlert.backgroundColor = WhiteColor;
            self.serviceMasterAlert.typeChooseTi.text = @"服务师傅";
            // 便利所有订单类型
            for (MerchantInfoModel *serviceMaster in serviceMasterArray) {
                if (serviceMaster.staff_user_id == self.currentMerchantModel.staff_user_id) {
                    serviceMaster.currentTitle = YES;
                }
            }
            self.serviceMasterAlert.alertListArray = serviceMasterArray;
            self.serviceMasterAlert.delegate = self;
            [self.serviceMasterAlert show];
        };
    }else {
        /** 服务列表数据 */
        NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].wholeServiceMasterArray;
        self.serviceMasterAlert = [[AlertListAction alloc] init];
        self.serviceMasterAlert.boxAlert.backgroundColor = WhiteColor;
        self.serviceMasterAlert.typeChooseTi.text = @"服务师傅";
        // 便利所有订单类型
        for (MerchantInfoModel *serviceMaster in serviceMasterArray) {
            if (serviceMaster.staff_user_id == self.currentMerchantModel.staff_user_id) {
                serviceMaster.currentTitle = YES;
            }
        }
        self.serviceMasterAlert.alertListArray = serviceMasterArray;
        self.serviceMasterAlert.delegate = self;
        [self.serviceMasterAlert show];
//        /** 服务列表数据 */
//        NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].serviceMasterArray;
//        // 遍历所有服务，找到当前选中的服务
//        for (MerchantInfoModel *serviceMasterModel in serviceMasterArray) {
//            serviceMasterModel.checkMark = NO;
//            if ([serviceMasterModel.staff_user_id isEqualToString:self.merchantInfo.staff_user_id]) {
//                serviceMasterModel.checkMark = YES;
//            }
//        }
//        // 弹出支付方式选择
//        CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
//        payChoiceBoxView.choiceArray = serviceMasterArray;
//        payChoiceBoxView.serviceChoice = ServiceMasterChoiceBtnAction;
//        payChoiceBoxView.delegate = self;
//        [payChoiceBoxView show];
    }
}


- (void)orderLayoutView {
    /** 筛选条件view */
    self.filterConditionView = [[UIView alloc] init];
    self.filterConditionView.backgroundColor = WhiteColor;
    [self addSubview:self.filterConditionView];
    /** 订单支付状态按钮 */
    self.orderPayStateBtn = [[FilterConditionBtn alloc] init];
    self.orderPayStateBtn.titleLabel.text = self.orderPayStateModel.chioceCategoriesName;
    [self.orderPayStateBtn.filterConditionBtn addTarget:self action:@selector(orderPayStateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.filterConditionView addSubview:self.orderPayStateBtn];
    /** 分割线1 */
    self.dividingLineOneView = [[UIView alloc] init];
    self.dividingLineOneView.backgroundColor = VCBackground;
    [self.filterConditionView addSubview:self.dividingLineOneView];
    /** 订单类型按钮 */
    self.orderPayClassBtn = [[FilterConditionBtn alloc] init];
    [self.orderPayClassBtn.filterConditionBtn addTarget:self action:@selector(orderPayClassBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.filterConditionView addSubview:self.orderPayClassBtn];
    /** 分割线2 */
    self.dividingLineTwoView = [[UIView alloc] init];
    self.dividingLineTwoView.backgroundColor = VCBackground;
    [self.filterConditionView addSubview:self.dividingLineTwoView];
    /** 服务师傅 */
    self.serviceMasterBtn = [[FilterConditionBtn alloc] init];
    // 获取商户信息user
    self.currentMerchantModel = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    self.serviceMasterBtn.titleLabel.text = self.currentMerchantModel.user_name;
    [self.serviceMasterBtn.filterConditionBtn addTarget:self action:@selector(serviceMasterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.filterConditionView addSubview:self.serviceMasterBtn];
    
    
    /** 会员卡类型 */
    self.orderTable = [[GJBaseTabelView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 300) style:UITableViewStylePlain];
    self.orderDataSource = [[OrderDataSource alloc] init];
    self.orderTable.GJDataSource = self.orderDataSource;
    self.orderTable.GJDelegate = self;
    self.orderTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.orderTable.backgroundColor = CLEARCOLOR;
    [self addSubview:self.orderTable];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 筛选条件view */
    [self.filterConditionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@44);
    }];
    /** 订单支付状态按钮 */
    [self.orderPayStateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.filterConditionView.mas_top);
        make.bottom.equalTo(self.filterConditionView.mas_bottom);
        make.left.equalTo(self.filterConditionView.mas_left);
    }];
    /** 分割线1 */
    [self.dividingLineOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderPayStateBtn.mas_right);
        make.centerY.equalTo(self.filterConditionView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, 22));
    }];
    /** 订单类型按钮 */
    [self.orderPayClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.dividingLineOneView.mas_right);
        make.top.equalTo(self.filterConditionView.mas_top);
        make.bottom.equalTo(self.filterConditionView.mas_bottom);
    }];
    /** 分割线2 */
    [self.dividingLineTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderPayClassBtn.mas_right);
        make.centerY.equalTo(self.filterConditionView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, 22));
    }];
    /** 服务师傅 */
    [self.serviceMasterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.dividingLineTwoView.mas_right);
        make.right.equalTo(self.filterConditionView.mas_right);
        make.top.equalTo(self.filterConditionView.mas_top);
        make.bottom.equalTo(self.filterConditionView.mas_bottom);
    }];
    /** 订单支付状态按钮,订单类型按钮,服务师傅 */
    [@[self.orderPayStateBtn, self.orderPayClassBtn, self.serviceMasterBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.equalTo(self.orderPayStateBtn.mas_width);
    }];
    /** 会员卡类型 */
    [self.orderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.orderPayClassBtn.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
