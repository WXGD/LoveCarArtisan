//
//  UsedCarSeriesView.m
//  TradePlatform
//
//  Created by apple on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UsedCarSeriesView.h"

@interface UsedCarSeriesView ()<UITableViewDelegate, UITableViewDataSource>

/** 纵向边线 */
@property (strong, nonatomic) UIView *portraitLineView;
/** 二手车车系table */
@property (strong, nonatomic) UITableView *usedCarSeriesTable;
/** 二手车车系table数据 */
@property (strong, nonatomic) NSMutableArray *usedCarSeriesArray;
/** table头部view */
@property (strong, nonatomic) UIView *tableHeaderView;
/** 品牌图片 */
@property (strong, nonatomic) UIImageView *brandImage;
/** 品牌名 */
@property (strong, nonatomic) UILabel *brandName;

@end

@implementation UsedCarSeriesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self usedCarSeriesLayoutView];
    }
    return self;
}

- (void)setUsedCarBrandModel:(UsedCarBrandModel *)usedCarBrandModel {
    _usedCarBrandModel = usedCarBrandModel;
    /** 品牌名 */
    self.brandName.text = usedCarBrandModel.name;
    /** 品牌图标 */
    [self.brandImage setImageWithImageUrl:usedCarBrandModel.image_src perchImage:@"placeholder_car"];
    /* /index.php?c=usedcar_brand_series&a=list&v=1
     brand_id 	string 	否 	获取车系、车型必传
     series_id 	string 	否 	获取车型必传    */
    NSString *URL = [NSString stringWithFormat:@"%@?c=%@&a=%@&v=%@", API, @"usedcar_brand_series", @"list", APIEdition];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"brand_id"] = [NSString stringWithFormat:@"%ld", usedCarBrandModel.brand_series_id]; // 车品牌ID
    // 发送请求
    [TPNetRequest GET:URL parameters:params ProgressHUD:@"加载中..." falseDate:@"CarBrandTab" parentController:nil success:^(id responseObject) {
        PDLog(@"responseObject%@", responseObject);
        if ([[NSString stringWithFormat:@"%@", responseObject[@"code"]] isEqual:@"0"]) {
            self.usedCarSeriesArray = [UsedCarSeriesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.usedCarSeriesTable reloadData];
        }else {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        PDLog(@"%@", error);
    }];
    
}


#pragma mark - view布局
- (void)usedCarSeriesLayoutView {
    /** 纵向边线 */
    self.portraitLineView = [[UIView alloc] init];
    self.portraitLineView.backgroundColor = DividingLine;
    [self addSubview:self.portraitLineView];
    /** 二手车车系table */
    self.usedCarSeriesTable = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.usedCarSeriesTable.delegate = self;
    self.usedCarSeriesTable.dataSource = self;
    self.usedCarSeriesTable.backgroundColor = CLEARCOLOR;
    self.usedCarSeriesTable.rowHeight = 48;
    self.usedCarSeriesTable.separatorColor = DividingLine;
    self.usedCarSeriesTable.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);        // 设置端距，这里表示separator离左边和右边均80像素
    self.usedCarSeriesTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self addSubview:self.usedCarSeriesTable];
    // tableview高度随数据高度变化而变化
    [self.usedCarSeriesTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    /** table头部view */
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 48)];
    [self.usedCarSeriesTable setTableHeaderView:self.tableHeaderView];
    /** 品牌图片 */
    self.brandImage = [[UIImageView alloc] init];
    [self.tableHeaderView addSubview:self.brandImage];
    /** 品牌名 */
    self.brandName = [[UILabel alloc] init];
    self.brandName.textColor = ThemeColor;
    self.brandName.font = FifteenTypeface;
    [self.tableHeaderView addSubview:self.brandName];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 纵向边线 */
    [self.portraitLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(@0.5);
    }];
    /** 二手车车系table */
    [self.usedCarSeriesTable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.portraitLineView.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    /** 品牌图片 */
    [self.brandImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.tableHeaderView.mas_centerY);
        make.left.equalTo(self.tableHeaderView.mas_left).offset(16);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
    /** 品牌名 */
    [self.brandName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.tableHeaderView.mas_centerY);
        make.left.equalTo(self.brandImage.mas_right).offset(16);
    }];
}

#pragma mark - tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.usedCarSeriesArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    UsedCarSeriesModel *usedCarSeriesModel = [self.usedCarSeriesArray objectAtIndex:section];
    return usedCarSeriesModel.series_version.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"seriesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UsedCarSeriesModel *usedCarSeriesModel = [self.usedCarSeriesArray objectAtIndex:indexPath.section];
    UsedCarBrandModel *usedCarBrandModel = [usedCarSeriesModel.series_version objectAtIndex:indexPath.row];
    cell.textLabel.text =usedCarBrandModel.name;
    cell.textLabel.textColor = Black;
    cell.textLabel.font = FifteenTypeface;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *cellHeaderView = [[UIView alloc] init];
    cellHeaderView.backgroundColor = VCBackground;
    UILabel *cellTitleLabel = [[UILabel alloc] init];
    UsedCarSeriesModel *usedCarSeriesModel = [self.usedCarSeriesArray objectAtIndex:section];
    cellTitleLabel.text = usedCarSeriesModel.name;
    cellTitleLabel.textColor = GrayH2;
    cellTitleLabel.font = ThirteenTypeface;
    [cellHeaderView addSubview:cellTitleLabel];
    [cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cellHeaderView.mas_centerY);
        make.left.equalTo(cellHeaderView.mas_left).offset(16);
    }];
    return cellHeaderView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UsedCarSeriesModel *usedCarSeriesModel = [self.usedCarSeriesArray objectAtIndex:indexPath.section];
    UsedCarBrandModel *usedCarBrandSeriesModel = [usedCarSeriesModel.series_version objectAtIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(UsedCarSeriesSelectCarSeriesModel:carBrandModel:)]) {
        [_delegate UsedCarSeriesSelectCarSeriesModel:usedCarBrandSeriesModel carBrandModel:self.usedCarBrandModel];
    }
    
//    NSArray *usedCarBrandArray = [self.usedCarBrandDic objectForKey:[self.usedCarBrandKeys objectAtIndex:indexPath.section]];
//    UsedCarBrandModel *usedCarBrandModel = [usedCarBrandArray objectAtIndex:indexPath.row];
//    if (_usedCarBrandChoiceBlock) {
//        _usedCarBrandChoiceBlock(usedCarBrandModel);
//    }
//    [self.navigationController popViewControllerAnimated:YES];
}



@end
