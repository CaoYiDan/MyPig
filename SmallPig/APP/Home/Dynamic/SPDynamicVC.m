//
//  HomeViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicVC.h"

#import "SPDynamicCell.h"

#import "SPDynamicFrame.h"
#import "SPDynamicSectionView.h"
#import "SPActivityWebVC.h"
#import "SPHomeDataManager.h"
#import "SPPhotosView.h"
#import "SPDynamicDetialVC.h"
#import "SPDynamicHeader.h"
#import "SPActivityVC.h"
#import "SPDynamicModel.h"
//test
#import "SPHomeViewController.h"

@interface SPDynamicVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)SPDynamicHeader *header;
@end

@implementation SPDynamicVC
{
    NSInteger _page;//请求数据的页数
    NSString *_score;//请求数据时传的时间参数
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.header;

    //请求活动接口 和请求动态数据接口
    [self loadActivity];
    
    //注册 ，当发布完成之后，返回 刷新界面
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableView)
                                                 name:NotificationPublishFinish
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark - 请求数据
//请求活动接口
-(void)loadActivity{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:@"1" forKey:@"pageNum"];
    [dict setObject:@"10" forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlActivityList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        _header.activityArr = responseObject[@"data"];
        //请求动态数据接口
        [self refreshData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        Toast(@"网络错误");
    }];
}

-(void)refreshData{
    
    _page=0;
    
   [SPHomeDataManager refreshHomeDatesuccess:^(NSArray *items, BOOL lastPage, NSString *score) {
       //记录最靠后的时间
       _score = score;
       
       self.listArray = (NSMutableArray *)items;
       
       [self.tableView.mj_header endRefreshing];
       self.tableView.mj_footer.hidden = NO;
       
       [MBProgressHUD hideHUDForView:self.view animated:YES];
       
       [self.tableView reloadData];
       
   } failure:^(NSError *NSError) {
       [self.tableView.mj_header endRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
   }];
}

//加载更多
-(void)loadMore{
    _page ++;
    [SPHomeDataManager getMoreHomeDateWithPage:_page scoree:_score success:^(NSArray *items, BOOL lastPage, NSString *score) {
        
        _score = score;
        
        [self.listArray addObjectsFromArray:items];
        
        [self.tableView.mj_footer endRefreshing];
        
        if (items.count == 0) {
            Toast(@"已经到底了");
            self.tableView.mj_footer.hidden = YES;
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *NSError) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
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
    SPDynamicCell*cell = [SPDynamicCell cellWithTableView:tableView indexPath:indexPath];
    cell.statusFrame = self.listArray[indexPath.row];
    cell.backgroundColor = BASEGRAYCOLOR;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPDynamicFrame *frame = self.listArray[indexPath.row];
    return frame.cellHeight;
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[SPDynamicSectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 60)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPDynamicFrame *modelF = self.listArray[indexPath.row];
    
    SPDynamicDetialVC*vc = [[SPDynamicDetialVC alloc]init];
    vc.model = modelF.status;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark - setter

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H-49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SPDynamicCell class] forCellReuseIdentifier:SPHomeCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        
        //header
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadActivity)];
        // footer
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        
    }
    return _tableView;
}

-(SPDynamicHeader *)header{
    if (!_header) {
        WeakSelf;
        _header = [[SPDynamicHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/4+106)];
        _header.moreBlock=^(){
            SPActivityVC *vc=  [[SPActivityVC alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _header;
}

#pragma  mark -action

-(void)reloadTableView{
    [self.tableView.mj_header beginRefreshing];
}
@end
