//
//  OrderView.m
//  TradePlatform
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderView.h"
// view
#import "CashierServiceChoiceView.h"
// 数据
#import "ServiceMasterHandle.h"

@interface OrderView ()<UITableViewDelegate, UITableViewDataSource, CashierServiceChoiceDelegate>

/** 头部筛选view */
@property (strong, nonatomic) UIView *headerScreenView;
/** 订单支付状态按钮 */
@property (strong, nonatomic) FilterConditionBtn *orderPayStateBtn;
/** 订单支付状态数据 */
@property (strong, nonatomic) NSMutableArray *orderPayStateArray;
/** 分割线1 */
@property (strong, nonatomic) UIView *lineOneView;
/** 服务师傅 */
@property (strong, nonatomic) FilterConditionBtn *serviceMasterBtn;
/** 分割线2 */
@property (strong, nonatomic) UIView *lineTwoView;
/** 分割线3 */
@property (strong, nonatomic) UIView *lineThreeView;
/** 分割线view */
@property (strong, nonatomic) UIView *lineView;

@end

@implementation OrderView

- (instancetype)init {
    self = [super init];
    if (self) {
        // 自定义订单支付状态数据
        [self customOrderPayArray];
        // 布局
        [self orderLayoutView];
    }
    return self;
}


#pragma mark - 按钮点击方法
// 订单支付状态选择
- (void)orderPayStateBtnAction:(UIButton *)button {
    // 遍历所有服务，找到当前选中的服务
    for (OrderPayStateModel *orderPayState in self.orderPayStateArray) {
        orderPayState.checkMark = NO;
        if (orderPayState.chioceCategoriesId == self.orderPayStateModel.chioceCategoriesId) {
            orderPayState.checkMark = YES;
        }
    }
    // 弹出支付方式选择
    CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
    payChoiceBoxView.choiceArray = self.orderPayStateArray;
    payChoiceBoxView.serviceChoice = OrderPayStateBtnAction;
    payChoiceBoxView.delegate = self;
    [payChoiceBoxView show];
}
// 服务师傅选择
- (void)serviceMasterBtnAction:(UIButton *)button {
    /** 服务师傅数据 */
    NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].wholeServiceMasterArray;
    // 判断是否有类型数据，如果没有等请求成功后，在次刷新界面
    if (serviceMasterArray.count == 0) {
        [ServiceMasterHandle sharedInstance].requestSuccessBlock = ^ () {
            /** 服务列表数据 */
            NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].wholeServiceMasterArray;
            // 遍历所有服务，找到当前选中的服务
            for (MerchantInfoModel *serviceMasterModel in serviceMasterArray) {
                serviceMasterModel.checkMark = NO;
                if ([serviceMasterModel.staff_user_id isEqualToString:self.merchantModel.staff_user_id]) {
                    serviceMasterModel.checkMark = YES;
                }
            }
            // 弹出支付方式选择
            CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
            payChoiceBoxView.choiceArray = serviceMasterArray;
            payChoiceBoxView.serviceChoice = ServiceMasterChoiceBtnAction;
            payChoiceBoxView.delegate = self;
            [payChoiceBoxView show];
        };
    }else {
        /** 服务列表数据 */
        NSMutableArray *serviceMasterArray = [ServiceMasterHandle sharedInstance].wholeServiceMasterArray;
        // 遍历所有服务，找到当前选中的服务
        for (MerchantInfoModel *serviceMasterModel in serviceMasterArray) {
            serviceMasterModel.checkMark = NO;
            if ([serviceMasterModel.staff_user_id isEqualToString:self.merchantModel.staff_user_id]) {
                serviceMasterModel.checkMark = YES;
            }
        }
        // 弹出支付方式选择
        CashierServiceChoiceView *payChoiceBoxView = [[CashierServiceChoiceView alloc] init];
        payChoiceBoxView.choiceArray = serviceMasterArray;
        payChoiceBoxView.serviceChoice = ServiceMasterChoiceBtnAction;
        payChoiceBoxView.delegate = self;
        [payChoiceBoxView show];
    }
}

