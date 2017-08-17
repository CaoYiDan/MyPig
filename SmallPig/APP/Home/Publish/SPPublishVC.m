//
//  LGEvaluateViewController.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/25.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "LGTextView.h"
#import "LGComposePhotosView.h"
#import "SPPublishLimitVC.h"
#import "SPPublishLocationVC.h"
#import "BDImagePicker.h"
#import "SPPublishVC.h"
#import "SPCityVC.h"
//定位服务
#import <CoreLocation/CoreLocation.h>

@interface SPPublishVC ()<UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *cityLab;
@property (nonatomic, strong) UILabel *limitLab;
@property(nonatomic,weak)LGComposePhotosView *photoView;
@property(nonatomic,weak)LGTextView *textView;
@property(nonatomic,copy)NSString *limitStr;
@end

@implementation SPPublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];//导航设置
    self.limitStr = @"ALL";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.middleView];
    self.bottomView.backgroundColor = [UIColor whiteColor];
}

#pragma  mark - setter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _scrollView.contentSize=CGSizeMake(0, SCREEN_W+100);
    }
    return _scrollView;
}

//上半部分创建
- (UIView *)topView{
    if (!_topView) {
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0,84, SCREEN_W, 120)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self topUI];
//        [self mostText];
    }
    return _topView;
}

- (void)topUI{
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 1)];
    line1.backgroundColor = BASEGRAYCOLOR;
    [self.topView addSubview:line1];
    
    LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(5, 1, SCREEN_W-10, 100)];
    self.textView = textView;
    textView.delegate = self;
    textView.font  = font(16);
    textView.placeholder = @"这一刻的想法... ";
    [self.topView addSubview:textView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 100, SCREEN_W-20, 1)];
    line.backgroundColor = BASEGRAYCOLOR;
    [self.topView addSubview:line];
}

//中间视图创建
- (UIView *)middleView{
    if (!_middleView) {
        _middleView=[[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frameHeight+84, SCREEN_W, 120)];
        _middleView.backgroundColor = [UIColor whiteColor];
        [self middleUI];
    }
    return _middleView;
}

- (void)middleUI{
    LGComposePhotosView *photoView=[[LGComposePhotosView alloc]init];
    [self.middleView addSubview:photoView];
    self.photoView = photoView;
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    WeakSelf;
    __typeof(photoView)weakPhotoView=photoView;
    photoView .clickblock=^(NSInteger tag){
        if (tag == 110) {
            [BDImagePicker showImagePickerFromViewController:self allowsEditing:NO finishAction:^(UIImage *image) {
                [weakPhotoView addPhoto:image];
            }];
        }else if (tag >120){
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.middleView.frameHeight = tag;
            }];
        }
    };
}

//-(void)mostText{
//    UIImageView *mostImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-100, 100, 90, 16)];
//    [mostImage setImage:[UIImage imageNamed:@"fx1"]];
//    mostImage.backgroundColor = [UIColor orangeColor];
//    [self.topView addSubview:mostImage];
//}

//下部分视图创建
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]init];
        [self.scrollView addSubview:self.bottomView];
        [self bottomUI];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.equalTo(_middleView.mas_bottom).offset(0);
            make.size.mas_offset(CGSizeMake(SCREEN_W-20, 90));
        }];
    }
    return _bottomView;
}

- (void)bottomUI{
    
    //所在位置
    UIImageView *areaImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,10, 20, 20)];
    areaImg.image= [UIImage imageNamed:@"p_location"];
    [self.bottomView addSubview:areaImg];
    
    UILabel *areaLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 100, 40)];
    areaLab.text = @"所在位置";
    areaLab.font = kFontNormal;
    [self.bottomView addSubview:areaLab];
    
    _cityLab = [[UILabel alloc]initWithFrame:CGRectMake(130, 0, 100, 40)];
    _cityLab.text = [self.locationCity isEqualToString:@"位置"]?@"":self.locationCity;
    _cityLab.font = kFontNormal;
    _cityLab.textColor = MyBlueColor;
    [self.bottomView addSubview:_cityLab];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-40,12, 17, 17)];
    arrowImg.image= [UIImage imageNamed:@"a_arrow"];
    [self.bottomView addSubview:arrowImg];
    
    UIButton *areaBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    [areaBtn addTarget:self action:@selector(city) forControlEvents:UIControlEventTouchDown];
    areaBtn.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:areaBtn];
    
    //分割线
    UIView *line  = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_W-20, 1)];
    line.backgroundColor = BASEGRAYCOLOR;
    [self.bottomView addSubview:line];
    
    //谁可以看
    UIImageView *limitImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,51, 20, 20)];
    limitImg.image= [UIImage imageNamed:@"p_see"];
    [self.bottomView addSubview:limitImg];
    
    UILabel *limitLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 41, 100, 40)];
    limitLab.font = kFontNormal;
    limitLab.text = @"谁可以看";
    [self.bottomView addSubview:limitLab];
    
    
    _limitLab = [[UILabel alloc]initWithFrame:CGRectMake(130, 41, 100, 40)];
    _limitLab.text = @"所有人可见";
    _limitLab.font = kFontNormal;
    _limitLab.textColor = MyBlueColor;
    [self.bottomView addSubview:_limitLab];
    
    UIImageView *arrowImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-40,53, 17, 17)];
    arrowImg2.image= [UIImage imageNamed:@"a_arrow"];
    [self.bottomView addSubview:arrowImg2];
    
    UIButton *limitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 41, SCREEN_W, 40)];
     [limitBtn addTarget:self action:@selector(limit) forControlEvents:UIControlEventTouchDown];
    limitBtn.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:limitBtn];
    
    //分割线
    UIView *line2  = [[UIView alloc]initWithFrame:CGRectMake(0, 81, SCREEN_W-20, 1)];
    line2.backgroundColor = BASEGRAYCOLOR;
    [self.bottomView addSubview:line2];
    
}

