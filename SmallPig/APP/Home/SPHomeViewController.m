//
//  SPHomeViewController.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPHomeViewController.h"

#import "SPDynamicVC.h"
#import "SPOfferVC.h"
#import "MLMSegmentHead.h"
#import "MLMSegmentScroll.h"
#import "SPHomeLefeItem.h"
#import "SPMyButtton.h"
#import "SPPublishVC.h"
#import "SPTipView.h"
#import "SPCityVC.h"
#import "SPNearSifingVC.h"
//定位服务
#import <CoreLocation/CoreLocation.h>
//test
#import "SPNearVC.h"

static CGFloat menuDownOriganY = 5;

typedef NS_ENUM(NSUInteger, RightItemType) {
    RightItemTypeForSifting = 11,
    RightItemTypeForPublish
};

@interface SPHomeViewController ()<CLLocationManagerDelegate>{
    
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    SPHomeLefeItem *_area;//定位按钮
    NSArray *list;
}

@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;
@property (nonatomic, strong) UIButton *publishCell;
@property (nonatomic, strong) SPTipView  *tipView;
@property (nonatomic, strong) UIButton *rightBtnItem;
@end

@implementation SPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sNavigation];
    
    [self configSegHead];
    
    [self configSegScrollView];
    
    [self setLocationMamager];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //有点不可控，不设置naivgation的样式 为这样，会有BUG,原因不明
    [self navigationSet];
    //如果下拉菜单展开，则收起
    [self hiddenMenuDownView];
}

-(void)setLocationMamager{
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //如果没有授权则请求用户授权
    [_locationManager requestWhenInUseAuthorization];//当应用使用期间请求运行定位
    
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse ||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyThreeKilometers;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=102.0;//...米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
        //初始化反地理编码
        _geocoder=[[CLGeocoder alloc]init];
    }

}

#pragma mark

- (void)sNavigation {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addLeftItem];
    
    [self addRights];
    
}

-(void)addLeftItem{
    SPHomeLefeItem *area = [[SPHomeLefeItem alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _area = area;
    [area setImage:[UIImage imageNamed:@"p_location"] forState:0];
    [area addTarget:self action:@selector(area) forControlEvents:UIControlEventTouchDown];
    [_area setTitle:@"位置" forState:0];
    [area setTitleColor:[UIColor blackColor] forState:0];
    UIBarButtonItem *areaBtn=[[UIBarButtonItem alloc]initWithCustomView:area];
    self.navigationItem.leftBarButtonItem = areaBtn
    ;
    
}

-(void)addRights{
    _rightBtnItem= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 38)];
    [_rightBtnItem addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchDown];
    [_rightBtnItem setImage:[UIImage imageNamed:@"h_more"] forState:0];
    [_rightBtnItem setTitleColor:[UIColor blackColor] forState:0];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:_rightBtnItem];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)configSegHead{
    list = @[@"附近",
             @"动态",
             @"项目快速报价"
             ];
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(-40, 0, SCREEN_WIDTH, 30) titles:list headStyle:SegmentHeadStyleSlide layoutStyle:MLMSegmentLayoutCenter];
    _segHead.fontSize = 14;
    _segHead.bottomLineHeight = 0;
    _segHead.selectColor = [UIColor whiteColor];
    _segHead.deSelectColor = [UIColor blackColor];
    _segHead.slideColor = RGBCOLOR(71, 190, 218);
    _segHead.equalSize = YES;
    _segHead.headColor = [UIColor whiteColor];
    _segHead.showIndex = 1;
    _segHead.layer.masksToBounds = YES;
    WeakSelf;
    _segHead.selectedIndex2 = ^(NSInteger index){
        [weakSelf selectedIndex:index];
    };
    [self.view addSubview:_segHead];

}

-(void)configSegScrollView{
    WeakSelf;
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) vcOrViews:[self vcArr:list.count]];
    _segScroll.loadAll = NO;
    _segScroll.scrollEnd2 = ^(NSInteger index){
        [weakSelf selectedIndex:index];
    };
    [self.view addSubview:_segScroll];
    
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        self.navigationItem.titleView = _segHead;
        [self.view addSubview:_segScroll];
    }];
}

-(void)selectedIndex:(NSInteger)index{
    
    //隐藏
    [self hiddenMenuDownView];
    
    if (index ==0) {
        [self setRightBtnType1];
        [self.view endEditing:YES];
        
    }else if(index==1){
        
        [self setRightBtnType2];
        [self.view endEditing:YES];
        
    }else if(index==2){
        [self setRightBtnType2];
    }

}

