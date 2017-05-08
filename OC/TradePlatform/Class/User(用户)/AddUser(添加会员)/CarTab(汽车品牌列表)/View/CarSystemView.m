//
//  CarSystemView.m
//  CarRepairFactory
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarSystemView.h"
//#import "CarSystemModel.h"
#import "SubBrandModel.h"
// 下级页面控制器

@interface CarSystemView ()<UITableViewDelegate, UITableViewDataSource>

/** 车系table */
@property (strong, nonatomic) UITableView *carSystemTable;
/** 头部车品牌名 */
@property (strong, nonatomic) UILabel *headerCarBrandName;
/** 每个车系名数据 */
@property (strong, nonatomic) NSMutableArray *subBrandArray;


@end

@implementation CarSystemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self carSystemLayoutView];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self carSystemLayoutView];
    }
    return self;
}

#pragma mark - 赋值方法
- (void)setCarBrandSystem:(CarBrandModel *)carBrandSystem {
    _carBrandSystem = carBrandSystem;
    if (_carBrandSystem) {
        [SubBrandModel requestCarSeriesCarBrand:[NSString stringWithFormat:@"%ld",(long) carBrandSystem.car_brand_series_id] success:^(NSMutableArray *subBrandArray) {
            self.headerCarBrandName.text = carBrandSystem.name;
            self.subBrandArray = subBrandArray;
            [self.carSystemTable reloadData];
        }];
    }
}

#pragma mark - 布局方法
- (void)carSystemLayoutView {
    self.backgroundColor = WhiteColor;
    /** 头部车品牌名 */
    self.headerCarBrandName = [[UILabel alloc] init];
    [self addSubview:self.headerCarBrandName];
    /** 车系table */
    self.carSystemTable = [[UITableView alloc] init];
    self.carSystemTable.delegate = self;
    self.carSystemTable.dataSource = self;
    // tableview高度随数据高度变化而变化
    [self.carSystemTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self addSubview:self.carSystemTable];
}
#pragma mark - tableView代理方法l
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.subBrandArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.subBrandArray.count) {
        SubBrandModel *subBrandModel = self.subBrandArray[section];
        return subBrandModel.series_version.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"carSystemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    SubBrandModel *subBrandModel = self.subBrandArray[indexPath.section];
    CarStoryModel *carStoryModel = subBrandModel.series_version[indexPath.row];
    cell.textLabel.text = carStoryModel.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SubBrandModel *subBrandModel = self.subBrandArray[section];
    return subBrandModel.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取车系数据
    SubBrandModel *subBrandModel = self.subBrandArray[indexPath.section];
    CarStoryModel *carStoryModel = subBrandModel.series_version[indexPath.row];
    // 创建一个新的车辆属性，传递到添加车辆界面。
    CWFUserCarModel *brandNewCar = [[CWFUserCarModel alloc] init];
    brandNewCar.image = self.carBrandSystem.image;
    brandNewCar.car_brand_name = subBrandModel.name;
    brandNewCar.car_series_name = carStoryModel.name;
    brandNewCar.car_brand_id = [NSString stringWithFormat:@"%ld", (long)self.carBrandSystem.car_brand_series_id];
    brandNewCar.car_series_id = [NSString stringWithFormat:@"%ld", (long)carStoryModel.car_brand_series_id];
    if (_carSystemBlack) {
        _carSystemBlack(brandNewCar);
    }
    [[self viewController].navigationController popViewControllerAnimated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    /** 头部车品牌名 */
    self.headerCarBrandName.frame = CGRectMake(15, 0, self.width, 50);
    /** 车系table */
    self.carSystemTable.frame = CGRectMake(0, 50, self.width, self.height - 50);
}


@end
