//
//  SPMyKungFuVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyBaseProfileVC.h"
#import "SPMyProflieHeader.h"
#import "SPKungFuCell.h"
#import "SPKungFuModel.h"
#import "SPSixPhotoView.h"
#import "SPUser.h"

#import "SPCommon.h"
#import "SPPerfecSexVC.h"
#import "BDImagePicker.h"
#import "SPPerfectNameVC.h"
#import "SPPerfectBirthDayVC.h"
#import "SPBaseEditVC.h"

#import "SPMyCenterCell.h"
@interface SPMyBaseProfileVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic ,strong)UITableView *tableView;

@property (nonatomic, strong) SPSixPhotoView *headerView;

@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)NSArray *textArr;
@property(nonatomic ,strong)NSArray *imgArr;
@end

@implementation SPMyBaseProfileVC

#pragma  mark - lefe cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    self.textArr = @[@"性别",@"昵称",@"生日",@"工作经验",@"工作领域",@"行业",@"来自",@"经常出没",@"我的签名"];
    self.imgArr = @[@"c_sex",@"c_name",@"c_birthday",@"c_expersence",@"c_industry",@"c_hang",@"c_form",@"c_often",@"c_sign"];
    
    [self sNavigation];
    
    [self.view addSubview:self.tableView];
   
    //创建头部相册布局
    [self createHeader];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma  mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.textArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPMyCenterCell*cell = [tableView dequeueReusableCellWithIdentifier:SPMyCenterCellID forIndexPath:indexPath];
    
        if (cell == nil) {
            cell = [[SPMyCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPMyCenterCellID];
        }
    
    [cell.imageView setImage:[UIImage imageNamed:self.imgArr[indexPath.row]]];
    cell.textLabel.text = self.textArr[indexPath.row];
    cell.textLabel.font = kFontNormal;
    [cell setMyText: [self stringForIndex:indexPath.row]];
    
    return cell;
}