//navigation
- (void)setNav{
    self.titleLabel.text = @"发布动态";
    //发送
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain
                                                                       target:self action:@selector(onRightButton)];
    rightButtonItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

#pragma mark - textViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([self countWord:textView.text]>500) {
        Toast(@"您已超出了最大输入字符限制");
        return NO;
    }
    return YES;
}

-(int)countWord:(NSString *)s
{
    int i,n=[s length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

//提交
- (void)onRightButton{
//    [self upDateHeadIcon:self.photoView.photos];
    NSMutableDictionary *paramenters= [[NSMutableDictionary alloc]init];
    
    NSMutableDictionary *contentDict= [[NSMutableDictionary alloc]init];
    [contentDict setObject:_textView.text forKey:@"content"];
    [contentDict setObject:@"天津" forKey:@"at"];
    [contentDict setObject:@[@"https://gtd.alicdn.com/bao/uploaded/i2/666512320/TB2QjcYlCJjpuFjy0FdXXXmoFXa_!!666512320.jpg_480x480.jpg",@"https://gtd.alicdn.com/bao/uploaded/i3/666512320/TB2ynD5lrtlpuFjSspfXXXLUpXa_!!666512320.jpg_480x480.jpg",@"https://gtd.alicdn.com/bao/uploaded/i4/2075517883/TB2FLxOp3FkpuFjSspnXXb4qFXa_!!2075517883.jpg_480x480.jpg",@"https://gtd.alicdn.com/bao/uploaded/i4/2573864858/TB2mM92dUlnpuFjSZFjXXXTaVXa_!!2573864858.jpg_480x480.jpg",@"https://gtd.alicdn.com/bao/uploaded/i4/2573864858/TB2pynykDcCL1FjSZFPXXXZgpXa_!!2573864858.jpg_480x480.jpg"] forKey:@"imgs"];
    [contentDict setObject:@"什么参数？" forKey:@"subject"];
    
    [paramenters setObject:contentDict forKey:@"content"];
    
    [paramenters setObject:@{@"lat":@"12.1111",@"lon":@"12.22"} forKey:@"location"];
    
    [paramenters setObject:_cityLab.text forKey:@"locationValue"];
    
    [paramenters setObject:self.limitStr forKey:@"receiver"];
    
    [paramenters setObject:@"CATEGORY" forKey:@"receiverType"];
    
    [paramenters setObject:[StorageUtil getCode] forKey:@"promulgator"];
    NSLog(@"%@",paramenters);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedAdd parameters:paramenters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        //发送通知 ，刷新界面
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationPublishFinish object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark 提交
//- (void)upDateHeadIcon:(NSArray *)photos{
//    
//    if (isEmptyString(self.textView.text)) {
//        Toast(@"至少写一个字吧，这让我很为难");
//        return;
//    }
//    //菊花显示
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
//    
//    NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
//    
//    [dictT setObject:self.orderId forKey:@"orderId"];
//    [dictT setObject:self.orderChildId forKey:@"orderChildId"];
//    if (!isEmptyString([StorageUtil getUserName])) {//name为空
//        [dictT setObject:[StorageUtil getUserName] forKey:@"userName"];
//    }else{
//        [dictT setObject:@"/" forKey:@"userName"];
//    }
//    [dictT setObject:@(self.starGrades) forKey:@"score"];
//    [dictT setObject:self.goodsId forKey:@"goodsId"];
//    
//    NSString *inputText = [self.textView.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    
//    [dictT setObject:inputText  forKey:@"content"];
//    [dictT setObject:[StorageUtil getRoleId] forKey:@"userId"];
//    [dictT setObject:self.goodsBuyType forKey:@"evalType"];
//    NSLog(@"%@",dictT);
//    [manager POST:kUrlEvaluateAdd parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (int i = 0; i < photos.count; i++) {
//            UIImage *photo = photos[i];
//            NSData * imageData = UIImageJPEGRepresentation(photo,0.5);
//            NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"text"];
//            [imageData writeToFile:fullPath atomically:NO];
//            
//            NSString *fileName = [NSString  stringWithFormat:@"img%d",i+1];
//            /*
//             *该方法的参数
//             1. appendPartWithFileData：要上传的照片[二进制流]
//             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//             3. fileName：要保存在服务器上的文件名
//             4. mimeType：上传的文件的类型
//             */
//            
//            [formData appendPartWithFileData:imageData name:fileName fileName:@"text.jpg" mimeType:@"image/jpg"];
//        }
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        //将二进制转为字符串
//        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//        //字符串转字典
//        NSDictionary*dict=[self dictionaryWithJsonString:result2];
//        NSLog(@"%@",dict);
//        if ([dict[@"resultCode"] integerValue]==200) {
//            ToastSuccess(@"上传成功");
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        ToastError(@"上传失败");
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
//}

#pragma  mark  将字符串转成字典
-(id )dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        
        return nil;
    }
    
    return dic;
}

//定位
-(void)city{
    
    if (![CLLocationManager locationServicesEnabled]) {
        
        Toast(@"定位服务尚未打开，请在设置中打开！");
        return;
    }
    
    SPPublishLocationVC *vc = [[SPPublishLocationVC alloc]init];
    vc.publishLocationBlock = ^(NSString *result){
        self.cityLab.text = result;
        self.locationCity = result;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//谁可以看
-(void)limit{
    SPPublishLimitVC *vc = [[SPPublishLimitVC alloc]init];
    vc.publishLimitBLock = ^(NSString *limitStr,NSString *limitText){
        self.limitStr = limitStr;
        NSLog(@"%@",limitText);
        self.limitLab.text = limitText;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
@end
