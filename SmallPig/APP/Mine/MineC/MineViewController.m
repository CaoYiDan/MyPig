//
//  MineViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/31.
//  Copyright © 2017年 李智帅. All rights reserved.
//


//第三方角标
#import "UIView+Frame.h"
#import "WZLBadgeImport.h"
//第三方上传头像
#import "BDImagePicker.h"
//进度条
#import "HWProgressView.h"
//本地
#import "MineViewController.h"
#import "RegisterViewController.h"
#import "MineSetViewController.h"
#import "SPMyAppointmentVC.h"//预约
#import "SPMyProflieVC.h"//我的详细

//测试
#import "SPPerfecSexVC.h"
#import "SPMyKungFuVC.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
//个人中心底部分类
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * titleImageArr;
@property (nonatomic,strong) NSMutableArray * titleBtnNumArr;
@property (nonatomic,strong) NSMutableArray * badgeNumArr;
//tableHead部分
@property(nonatomic,copy) NSString * notBigCow;
@property(nonatomic,copy) NSString * nickStr;
@property(nonatomic,copy) NSString * signatureStr;
@property(nonatomic,assign) NSInteger topRightGradeStr;
@property(nonatomic,copy) NSString * topRightGoodStr;
@property(nonatomic,copy) NSString * headImageStr;
@property(nonatomic,strong) UILabel * nickNameLab;
@property(nonatomic,strong) UIImageView * topRightIV;
@property(nonatomic,strong) UILabel * topRightGradeLab;
@property(nonatomic,strong) UILabel * topRightGoodLab;
@property(nonatomic,strong) UIImageView * headIV;
@property(nonatomic,strong) UILabel * signatureLab;
@property (nonatomic, weak) HWProgressView *progressView;//进度条
@property (nonatomic, strong) NSTimer *timer;//进度条
@property(nonatomic,assign)CGFloat timerProgerss;

//主页面
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UIView * headView;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAINCOLOR;
    [self createNAV];
    //[self creshUI];
//    if (![StorageUtil getId]) {
//        
//        [self logined];
//    }else{
//    
//        [self login];
//    }
//
//    SPMyKungFuVC *vc= [[SPMyKungFuVC alloc]init];
//    [self.navigationController pushViewController: vc animated:YES];
//    return;
    
//    [self createUI];
    
}
//#pragma mark - 刷新
//- (void)creshUI{
//
//    self.tableView.header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    [self.tableView.header beginRefreshing];
//}

- (void)loadNewData{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"1549950269066756729" forKey:@"code"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlMine parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"lizhi%@",responseObject);
        self.nickStr = responseObject[@"data"][@"nickName"];
        self.topRightGradeStr = [responseObject[@"data"][@"level"] integerValue];
        //不是大咖
        self.notBigCow = responseObject[@"data"][@"levelName"];
        self.topRightGoodStr = responseObject[@"data"][@"liked"];;
        self.timerProgerss = [responseObject[@"data"][@"infoPercent"] integerValue]/100;
        self.signatureStr = responseObject[@"data"][@"signature"];
        self.headImageStr = responseObject[@"data"][@"avatar"];
        //总数
        [self.titleBtnNumArr addObject:responseObject[@"data"][@"reservationNum"]];
        [self.titleBtnNumArr addObject:responseObject[@"data"][@"feedNum"]];
        [self.titleBtnNumArr addObject:responseObject[@"data"][@"friendNum"]];
        [self.titleBtnNumArr addObject:responseObject[@"data"][@"messageNum"]];
        //新动态
        [self.badgeNumArr addObject:responseObject[@"data"][@"newReservationNum"]];
        [self.badgeNumArr addObject:responseObject[@"data"][@"newFeedNum"]];
        [self.badgeNumArr addObject:responseObject[@"data"][@"newFriendNum"]];
        [self.badgeNumArr addObject:responseObject[@"data"][@"newMessageNum"]];
        
        [self createUI];
        [self logined];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - createUI