-(void)setRightBtnType1{
    [_rightBtnItem setTitle:@"筛选" forState:0];
    _rightBtnItem.tag = RightItemTypeForSifting;
    [_rightBtnItem setImage:[UIImage imageNamed:@""] forState:0];
}

-(void)setRightBtnType2{
    [_rightBtnItem setTitle:@"" forState:0];
    _rightBtnItem.tag = RightItemTypeForPublish;
    [_rightBtnItem setImage:[UIImage imageNamed:@"h_more"] forState:0];
}

#pragma mark - 数据源

- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i ++) {
        if (i==0) {//附近
            SPNearVC *vc = [[SPNearVC alloc]init];
            [arr addObject:vc];
        }else if(i==1){//动态
            SPDynamicVC*vc = [SPDynamicVC new];
            [arr addObject:vc];
        }else{//快速报价
            SPOfferVC *vc =[[SPOfferVC alloc]init];
            [arr addObject:vc];
        }
    }
    return arr;
}

#pragma mark - CoreLocation 代理

#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）

//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"%lu",locations.count);
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标

    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    //存储纬度
    [StorageUtil saveUserLat:[NSString stringWithFormat:@"%f",coordinate.latitude]];
    
    //存储经度
     [StorageUtil saveUserLon:[NSString stringWithFormat:@"%f",coordinate.longitude]];
    NSLog(@"%f",coordinate.longitude);
    
    //     [self getAddressByLatitude:39.54 longitude:116.28];
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
    
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"数量%lu",placemarks.count);
        
        CLPlacemark *placemark=[placemarks lastObject];

        //存储地理信息
        [StorageUtil saveUserAddressDict:placemark.addressDictionary];
        
        if (!isEmptyString(placemark.addressDictionary[@"City"])) {
            [_area setTitle:placemark.addressDictionary[@"City"] forState:0];
        }
    }];
}

//定位
-(void)area{
    
    SPCityVC *vc = [[SPCityVC alloc]init];
    vc.locationCity = _area.titleLabel.text;
    
    __weak typeof(_area)weakArea = _area;
    vc.cityBlock = ^(NSString *city){
        [weakArea setTitle:city forState:0];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

//弹出发布 按钮
-(void)rightItemClick:(UIButton*)btn{
    
    //筛选
    if (btn.tag == RightItemTypeForSifting) {
        [self pushTopSiftingVC];
        return;
    }
    
    //弹出或隐藏发布动态按钮
    [self popOrHiddenPublishBtn];
    
}

-(void)popOrHiddenPublishBtn{
    
    if(self.publishCell.originY == menuDownOriganY){
        //隐藏
        [UIView animateWithDuration:0.4 animations:^{
            self.publishCell.originY = -40;
        }];
    }else{
        //弹出
        [UIView animateWithDuration:0.4 animations:^{
            self.publishCell.originY = menuDownOriganY;
        }];
    }
}

//筛选
-(void)pushTopSiftingVC{
    SPNearSifingVC *vc = [[SPNearSifingVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//动态按钮
-(UIButton *)publishCell{
    
    if (!_publishCell) {
        
        _publishCell = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-75, -40, 70, 38)];
        [_publishCell setTitle:@"发布动态" forState:0];
        [_publishCell setTitleColor:[UIColor whiteColor] forState:0];
        
        [_publishCell addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchDown];
        _publishCell.titleLabel.font = kFontNormal_14;
        _publishCell.backgroundColor = [UIColor whiteColor];
        [_publishCell setTitleColor:[UIColor blackColor] forState:0];
//        _publishCell.layer.borderColor =[UIColor blackColor].CGColor;
//        _publishCell.layer.borderWidth = 0.8;
        [self.view addSubview:_publishCell];
    }
    return _publishCell;
}

//发布动态
-(void)publishClick{
    
    SPPublishVC *vc = [[SPPublishVC alloc]init];
    vc.locationCity = _area.titleLabel.text;
    vc.publishFinsih = ^(){
    
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//提示 完善信息框
-(SPTipView *)tipView{
    if (!_tipView) {
        _tipView = [[SPTipView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_tipView];
    }
    return _tipView;
}

-(void)navigationSet{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

-(void)hiddenMenuDownView{
    
    if(self.publishCell.originY == menuDownOriganY){
        //隐藏
        [UIView animateWithDuration:0.4 animations:^{
            self.publishCell.originY = -40;
        }];
    }
}
@end
