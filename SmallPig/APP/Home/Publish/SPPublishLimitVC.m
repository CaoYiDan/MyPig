//
//  SPPublishLocationVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPublishLimitVC.h"
#import "SPChosedCell.h"
//定位服务
#import <CoreLocation/CoreLocation.h>

@interface SPPublishLimitVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,copy)NSString *resultStr;
@property(nonatomic ,copy)NSString *resultText;
@end

@implementation SPPublishLimitVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addRightItem];
    
    [self.view addSubview:self.tableView];
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
    cell.textLabel.text = self.listArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.resultText = self.listArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
            self.resultStr = @"ALL";
            break;
        case 1:
            self.resultStr = @"FRIENDS";
            break;
        case 2:
            self.resultStr = @"ME";
            break;
        default:
            break;
    }
}

-(void)addRightItem{
    
    self.titleLabel.text = @"谁可以看见";
    
    UIButton*rightBtnItem= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 38)];
    [rightBtnItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchDown];
    [rightBtnItem setTitle:@"完成" forState:0];
    [rightBtnItem setTitleColor:[UIColor blackColor] forState:0];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtnItem];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)rightItemClick{
    
    !self.publishLimitBLock?:self.publishLimitBLock(self.resultStr,self.resultText);
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma  mark - setter

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = @[@"所有人可见",@"好友可见",@"仅自己可见"];
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


@end
