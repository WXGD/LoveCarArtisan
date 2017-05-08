//
//  ShoppingCartViewController.m
//  TradePlatform
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShoppingCartViewController.h"
// 模型
#import "ShoppingCartModel.h"
// vive
#import "ShoppingCartCell.h"
#import "UUInputAccessoryView.h"
#import "ShoppingCartFootView.h"

@interface ShoppingCartViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 购物车地步操作view */
@property (strong, nonatomic) ShoppingCartFootView *shoppingCartFootView;
/** 购物车table */
@property (strong, nonatomic) UITableView *shoppingCartTable;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局nav
    [self shoppingCartLayoutNAV];
    // 布局视图
    [self shoppingCartLayoutView];
    // 界面赋值
    [self shoppingCartAssignment];
}
#pragma mark - 数据请求
#pragma mark - 按钮点击方法
// 底部操作按钮
- (void)shoppingCartFootBtnAction:(UIButton *)button {
    switch (button.tag) {
            /** 总价按钮 */
        case TotalBtnAction: {
            // 弹出键盘
            [UUInputAccessoryView showKeyboardType:UIKeyboardTypeNumbersAndPunctuation content:[CustomString getNumber:self.shoppingCartFootView.totalLabel.text] Block:^(NSString *contentStr) {
                if (contentStr.length == 0) return ;
                // 总价
                double total = [contentStr doubleValue];
                // 总价展示
                // 购物车商品数量，商品总价赋值
                // 购物车总价
                self.shoppingCartTotal = total;
                [self shoppingCartAssignment];
            }];
            break;
        }
            /** 确认收款 */
        case ConfirmationCollectionBtnAction: {
            
            break;
        }
            /** 提交订单 */
        case PlaceOrderBtnAction: {
            
            break;
        }
            /** 购物车 */
        case ShoppingCartBtnAction: {
            
            break;
        }
            /** 清空 */
        case EmptyBtnAction: {
            [self.shoppingCartCommodityArray removeAllObjects];
            self.shoppingCartNum = 0;
            self.shoppingCartTotal = 0;
            [self.shoppingCartTable reloadData];
            [self  showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.shoppingCartTable.mas_centerX);
                    make.centerY.equalTo(self.shoppingCartTable.mas_centerY);
                }];
            }];
            break;
        }
        default:
            break;
    }
}
// 修改销售价
- (void)pretiumBtnAction:(UIButton *)button {
    // 获取当前选中模型
    ShoppingCartModel *shoppingCartModel = [self.shoppingCartCommodityArray objectAtIndex:button.tag];
    // 弹出键盘
    [UUInputAccessoryView showKeyboardType:UIKeyboardTypeNumbersAndPunctuation content:[NSString stringWithFormat:@"%.2f", shoppingCartModel.goods.actual_sale_price] Block:^(NSString *contentStr) {
        if (contentStr.length == 0) return ;
        shoppingCartModel.goods.actual_sale_price = [contentStr doubleValue];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:button.tag inSection:0];
        [self.shoppingCartTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        // 购物车商品数量，商品总价赋值
        // 购物车总价
        self.shoppingCartTotal = 0;
        for (ShoppingCartModel *cartModel in self.shoppingCartCommodityArray) {
            self.shoppingCartTotal = self.shoppingCartTotal + cartModel.goods.actual_sale_price * cartModel.buy_num;
        }
        [self shoppingCartAssignment];
    }];
}
// nav左边按钮，返回上级页面
- (void)searchLeftBarBtnAction {
    if (_ShoppingCartBlock) {
        _ShoppingCartBlock(self.shoppingCartNum, self.shoppingCartTotal);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数量操作按钮点击代理
// 添加商品数量
- (void)shoppingCartAddBtnAction:(UIButton *)button {
    // 获取当前选中模型
    ShoppingCartModel *shoppingCartModel = [self.shoppingCartCommodityArray objectAtIndex:button.tag];
    // 获取当前修改的cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    ShoppingCartCell *cell = [self.shoppingCartTable cellForRowAtIndexPath:indexPath];
    // 商品数量
    NSInteger num = [cell.numTF.text integerValue];
    num += 1;
    // 次数
    shoppingCartModel.buy_num = num;
    [self.shoppingCartTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    // 购物车商品数量，商品总价赋值
    // 购物车数量
    self.shoppingCartNum += 1;
    // 购物车总价
    self.shoppingCartTotal = self.shoppingCartTotal + shoppingCartModel.goods.actual_sale_price;
    [self shoppingCartAssignment];
}
// 减少商品数量
- (void)shoppingCartSubBtnAction:(UIButton *)button {
    // 获取当前选中模型
    ShoppingCartModel *shoppingCartModel = [self.shoppingCartCommodityArray objectAtIndex:button.tag];
    // 获取当前修改的cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    ShoppingCartCell *cell = [self.shoppingCartTable cellForRowAtIndexPath:indexPath];
    // 商品数量
    NSInteger num = [cell.numTF.text integerValue];
    num -= 1;
    // 当商品数量为0时，提示用户是否删除该商品
    if (num == 0) {
        [AlertAction determineStayLeft:self title:@"提示" message:@"确定删除该商品吗？" determineBlock:^{
            // 删除商品
            [self.shoppingCartCommodityArray removeObject:shoppingCartModel];
            // 判断是否有数据
            if (self.shoppingCartCommodityArray.count == 0) {
                [self showNoDataView:^(UILabel *noLabel, UIImageView *noImage) {
                    [noLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.shoppingCartTable.mas_centerX);
                        make.centerY.equalTo(self.shoppingCartTable.mas_centerY);
                    }];
                }];
            }
            [self.shoppingCartTable reloadData];
            // 购物车商品数量，商品总价赋值
            // 购物车数量
            self.shoppingCartNum = 0;
            // 购物车总价
            self.shoppingCartTotal = 0;
            [self shoppingCartAssignment];
        }];
        return;
    }
    // 次数
    shoppingCartModel.buy_num = num;
    [self.shoppingCartTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    // 购物车商品数量，商品总价赋值
    // 购物车数量
    self.shoppingCartNum -= 1;
    // 购物车总价
    self.shoppingCartTotal = self.shoppingCartTotal - shoppingCartModel.goods.actual_sale_price;
    [self shoppingCartAssignment];
}



#pragma mark - 界面赋值
- (void)shoppingCartAssignment  {
    // 购物车数量
    self.shoppingCartFootView.shoppingCartNum = self.shoppingCartNum;
    // 购物车总价
    self.shoppingCartFootView.totalLabel.text = [NSString stringWithFormat:@"%.2f元", self.shoppingCartTotal];
}


#pragma mark - 布局nav
- (void)shoppingCartLayoutNAV {
    self.navigationItem.title = @"购物车";
    // 左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_close"] style:UIBarButtonItemStyleDone target:self action:@selector(searchLeftBarBtnAction)];
}

#pragma mark - 布局视图
- (void)shoppingCartLayoutView {
    @weakify(self)
    /** 购物车地步操作view */
    self.shoppingCartFootView = [[ShoppingCartFootView alloc] init];
    /** 总价按钮 */
    [self.shoppingCartFootView.totalBtn addTarget:self action:@selector(shoppingCartFootBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 清空商品 */
    [self.shoppingCartFootView.emptyBtn addTarget:self action:@selector(shoppingCartFootBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 购物车 */
    [self.shoppingCartFootView.shoppingCartBtn addTarget:self action:@selector(shoppingCartFootBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 确认收款 */
    [self.shoppingCartFootView.confirmationCollectionBtn addTarget:self action:@selector(shoppingCartFootBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    /** 提交订单 */
    [self.shoppingCartFootView.placeOrderBtn addTarget:self action:@selector(shoppingCartFootBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shoppingCartFootView];
    [self.shoppingCartFootView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    /** 购物车table */
    self.shoppingCartTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.shoppingCartTable.delegate = self;
    self.shoppingCartTable.dataSource = self;
    self.shoppingCartTable.backgroundColor = CLEARCOLOR;
    self.shoppingCartTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shoppingCartTable.rowHeight = 146;
    [self.view addSubview:self.shoppingCartTable];
    [self.shoppingCartTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.shoppingCartTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.shoppingCartFootView.mas_top).offset(-10);
    }];
}
#pragma mark - table代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shoppingCartCommodityArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"shoppingCartCommodityCell";
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ShoppingCartCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ShoppingCartModel *shoppingCartModel = self.shoppingCartCommodityArray[indexPath.row];
    cell.shoppingCartModel = shoppingCartModel;
    cell.addBtn.tag = indexPath.row;
    cell.subBtn.tag = indexPath.row;
    cell.pretiumView.usedCellBtn.tag = indexPath.row;
    [cell.addBtn addTarget:self action:@selector(shoppingCartAddBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.subBtn addTarget:self action:@selector(shoppingCartSubBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.pretiumView.usedCellBtn addTarget:self action:@selector(pretiumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