- (void)createUI{
    
    self.titleArr = @[@"兴趣设置",@"我的等级",@"应用分享",@"最近来访",@"黑名单"];
    self.titleImageArr = @[@"me_r11_c1",@"me_r15_c1",@"me_r17_c1",@"me_r19_c1",@"me_r21_c1"];

    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H-44) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.backgroundColor = WC;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.headView.backgroundColor = WC;
    
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - login去登陆
- (void)login{

    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"dl_pic"];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGoLogin)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    [self.headView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(30);
        make.left.offset(SCREEN_W/2-60);
        make.size.with.offset(120);
        make.size.height.offset(120);
        
    }];
    UILabel * perfectLab = [[UILabel alloc]init];
    perfectLab.text = @"档案完善度:0%";
    perfectLab.textColor = [UIColor blackColor];
    perfectLab.textAlignment = NSTextAlignmentCenter;
    perfectLab.font = [UIFont boldSystemFontOfSize:15];
    [self.headView addSubview:perfectLab];
    
    [perfectLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.left.offset (SCREEN_W/2-60);
        make.width.offset(120);
        make.height.offset(40);
        
    }];
    [self mineCategory:200];
    
}

#pragma mark - tapGoLogin点击登录
- (void)tapGoLogin{

    RegisterViewController * registerVC = [[RegisterViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self presentViewController:registerVC animated:YES completion:nil];
    
}
#pragma mark - logined已经登录
- (void)logined{

    
    self.nickNameLab = [[UILabel alloc]init];
    self.nickNameLab.text = self.nickStr;
    self.nickNameLab.textColor = [UIColor blackColor];
    self.nickNameLab.textAlignment = NSTextAlignmentLeft;
    self.nickNameLab.font = [UIFont boldSystemFontOfSize:17];
    [self.headView addSubview:self.nickNameLab];
    
    [self.nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(10);
        make.left.offset(10);
        make.width.offset(SCREEN_W/2);
        make.height.offset(30);
        
    }];
    //详情
    UIButton * detailsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailsBtn setImage:[UIImage imageNamed:@"me_xq"] forState:UIControlStateNormal];
    [detailsBtn addTarget:self action:@selector(detailsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView addSubview:detailsBtn];
    
    [detailsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nickNameLab.mas_bottom).offset(-2);
        make.left.offset(-5);
        make.width.offset(100);
        make.height.offset(25);
        
    }];
    
    
    
    self.topRightIV = [[UIImageView alloc]init];
    self.topRightIV.image = [UIImage imageNamed:@"sp_r3_c13"];
    [self.headView addSubview:self.topRightIV];
    
    [self.topRightIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(10);
        make.right.offset(-10);
        make.width.offset(110);
        make.height.offset(45);
        
    }];
    
    //等级
    UILabel * gredeLab = [[UILabel alloc]init];
    self.topRightGradeLab = gredeLab;
    NSLog(@"self.topRightGradeStr%ld",self.topRightGradeStr);
    gredeLab.text =[NSString stringWithFormat:@"%ld",self.topRightGradeStr];
    gredeLab.textColor = [UIColor whiteColor];
    gredeLab.textAlignment = NSTextAlignmentCenter;
    gredeLab.font = [UIFont boldSystemFontOfSize:16];
    [self.topRightIV addSubview:gredeLab];
    
    [gredeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.topRightIV.mas_top).offset(12);
        make.left.equalTo(self.topRightIV.mas_left).offset(21);
        make.width.offset(20);
        make.height.offset(20);
        
    }];
    
    
    //点赞
    UILabel * goodLab = [[UILabel alloc]init];
    self.topRightGoodLab = gredeLab;
    goodLab.text = gredeLab.text =[NSString stringWithFormat:@"%@",self.topRightGoodStr];
    goodLab.textColor = [UIColor whiteColor];
    goodLab.textAlignment = NSTextAlignmentLeft;
    goodLab.font = [UIFont boldSystemFontOfSize:10];
    [self.topRightIV addSubview:goodLab];
    
    [goodLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.topRightIV.mas_top).offset(15);
        make.right.equalTo(self.topRightIV.mas_right).offset(10);
        make.width.offset(50);
        make.height.offset(20);
        
    }];
    
    UIImageView * imageView = [[UIImageView alloc]init];
    self.headIV = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.headView addSubview:imageView];

    if (self.headImageStr) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.headImageStr]]];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.topRightIV.mas_bottom).offset(10);
            make.left.offset(10);
            make.width.offset(SCREEN_W-20);
            make.height.offset(200);
            
            
        }];
    }else{
    
        imageView.image = [UIImage imageNamed:@"tx_pic"];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.nickNameLab.mas_bottom).offset(10);
            make.left.offset(SCREEN_W/2-80);
            make.size.width.offset(160);
            make.size.height.offset(160);
            
        }];
    }
    //点击上传头像
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headIMGTap)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];

    //签名

    self.signatureLab = [[UILabel alloc]init];
    self.signatureLab.text = self.signatureStr;
    self.signatureLab.textColor = [UIColor blackColor];
    self.signatureLab.textAlignment = NSTextAlignmentCenter;
    self.signatureLab.font = [UIFont systemFontOfSize:13];
    
    self.signatureLab.numberOfLines = 0;//表示label可以多行显示UILineBreakModeCharacterWrap
    
    self.signatureLab.lineBreakMode = NSLineBreakByWordWrapping;//换行模式，与上面的计算保持一致。
    
    [self.headView addSubview:self.signatureLab];
    
    [self.signatureLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(imageView.mas_bottom).offset(5);
        make.left.offset (20);
        make.width.offset(SCREEN_W-40);
        make.height.offset(40);
        
    }];
    
    
    UILabel * perfectLab = [[UILabel alloc]init];
    perfectLab.text = [NSString stringWithFormat:@"档案完善度:%.f%@",self.timerProgerss *100,@"%"];
    perfectLab.textColor = KProgressColor;
    perfectLab.textAlignment = NSTextAlignmentLeft;
    perfectLab.font = [UIFont boldSystemFontOfSize:13];
    [self.headView addSubview:perfectLab];
    
    [perfectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.signatureLab.mas_bottom).offset(10);
        make.left.offset (10);
        make.width.offset(120);
        make.height.offset(20);
        
    }];
    
    //去完善档案button
    UIButton * perfectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [perfectBtn setTitle:@"去完善档案>" forState:UIControlStateNormal];
    [perfectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [perfectBtn addTarget:self action:@selector(perfectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView addSubview:perfectBtn];
    
    [perfectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(perfectLab.mas_top);
        make.right.offset(-10);
        make.width.offset(110);
        make.height.offset(20);
        
    }];
    
    //进度条
    HWProgressView *progressView = [[HWProgressView alloc] initWithFrame:CGRectMake(10, perfectLab.frame.origin.y+22, SCREEN_W-20, 20)];
    
    [self.headView addSubview:progressView];
    self.progressView = progressView;
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(perfectLab.mas_bottom).offset(2);
        make.left.equalTo(perfectLab.mas_left);
        make.width.offset(SCREEN_W-20);
        make.height.offset(20);
        
    }];
    [self addTimer];
    
    [self mineCategory:370];
    
}