#pragma mark - view布局
- (void)orderLayoutView {
    /** 背景view */
    self.orderBackView = [[UIStackView alloc] init];
    self.orderBackView.axis = UILayoutConstraintAxisVertical;
    [self addSubview:self.orderBackView];
    /** 头部筛选view */
    self.headerScreenView = [[UIView alloc] init];
    self.headerScreenView.backgroundColor = WhiteColor;
    [self.orderBackView addArrangedSubview:self.headerScreenView];
    /** 订单支付状态按钮 */
    self.orderPayStateBtn = [[FilterConditionBtn alloc] init];
    self.orderPayStateBtn.titleLabel.text = self.orderPayStateModel.chioceCategoriesName;
    [self.orderPayStateBtn.filterConditionBtn addTarget:self action:@selector(orderPayStateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerScreenView addSubview:self.orderPayStateBtn];
    /** 分割线1 */
    self.lineOneView = [[UIView alloc] init];
    self.lineOneView.backgroundColor = VCBackground;
    [self.headerScreenView addSubview:self.lineOneView];
    /** 服务师傅 */
    self.serviceMasterBtn = [[FilterConditionBtn alloc] init];
    // 获取商户信息user
    self.merchantModel = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    self.serviceMasterBtn.titleLabel.text = self.merchantModel.user_name;
    [self.serviceMasterBtn.filterConditionBtn addTarget:self action:@selector(serviceMasterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerScreenView addSubview:self.serviceMasterBtn];
    /** 分割线2 */
    self.lineTwoView = [[UIView alloc] init];
    self.lineTwoView.backgroundColor = VCBackground;
    [self.headerScreenView addSubview:self.lineTwoView];
    /** 更多筛选条件 */
    self.screenExistBtn = [[FilterConditionBtn alloc] init];
    self.screenExistBtn.titleLabel.text = @"更多筛选";
    self.screenExistBtn.signImage.image = [UIImage imageNamed:@"order_more_screen_exist"];
    [self.headerScreenView addSubview:self.screenExistBtn];
    /** 分割线3 */
    self.lineThreeView = [[UIView alloc] init];
    self.lineThreeView.backgroundColor = VCBackground;
    [self.headerScreenView addSubview:self.lineThreeView];
    
    
    /** 筛选展示view */
    self.screenShowsView = [[UIView alloc] init];
    self.screenShowsView.backgroundColor = WhiteColor;
    [self.orderBackView addArrangedSubview:self.screenShowsView];
    /** 选中筛选条件 */
    self.selScreenConditionLabel = [[UILabel alloc] init];
    self.selScreenConditionLabel.numberOfLines = 0;
    self.selScreenConditionLabel.textColor = BlueColor;
    self.selScreenConditionLabel.font = ElevenTypeface;
    [self.screenShowsView addSubview:self.selScreenConditionLabel];
    [self.screenShowsView setHidden:YES];
    /** 删除筛选展示按钮 */
    self.delScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.delScreenBtn setImage:[UIImage imageNamed:@"order_del_screen_exist"] forState:UIControlStateNormal];
    [self.screenShowsView addSubview:self.delScreenBtn];
    /** 分割线view */
    self.lineView = [[UIView alloc] init];
    [self.orderBackView addArrangedSubview:self.lineView];
    /** tableview */
    self.orderTableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.orderTableView.backgroundColor = CLEARCOLOR;
    self.orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    [self.orderBackView addArrangedSubview:self.orderTableView];
}

#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderTableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"shoppingCartCommodityCell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.orderModel = [self.orderTableArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *orderModel = [self.orderTableArray objectAtIndex:indexPath.row];
    return 137.5 + 24.5 * orderModel.order_detail.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderModel *orderModel = [self.orderTableArray objectAtIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(orderDidSelectDelegate:)]) {
        [_delegate orderDidSelectDelegate:orderModel];
    }
}

