//
//  ViewController.m
//  仿陌陌点点切换
//
//  Created by zjwang on 16/3/28.
//  Copyright © 2016年 Xsummerybc. All rights reserved.
//

#import "SPNearVC.h"
#import "SPNearSifingVC.h"
#import "SPNearModel.h"
#import "CardView.h"
#import "ZLSwipeableView.h"
#import "SPDetailIntroductionWebVC.h"

 static CGFloat maxImgWid = 80;

@interface SPNearVC ()<ZLSwipeableViewDelegate, ZLSwipeableViewDataSource>

@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic) NSUInteger colorIndex;
@property (nonatomic) NSUInteger curentIndex;//当前展示的index
@property (nonatomic, strong) NSArray *titles;
@property(nonatomic,strong)UIImageView *likeImg;
@property(nonatomic,strong)NSMutableDictionary *siftingDict;
@end

@implementation SPNearVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseConfig];
    
    [self getHistorySifting];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)baseConfig{
    self.view.backgroundColor = BASEGRAYCOLOR;
    self.colorIndex = 0;
    self.curentIndex = 0;
    self.siftingDict = [[NSMutableDictionary alloc]init];
    //注册筛选的按钮的点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(siftingNotification:) name:NotificationSiftingForNear object:nil];
}

#pragma  mark - -----------------请求数据-----------------

#pragma  mark  获取最新的筛选信息

-(void)getHistorySifting{
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlHistorySifting parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        self.siftingDict = (NSMutableDictionary*)responseObject[@"data"];
        //根据筛选信息 请求附近的人
        [self loadNearPerson];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark   根据筛选信息 请求附近的人
-(void)loadNearPerson{

    NSMutableDictionary *dic = self.siftingDict.mutableCopy;
    [dic setObject:@"1" forKey:@"pageNum"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic removeObjectForKey:@"userCode"];
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlSearchUser parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        self.listArr = [SPNearModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self configSwipeableView];
        
        [self reloadSwipeableView];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)configSwipeableView{
    
    [self.view addSubview:self.swipeableView];
    
    // Required Data Source
    self.swipeableView.dataSource = self;
    
    // Optional Delegate
    self.swipeableView.delegate = self;
    
    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
}

-(void)reloadSwipeableView{
    self.curentIndex = 0;
    self.colorIndex = 0;
    self.swipeableView.allowedDirection = ZLSwipeableViewDirectionHorizontal;
    [self.swipeableView discardAllViews];
    [self.swipeableView loadViewsIfNeeded];
}





#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {

    if (direction == ZLSwipeableViewDirectionLeft) {
    //左滑动 不喜欢
        [self likeOrNotLike:2];
    }else if ( direction == ZLSwipeableViewDirectionRight){
    //右滑动 喜欢
        [self likeOrNotLike:1];
    }
    
    _curentIndex++;
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    //移动结束，回复最小尺寸
    _likeImg.mj_size= CGSizeMake(30, 30);
    //将图片置空
    [_likeImg setImage:[UIImage imageNamed:@""]];
    //移除
    [_likeImg removeFromSuperview];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
   
    //添加是否喜欢的图片
    [view addSubview:self.likeImg];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    if (translation.x>0) {//喜欢
         [_likeImg setImage:[UIImage imageNamed:@"n_like"]];
        _likeImg.originX = 10;
    }else{               //不喜欢
         [_likeImg setImage:[UIImage imageNamed:@"n_nolike"]];
        _likeImg.originX = SCREEN_W-60-maxImgWid-10;
    }
    //是否是达到最大的图片尺寸
    CGFloat wid =  30+fabs(translation.x)>maxImgWid?maxImgWid:30+fabs(translation.x);
    //动画变化图片尺寸
    [UIView animateWithDuration:0.1 animations:^{
        _likeImg.mj_size= CGSizeMake(wid, wid);
    }];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
    //移动结束，回复最小尺寸
    _likeImg.mj_size= CGSizeMake(30, 30);
    //将图片置空
    [_likeImg setImage:[UIImage imageNamed:@""]];
    //移除
    [_likeImg removeFromSuperview];
}
// up down left right
- (void)handle:(UIButton *)sender
{
    HandleDirectionType type = sender.tag;
    switch (type) {
        case HandleDirectionOn:
            [self.swipeableView swipeTopViewToUp];
            break;
        case HandleDirectionDown:
            [self.swipeableView swipeTopViewToDown];
            break;
        case HandleDirectionLeft:
            [self.swipeableView swipeTopViewToLeft];
            break;
            
        case HandleDirectionRight:
            [self.swipeableView swipeTopViewToRight];
            break;
        default:
            break;
    }
}

- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}


#pragma mark - ZLSwipeableViewDataSource 数据来源

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
    if (self.colorIndex >= self.listArr.count) {
        UILabel *noMore = [[UILabel alloc]initWithFrame:swipeableView.bounds];
        noMore.textAlignment = NSTextAlignmentCenter;
        noMore.backgroundColor = [UIColor whiteColor];
        noMore.text = @"没有更多了";
        noMore.userInteractionEnabled = YES;
        
        return noMore;
    }
//
    SPNearModel *user = self.listArr[self.colorIndex];
    
    CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
    view.backgroundColor = [UIColor whiteColor];
    view.model = user;
    view.tag = 110;
    NSLog(@"%lu",self.colorIndex);
    // ++
    self.colorIndex++;
    return view;
}

-(void)likeOrNotLike:(NSInteger) feel{
    
    if (self.curentIndex>=self.listArr.count-1 || self.listArr.count == 0) {
        self.swipeableView.allowedDirection = ZLSwipeableViewDirectionNone;
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(feel) forKey:@"type"];//1:喜欢，2：不喜欢
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    SPNearModel *curentCard = self.listArr[self.curentIndex];
    [dict setObject:curentCard.code forKey:@"targetUserCode"];//被划用户code
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlLikeOrNO parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark - -----------------action-----------------
//筛选通知
-(void)siftingNotification:(NSNotification *)notify{
    self.siftingDict = notify.object;
    [self loadNearPerson];
}

#pragma  mark  进入详情

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    if ([touch view].tag == 110) {
        
        SPDetailIntroductionWebVC*vc =[[SPDetailIntroductionWebVC alloc]init];
        SPNearModel *user = self.listArr[self.curentIndex];
        vc.titleName = user.nickName;
        vc.code = user.code;
        vc.haveLikeBtn = YES;
        WeakSelf;
        vc.likeOrNo = ^(NSInteger feel){
            if (feel == 2) {//不喜欢
                [weakSelf.swipeableView swipeTopViewToLeft];
            }else if (feel == 1){//喜欢
                [weakSelf.swipeableView swipeTopViewToRight];
            }
        };
//        [self.navigationController pushViewController:vc animated:YES];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

#pragma  mark - -----------------setter-----------------
//是否喜欢
-(UIImageView *)likeImg{
    if (!_likeImg) {
        _likeImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-60-50, 10, 30, 30)];
    }
    return _likeImg;
}

-(NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

- (ZLSwipeableView *)swipeableView
{
    if (_swipeableView == nil) {
        _swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectMake(30, 30, SCREEN_W-60, SCREEN_H -100)];
        _swipeableView.allowedDirection =ZLSwipeableViewDirectionHorizontal;
    }
    return _swipeableView;
}

@end