#pragma  mark 上传图片
- (void)upDateHeadIcon:(UIImage *)photo{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         
                                                         @"text/html",
                                                         
                                                         @"image/jpeg",
                                                         
                                                         @"image/png",
                                                         
                                                         @"application/octet-stream",
                                                         
                                                         @"text/json",
                                                         
                                                         nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    NSData * imageData = UIImageJPEGRepresentation(photo,0.5);
    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"text"];
    [imageData writeToFile:fullPath atomically:NO];
    NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
    [dictT setObject:imageData forKey:@"image"];
    
    [manager POST:kUrlMine parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"text.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSData * data = responseObject;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        NSLog(@"dic%@",dic);
        NSLog(@"responseObject%@",responseObject);
        NSString * result = dic[@"image"];
        //[self headImageStr:result];
        NSLog(@"result%@",result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error%@",error);
    }];
}
- (void)headIMGTap{
    
    __weak typeof(self) weakSelf = self;
    
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            
            [self.headIV setImage:image];
            [weakSelf upDateHeadIcon:image];
        }
        
    }];
}

#pragma mark - detailsBtnClick 详情
- (void)detailsBtnClick{

    SPMyProflieVC * profileVC= [[SPMyProflieVC alloc]init];
    
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:profileVC animated:NO];
}
#pragma mark - perfectBtnClick去完善按钮
- (void)perfectBtnClick{

    
}

