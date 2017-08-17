//
//  SPActivityVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPActivityVC.h"
#import "SPActivityCell.h"
#import "SPActivityWebVC.h"

@interface SPActivityVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;
@property(nonatomic,strong)NSMutableArray *listArray;
@end

@implementation SPActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sNav];
    [self creatCollection];
    [self loadActivity];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma  mark - 请求数据
//请求活动接口
-(void)loadActivity{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:@"1" forKey:@"pageNum"];
    [dict setObject:@"10" forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlActivityList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        self.listArray = responseObject[@"data"];
        [self.collectionview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        Toast(@"网络错误");
    }];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPActivityCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPActivityCellID forIndexPath:indexPath];
    cell.activityDict = self.listArray[indexPath.row];
    cell.backgroundColor = HomeBaseColor;
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) return UIEdgeInsetsMake(0, 10, 1, 10);
    
    return UIEdgeInsetsMake(1, 1, 5, 1);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0)  return 20;
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SPActivityWebVC *vc = [[SPActivityWebVC alloc]init];
    
    NSDictionary* activityDict = self.listArray[indexPath.row];
    vc.titleName = activityDict[@"title"];
    vc.code = activityDict[@"code"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark 创建collectionView
-(void)creatCollection{
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_W, SCREEN_W/2+60);
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width,SCREEN_H) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=HomeBaseColor;
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    [_collectionview registerClass:[SPActivityCell class] forCellWithReuseIdentifier:SPActivityCellID];
    [self.view addSubview:_collectionview];
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(void)sNav{
   self.titleLabel.text = @"活动";
   
}

@end
