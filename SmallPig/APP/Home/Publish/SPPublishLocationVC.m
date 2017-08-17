//
//  SPPublishLocationVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPublishLocationVC.h"
#import "SPLocationSearchVC.h"
#import "SPChosedCell.h"
////定位服务
//#import <CoreLocation/CoreLocation.h>

#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

@interface SPPublishLocationVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,AMapSearchDelegate,UITextFieldDelegate>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,copy)NSString *resultStr;
@property(nonatomic ,strong)AMapSearchAPI*search;
@end

@implementation SPPublishLocationVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titleLabel.text = @"位置";
    
    [self.view addSubview:self.tableView];
    
    [self configMapServices];
    
    [self configPoiResquest];
}



#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPChosedCell*cell = [SPChosedCell cellWithTableView:tableView indexPath:indexPath];
    
    cell.textLabel.text =  self.listArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    return [self searchBtn];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *locationStr = @"";
    
    if(indexPath.row!=0){
        
    UITableViewCell *cell =[ tableView cellForRowAtIndexPath:indexPath];
        locationStr = cell.textLabel.text;
    }
    
    !self.publishLocationBlock?:self.publishLocationBlock(locationStr);
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma  mark - -----------------搜索回调delegate-----------------

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0) return;
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [self.listArray addObject:obj.name];
    }];
    
    [self.tableView reloadData];
    
}

#pragma  mark - -----------------action-----------------

-(void)searchClick{
    
    SPLocationSearchVC *vc = [[SPLocationSearchVC alloc]init];
    vc.searchBlock = ^(NSString *searchStr){
        !self.publishLocationBlock?:self.publishLocationBlock(searchStr);
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark ------------- setter

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
        [_listArray addObject:@"不显示位置信息"];
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SPChosedCell class] forCellReuseIdentifier:SPChosedCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0;
    
    }
    return _tableView;
}

-(void)configMapServices{
    
    [AMapServices sharedServices].apiKey = @"c99ca542f1e04e761a92a498c28f9793";
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
}

-(void)configPoiResquest{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:[[StorageUtil getUserLat] floatValue]longitude:[[StorageUtil getUserLon] floatValue]];
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    
    [self.search AMapPOIKeywordsSearch:request];
}

-(UIView *)searchBtn{
    UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, SCREEN_W, 40)];
    [btn setTitle:@"搜索附近位置" forState:0];
    [btn setTitleColor:[UIColor grayColor] forState:0];
    [btn setImage:[UIImage imageNamed:@"nav_hover_r1_c6"] forState:0];
    [btn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    return btn;
}
@end