#pragma mark - 分类
- (void)mineCategory:(CGFloat )bottom{

    if (bottom>200) {
        self.headView.frame = CGRectMake(0, 0, SCREEN_W, 460);
        //bottom = 300;
    }else{
    
        //总数
        [self.titleBtnNumArr addObject:@0];
        [self.titleBtnNumArr addObject:@0];
        [self.titleBtnNumArr addObject:@0];
        [self.titleBtnNumArr addObject:@0];
        //新动态
        [self.badgeNumArr addObject:@"0"];
        [self.badgeNumArr addObject:@"0"];
        [self.badgeNumArr addObject:@"0"];
        [self.badgeNumArr addObject:@"0"];
    }
    NSArray * imageArr = @[@"me_r7_c2",@"me_r7_c7",@"me_r7_c9",@"me_r7_c14"];
    
    NSLog(@"%@ %@",self.badgeNumArr,self.titleBtnNumArr);
    
    for (int i = 0; i<4; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * (SCREEN_W/4),bottom, SCREEN_W/4-10,60);
        //[btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(mineCategoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = btn.width /2;
        
        //角标
        btn.badgeBgColor = [UIColor redColor];
        btn.badgeCenterOffset = CGPointMake(-15,+10);
        NSInteger value = [self.badgeNumArr[i] integerValue];
        [btn showBadgeWithStyle:WBadgeStyleNumber value:value animationType:WBadgeAnimTypeScale];
        
        UIButton * btnLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLabel.frame = CGRectMake(btn.frame.origin.x+btn.frame.size.width/4, btn.frame.origin.y + btn.frame.size.height+3, btn.frame.size.width/2, 20);
        [btnLabel setBackgroundImage:[UIImage imageNamed:@"me_r9_c4"] forState:UIControlStateNormal];
        
        [btnLabel setTitle:[self.titleBtnNumArr[i] stringValue] forState:UIControlStateNormal];
        
        btnLabel.selected = NO;
        [self.headView addSubview:btnLabel];
        [self.headView addSubview:btn];
        
    }
    
    
}

#pragma mark - mineCategoryBtnClick分类点击事件
- (void)mineCategoryBtnClick:(UIButton *)btn{

    if ([StorageUtil getId]) {
        
        if (btn.tag==1) {
            
            SPMyAppointmentVC * reserveVC = [[SPMyAppointmentVC alloc]init];
            
            
            self.hidesBottomBarWhenPushed = YES;
            self.tabBarController.tabBar.hidden=YES;
            [self.navigationController pushViewController:reserveVC animated:NO];
            
        }else if (btn.tag==2) {
            
//            SPReserveViewController * reserveVC = [[SPReserveViewController alloc]init];
//            
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:reserveVC animated:YES];
        }else if (btn.tag==3) {
            
//            SPReserveViewController * reserveVC = [[SPReserveViewController alloc]init];
//            
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:reserveVC animated:YES];
        }else if (btn.tag==4) {
            
//            SPReserveViewController * reserveVC = [[SPReserveViewController alloc]init];
//            
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:reserveVC animated:YES];
        }
        
    }else{
       
        [self tapGoLogin];
        
    }
    
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * mineCell = @"mineCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mineCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSLog(@"%@",self.notBigCow);
    if (indexPath.row==1 &&self.notBigCow.length !=0) {
        
        NSString * gredaStr = [NSString stringWithFormat:@"%@    %@",self.titleArr[indexPath.row],self.notBigCow];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:gredaStr];
        NSRange greenRange = [gredaStr rangeOfString:self.notBigCow];
        [noteStr addAttribute:NSForegroundColorAttributeName value:KProgressColor range:greenRange];
        
        cell.textLabel.attributedText = noteStr;
    }else{
    
        cell.textLabel.text = self.titleArr[indexPath.row];
    }
    
    cell.imageView.image = [UIImage imageNamed:self.titleImageArr[indexPath.row]];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=NO;
    self.hidesBottomBarWhenPushed = NO;
    if ([StorageUtil getId]) {
        [self loadNewData];
       
    }else{
        [self createUI];
        [self login];
    }
    
}

#pragma mark - createNAV
- (void)createNAV{

    self.titleLabel.textColor = TitleColor;
    self.titleLabel.text =@"个人中心";
    [self.rightButton setImage:[UIImage imageNamed:@"me_r1_c15"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightButtonClick{

    MineSetViewController * setVC = [[MineSetViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
//    [self presentViewController:setVC animated:YES completion:nil];
    
}

#pragma mark - lazyLoad

- (UIView *)headView{
    
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 300)];
        _headView.backgroundColor = WC;
    }
    return _headView;
}

- (NSMutableArray *)titleBtnNumArr{

    if (!_titleBtnNumArr) {
        _titleBtnNumArr = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _titleBtnNumArr;
}

- (NSMutableArray *)badgeNumArr{

    if (!_badgeNumArr) {
        _badgeNumArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _badgeNumArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed= YES;
}
#pragma mark - 进度条定时
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction
{
    if (!(self.timerProgerss==0)) {
        _progressView.progress += 0.05;
    }
    
    if (_progressView.progress >= self.timerProgerss) {
        [self removeTimer];
        NSLog(@"完成");
    }
}

- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}


@end