-(NSString *)stringForIndex:(NSInteger)row{
    NSString *contentText = @"";
    switch (row) {
        case 0:
            if (self.user.gender) {
                contentText = @"男";
            }else{
                contentText= @"女";
            }
            break;
        case 1:
            contentText = self.user.nickName;
            
            break;
        case 2:
            contentText = self.user.birthday;
            
            break;
        case 3:
            contentText = self.user.experience;
            
            break;
        case 4:
            contentText = self.user.domain;
            
            break;
        case 5:
            contentText =self.user.job;
            break;
        case 6:
            contentText =self.user.beFrom;
            break;
        case 7:
            contentText =self.user.haunt;
            break;
        case 8:
            contentText =self.user.signature;
            break;
        default:
            break;
    }
    
    if (isEmptyString(contentText)) {
        return @"请选择";
    }else{
        return contentText;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf;
    if (indexPath.row == 0) {
        SPPerfecSexVC *vc = [[SPPerfecSexVC alloc]init];
        vc.formMyCenter = YES;
        vc.perfaceBlock = ^(NSDictionary *dict){
            weakSelf.user.gender = [dict[@"gender"] integerValue];
            //更新相关界面
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row ==1){
        SPPerfectNameVC *vc = [[SPPerfectNameVC alloc]init];
        vc.formMyCenter = YES;
        vc.perfaceBlock = ^(NSDictionary *dict){
            
            weakSelf.user.nickName = dict[@"nickName"];
            //更新相关界面
            [weakSelf.tableView reloadData];
            //代理回传更改详细信息
            [weakSelf.delegate backLastUser:weakSelf.user];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row ==2){
        SPPerfectBirthDayVC *vc = [[SPPerfectBirthDayVC alloc]init];
        vc.formMyCenter = YES;
        vc.perfaceBlock = ^(NSDictionary *dict){
            weakSelf.user.birthday= dict[@"birthday"];
            //更新相关界面
            [weakSelf.tableView reloadData];
            //代理回传更改详细信息
            [weakSelf.delegate backLastUser:weakSelf.user];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row ==3){
        //工作经验
        SPBaseEditVC *vc = [[SPBaseEditVC alloc]init];
        NSString *code =@"experience";//关键词
        vc.codeText = code;
        vc.formMyCenter = YES;
         vc.titletText = @"工作经验";
        vc.perfaceBlock= ^(NSDictionary *dict){
            weakSelf.user.experience = dict[code];
            //更新相关界面
            [weakSelf.tableView reloadData];
            //代理回传更改详细信息
            [weakSelf.delegate backLastUser:weakSelf.user];
        };
        [self.navigationController pushViewController:vc animated:YES];    }else if (indexPath.row ==4){
            //工作领域
        SPBaseEditVC *vc = [[SPBaseEditVC alloc]init];
        NSString *code =@"domain";//关键词
        vc.codeText = code;
        vc.formMyCenter = YES;
        vc.titletText = @"工作领域";
        vc.perfaceBlock = ^(NSDictionary *dict){
            weakSelf.user.domain = dict[code];
            //更新相关界面
            [weakSelf.tableView reloadData];
            //代理回传更改详细信息
            [weakSelf.delegate backLastUser:weakSelf.user];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row ==5){
        //行业
        SPBaseEditVC *vc = [[SPBaseEditVC alloc]init];
        NSString *code1 =@"job";//关键词
        vc.codeText = code1;
        vc.formMyCenter = YES;
         vc.titletText = @"行业";
        vc.perfaceBlock = ^(NSDictionary *dict){
            weakSelf.user.job= dict[code1];
            //更新相关界面
            [weakSelf.tableView reloadData];
            //代理回传更改详细信息
            [weakSelf.delegate backLastUser:weakSelf.user];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row ==6){
        //来自
        SPPerfectNameVC *vc = [[SPPerfectNameVC alloc]init];
        vc.formMyCenter = YES;
        vc.perfaceBlock = ^(NSDictionary *dict){
            weakSelf.user.beFrom = dict[@"beFrom"];
            //更新相关界面
            [weakSelf.tableView reloadData];
            //代理回传更改详细信息
            [weakSelf.delegate backLastUser:weakSelf.user];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row ==7){
        //经常出没
        SPPerfectNameVC *vc = [[SPPerfectNameVC alloc]init];
        vc.formMyCenter = YES;
        vc.perfaceBlock = ^(NSDictionary *dict){
            weakSelf.user.haunt = dict[@"haunt"];
            //更新相关界面
            [weakSelf.tableView reloadData];
            //代理回传更改详细信息
            [weakSelf.delegate backLastUser:weakSelf.user];
        };
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row ==8){
        //个性签名
        SPBaseEditVC *vc = [[SPBaseEditVC alloc]init];
        NSString *code =@"signature";//关键词
        vc.codeText = code;
        vc.formMyCenter = YES;
        vc.titletText = @"个性签名";
        vc.perfaceBlock = ^(NSDictionary *dict){
            weakSelf.user.signature = dict[code];
            //更新相关界面
            [weakSelf.tableView reloadData];
            //代理回传更改详细信息
            [weakSelf.delegate backLastUser:weakSelf.user];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H2-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 42;
        _tableView.backgroundColor = BASEGRAYCOLOR;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SPMyCenterCell class] forCellReuseIdentifier:SPMyCenterCellID];
    }
    return _tableView;
}

//创建头部相册布局
-(void)createHeader{
    
    self.headerView = [[SPSixPhotoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView setPhotosArr:self.user.avatarList];
    WeakSelf;
    self.headerView.sixPhotoViewBlock = ^(NSInteger tag){
        [weakSelf photo];
    };
}

-(void)sNavigation{
    
    self.titleLabel.text = @"基础信息";
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    [save setTitle:@"保存" forState:0];
    [save setTitleColor:[UIColor blackColor] forState:0];
    UIBarButtonItem *saveBtn=[[UIBarButtonItem alloc]initWithCustomView:save];
    self.navigationItem.rightBarButtonItem = saveBtn;
}

#pragma  mark - action
-(void)save{
    
}

#pragma  mark 调取相册
-(void)photo{
    WeakSelf;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        //上传图片---获取图片网络地址
//        [weakSelf upDateHeadIcon:image];
//        _photoImage=image;
//        [weakSelf.layoutView setMyPhoto:image];
    }];
}
#pragma  mark 上传图片
//- (void)upDateHeadIcon:(UIImage *)photo{
//    if (isNull(photo)) {
//        return;
//    }
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                                                         
//                                                         @"text/html",
//                                                         
//                                                         @"image/jpeg",
//                                                         
//                                                         @"image/png",
//                                                         
//                                                         @"application/octet-stream",
//                                                         
//                                                         @"text/json",
//                                                         
//                                                         nil];
//    
//    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
//    
//    NSData * imageData = UIImageJPEGRepresentation(photo,0.5);
//    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"text"];
//    [imageData writeToFile:fullPath atomically:NO];
//    
//    NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
//    [dictT setObject:imageData forKey:@"image"];
//    
//    [manager POST:kPostPhoto parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:imageData name:@"image" fileName:@"text.jpg" mimeType:@"image/jpg"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        //将二进制转为字符串
//        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//        //字符串转字典
//        NSDictionary*dict=[SPCommon dictionaryWithJsonString:result2];
//        NSLog(@"%@",dict);
//        //上传用户头像路径
////        [self postPhotoWithImagePath:dict[@"image"]];
//        //给用户头像赋值
////        [_headerView setImage:_photoImage];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        ToastError(@"上传失败");
//    }];
//}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
