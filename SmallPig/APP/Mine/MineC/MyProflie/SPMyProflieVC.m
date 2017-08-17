//
//  SPMyKungFuVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyProflieVC.h"
#import "SPMyProflieHeader.h"
#import "SPKungFuCell.h"
#import "SPTagCell.h"
#import "SPKungFuModel.h"

#import "SPUser.h"

#import "SPMyTagVC.h"
#import "SPMyKungFuVC.h"
#import "SPMyBaseProfileVC.h"


//测试
#import "SPMylevelVC.h"

@interface SPMyProflieVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,SPMyBaseProfileVCDelegate>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)SPMyProflieHeader *tableHeader;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)SPUser *user;

@end

@implementation SPMyProflieVC

#pragma  mark - cycle lefe

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createNav];
    
    [self.view addSubview:self.tableView];
    //请求数据
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma  mark - 请求数据
-(void)loadData{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"code"];
    [[HttpRequest sharedClient]httpRequestPOST:kUrlGetUser parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        self.user = [SPUser mj_objectWithKeyValues:responseObject[@"data"]];
        self.tableHeader.user = self.user;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.user.skills.count;
    }else{
        return self.user.tags.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SPKungFuCell*cell = [tableView dequeueReusableCellWithIdentifier:SPKungFuCellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[SPKungFuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPKungFuCellID];
        }
            SPKungFuModel *model1 = self.user.skills[indexPath.row];
            cell.model2 = model1;
//            cell.indexRow = indexPath.row;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        SPTagCell*cell = [tableView dequeueReusableCellWithIdentifier:SPTagCellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[SPTagCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPTagCellID];
        }
        SPKungFuModel *model1 = self.user.tags[indexPath.row];
        [cell setMyCenterModel:model1];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPKungFuModel *model1 = [[SPKungFuModel alloc]init];
    
    if (indexPath.section == 0) {
         model1 = self.user.skills[indexPath.row];
    }else{
        model1  =self.user.tags[indexPath.row];
    }
    
    return model1.subProperties.count/4*40+(model1.thirdLevelArr.count%4==0?0:1)*40;
    
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *base  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 60)];
    base.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_W-20, 1)];
    line.backgroundColor =[UIColor lightGrayColor];
    [base addSubview:line];
    
    UILabel *sectionView = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, SCREEN_W, 40)];
    if (section == 0) {
        sectionView.text = @"武功";
    }else{
        sectionView.text = @"标签";
    }
    
    sectionView.font = BoldFont(16);
    [base addSubview:sectionView];
    return base;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf;
    if (indexPath.section == 0) {
        SPKungFuModel *model = self.user.skills[indexPath.row];
        SPMyKungFuVC *vc = [[SPMyKungFuVC alloc]init];
        vc.formMyCenter = YES;
        vc.code = model.code;
        //保存完 pop回来，刷新
        vc.perfaceBlock = ^(NSDictionary *dict){
            [weakSelf loadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        SPMyTagVC *vc = [[SPMyTagVC alloc]init];
        vc.formMyCenter = YES;
        //保存完 pop回来，刷新
        vc.perfaceBlock = ^(NSDictionary *dict){
            [weakSelf loadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma  mark - SPMyBaseProfileVCDelegate

-(void)backLastUser:(SPUser *)user{
    
    self.tableHeader.user = user;
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SPKungFuCell class] forCellReuseIdentifier:SPKungFuCellID];
        [_tableView registerClass:[SPTagCell class] forCellReuseIdentifier:SPTagCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableHeaderView = self.tableHeader;
    }
    return _tableView;
}

-(SPMyProflieHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[SPMyProflieHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 240)];
        WeakSelf;
        _tableHeader.proflieHeaderBLock =^(NSInteger tag){
            //跳转
            if (tag == 0) {
                //我的基础设置
                SPMyBaseProfileVC *vc = [[SPMyBaseProfileVC alloc]init];
                vc.user = weakSelf.user;
                vc.delegate = weakSelf;
                [weakSelf.navigationController pushViewController:vc animated:YES];

            }else if (tag == 1){
                //我的等级
                SPMylevelVC *vc = [[SPMylevelVC alloc]init];
                vc.user = weakSelf.user;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
               };
    }
    return _tableHeader;
}

-(void)createNav{
    
    self.titleLabel.text = @"详细";
    self.titleLabel.textColor = TitleColor;
//    [self.leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
//    self.title = @"详细";
//    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
//    [save setTitle:@"保存" forState:0];
//    [save setTitleColor:[UIColor blackColor] forState:0];
//    UIBarButtonItem *saveBtn=[[UIBarButtonItem alloc]initWithCustomView:save];
//    self.navigationItem.rightBarButtonItem = saveBtn;
    //将navigation设置为透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
}

#pragma  mark - backClick
-(void)backClick{

    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
