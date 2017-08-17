//
//  SPReserveMineViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/22.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPReserveMineViewController.h"
#import "HomeModel.h"
#import "HomeCollectionViewCell.h"


@interface SPReserveMineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{

    UICollectionView * _collectionView;
    
    int _start;
    int _end;
}

@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation SPReserveMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    
    [self createUI];
    [self createRefresh];
   
    // Do any additional setup after loading the view.
}

#pragma mark--创建上下拉刷新,及数据请求
- (void)createRefresh{
    
        _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //
        [_collectionView.header beginRefreshing];
   
    //头部刷新
    //    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //    [header setTitle:@"火力全开 加载中 " forState:MJRefreshStateIdle];
    //    [header setTitle:@"松开加载更多" forState:MJRefreshStatePulling];
    //    [header setTitle:@"数据加载中..." forState:MJRefreshStateRefreshing];
    //    tableView.mj_header=header;
    //[tableView.mj_header beginRefreshing];

}
//下拉刷新
- (void)loadNewData{
    
    
    _start = 1;
    //_end = 8;
    [self loadData];
    
}
//上啦加载
- (void)loadMoreData{
    
    _start ++;
    //_end = _end +8;
    
    NSLog(@"%zd,%zd",_end,_start);
    
    [self getMoreData];
    
}

#pragma mark - loadData
- (void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    NSString * kurl;
    if (!self.code) {//0是我的预约
        
        kurl = kUrlMineReserve;
    }else{
    
        kurl = kUrlReserveMine;
    }
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"1549950269066756729" forKey:@"doUser"];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        
        NSLog(@"yuyue%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"][@"list"];
        for (NSDictionary * tempDict in tempArr) {
            
            HomeModel * model = [[HomeModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        [self.dataArr addObjectsFromArray:tempDataArr];
        NSLog(@"dataArr%@",self.dataArr);
        
        [_collectionView reloadData];
        [_collectionView.header endRefreshing];
        
       
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (void)getMoreData{
    
    NSString * kurl;
    
    if (!self.code) {//0是我的预约
        
        kurl = kUrlMineReserve;
    }else{
        
        kurl = kUrlReserveMine;
    }
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"1549950269066756729" forKey:@"doUser"];
    [dict setObject:@(_start) forKey:@"pageNum"];
    [dict setObject:@10 forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSMutableArray * tempDataArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray * tempArr = responseObject[@"data"][@"list"];
        for (NSDictionary * tempDict in tempArr) {
            
            HomeModel * model = [[HomeModel alloc]init];
            
            [model setValuesForKeysWithDictionary:tempDict];
            [tempDataArr addObject:model];
        }
        [self.dataArr addObjectsFromArray:tempDataArr];
        
        [_collectionView reloadData];
        [_collectionView.footer endRefreshing];
        //_collectionView.footer.hidden = YES;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark - createUI
- (void)createUI{

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    //collectionHead用法
    //layout.headerReferenceSize = CGSizeMake(SCREEN_W,SCREEN_H);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(2, 10, SCREEN_W-2 , SCREEN_H - 49) collectionViewLayout:layout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = MAINCOLOR;
    _collectionView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"homeCell"];
    
}
#pragma mark - collectionViewdelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * homeCell = @"homeCell";
    
    HomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCell forIndexPath:indexPath];
    if (self.dataArr) {
        
        HomeModel * model = self.dataArr[indexPath.row];
        [cell refreshUI:model];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_W-4)/2, (SCREEN_W-4)/2 );
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1,0,1,0);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    GoodsDetailVCViewController * goodsVC = [[GoodsDetailVCViewController alloc]init];
//    HomeModel * homeModel = self.dataArr[indexPath.item];
//    goodsVC.goods_idStr = homeModel.goodsId;
//    
//    goodsVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:goodsVC animated:YES];
    
}

#pragma mark -  lazyLoad
- (NSMutableArray * )dataArr{

    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}
@end