#pragma mark - 服务，服务商品，服务师傅，支付方式，选择代理方法
- (void)choiceDelegate:(CashierServiceChoiceBtnAction)serviceChoice choiceArray:(NSMutableArray *)choiceArray indexPath:(NSIndexPath *)indexPath {
    switch (serviceChoice) {
            /** 订单支付状态 */
        case OrderPayStateBtnAction:{
            /** 默认选择服务类型 */
            self.orderPayStateModel = [choiceArray objectAtIndex:indexPath.row];
            // 服务类型展示
            self.orderPayStateBtn.titleLabel.text = self.orderPayStateModel.chioceCategoriesName;
            // 马上进入刷新状态
            [self.orderTableView.mj_header beginRefreshing];
            break;
        }
            /** 服务师傅选择 */
        case ServiceMasterChoiceBtnAction:{
            // 更换当前服务师傅
            self.merchantModel = [choiceArray objectAtIndex:indexPath.row];
            // 服务师傅展示
            self.serviceMasterBtn.titleLabel.text = self.merchantModel.chioceCategoriesName;
            // 马上进入刷新状态
            [self.orderTableView.mj_header beginRefreshing];
            break;
        }
        default:
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 背景view */
    [self.orderBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 头部筛选view */
    [self.headerScreenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@44);
    }];
    /** 订单支付状态按钮 */
    [self.orderPayStateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.headerScreenView.mas_top);
        make.bottom.equalTo(self.headerScreenView.mas_bottom);
        make.left.equalTo(self.headerScreenView.mas_left);
        make.width.equalTo(self.orderPayStateBtn.mas_width);
    }];
    /** 分割线1 */
    [self.lineOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.orderPayStateBtn.mas_right);
        make.centerY.equalTo(self.headerScreenView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, 22));
    }];
    /** 服务师傅 */
    [self.serviceMasterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.lineOneView.mas_right);
        make.top.equalTo(self.headerScreenView.mas_top);
        make.bottom.equalTo(self.headerScreenView.mas_bottom);
        make.width.equalTo(self.orderPayStateBtn.mas_width);
    }];
    /** 分割线2 */
    [self.lineTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.serviceMasterBtn.mas_right);
        make.centerY.equalTo(self.headerScreenView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, 22));
    }];
    /** 更多筛选条件 */   
    [self.screenExistBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.lineTwoView.mas_right);
        make.right.equalTo(self.headerScreenView.mas_right);
        make.top.equalTo(self.headerScreenView.mas_top);
        make.bottom.equalTo(self.headerScreenView.mas_bottom);
        make.width.equalTo(self.orderPayStateBtn.mas_width);
    }];
    /** 分割线3 */
    [self.lineThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.headerScreenView.mas_left);
        make.right.equalTo(self.headerScreenView.mas_right);
        make.bottom.equalTo(self.headerScreenView.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
    /** 删除筛选展示按钮 */
    [self.delScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.screenShowsView.mas_centerY);
        make.right.equalTo(self.screenShowsView.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(33, 33));
    }];
    /** 选中筛选条件 */
    [self.selScreenConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.screenShowsView.mas_top).offset(8.5);
        make.left.equalTo(self.screenShowsView.mas_left).offset(16);
        make.right.equalTo(self.delScreenBtn.mas_left).offset(-16);
    }];
    
    /** 分割线view */
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@10);
    }];
}


#pragma mark - 封装方法
// 自定义订单支付状态数据
- (void)customOrderPayArray {
    /************************************** 订单支付状态数据(1未支付，2待使用，3待评价，4已完成 6退款) ************************************************/
    self.orderPayStateArray = [[NSMutableArray alloc] init];
    OrderPayStateModel *whole = [[OrderPayStateModel alloc] init];
    /** 名称 */
    whole.chioceCategoriesName = @"全部状态";
    /** 别id */
    whole.chioceCategoriesId = 0;
    [self.orderPayStateArray addObject:whole];
    // 默认选中全部
    self.orderPayStateModel = whole;
    OrderPayStateModel *notPaid  = [[OrderPayStateModel alloc] init];
    /** 名称 */
    notPaid.chioceCategoriesName = @"未支付";
    /** 别id */
    notPaid.chioceCategoriesId = 1;
    [self.orderPayStateArray addObject:notPaid];
    OrderPayStateModel *alreadyPaid  = [[OrderPayStateModel alloc] init];
    /** 名称 */
    alreadyPaid.chioceCategoriesName = @"待使用";
    /** 别id */
    alreadyPaid.chioceCategoriesId = 2;
    [self.orderPayStateArray addObject:alreadyPaid];
    OrderPayStateModel *alreadyUsed  = [[OrderPayStateModel alloc] init];
    /** 名称 */
    alreadyUsed.chioceCategoriesName = @"待评价";
    /** 别id */
    alreadyUsed.chioceCategoriesId = 3;
    [self.orderPayStateArray addObject:alreadyUsed];
    OrderPayStateModel *noEvaluated = [[OrderPayStateModel alloc] init];
    /** 名称 */
    noEvaluated.chioceCategoriesName = @"已完成";
    /** 别id */
    noEvaluated.chioceCategoriesId = 4;
    [self.orderPayStateArray addObject:noEvaluated];
}



@end
