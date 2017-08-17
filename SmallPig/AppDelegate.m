//
//  AppDelegate.m
//  SmallPig
//
//  Created by 李智帅 on 2017/5/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabbarController.h"
#import "GuideView.h"

@interface AppDelegate ()<removeGuideView>
@property(nonatomic,strong) MyTabbarController * myTabbar;
@property(nonatomic,strong) GuideView * guideView;
@property(nonatomic,strong) UIView * adverView;
@property(nonatomic,strong) UIButton * nextBtn;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    //self.window.backgroundColor = [UIColor whiteColor];
    
    self.myTabbar = [[MyTabbarController alloc]init];
    
    self.window.rootViewController = self.myTabbar;
    
//    //广告页
//    self.adverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    
//    [self.myTabbar.view addSubview:self.adverView];
////
//    [self addGuideView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    return YES;
}

-(void)addGuideView{
    
    [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"isRun"];
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"isRun"]boolValue]) {
        
        NSArray * guideArray = @[@"ypage.jpg",@"ypage.jpg",@"ypage.jpg"];
        
        self.guideView = [[GuideView alloc]initWithFrame:self.window.bounds imageArray:guideArray];
        self.guideView.delegate = self;
        [self.adverView addSubview:self.guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isRun"];
        
    }else {
    
        [self createAdvertisement];
    }
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self.guideView action:@selector(inputButton)];
//    self.guideView.userInteractionEnabled = YES;
//    [self.guideView addGestureRecognizer:tap];
    //[self.guideView.inputButton addTarget:self action:@selector(inputButton) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - guideViewDelegate
- (void)removeGuideView:(BOOL)remove{

    if (remove) {
        
        [self inputButton];
    }
}

- (void)inputButton{
    
    //    [self.window.rootViewController presentViewController:self.myTabbar animated:YES completion:nil];
    [self.guideView removeFromSuperview];
    [self createAdvertisement];
    //[MBProgressHUD hideHUDForView:self.myTabbar.view animated:YES];
}

#pragma mark - createAdvertisement广告
- (void)createAdvertisement{
    
    
    //
    UIView * view = [[UIView alloc]initWithFrame:SCREEN_B];
    view.backgroundColor = WC;
    [self.adverView addSubview:view];
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,SCREEN_W,(SCREEN_H+64)/4*3)];
    
    webView.scalesPageToFit = YES;
    webView.backgroundColor = WC;
    
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [webView loadRequest:request];
    
    [view addSubview:webView];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,(SCREEN_H+64)/4*3,SCREEN_W,(SCREEN_H+64)/4)];
    imageView.image=[UIImage imageNamed:@"pic3"];
    [view addSubview:imageView];
    self.nextBtn.layer.cornerRadius = 8;
    self.nextBtn.clipsToBounds = YES;
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [webView addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(webView.mas_top).offset(30);
        make.left.offset(SCREEN_W-120);
        make.width.offset(100);
        make.height.offset(30);
        
    }];
    [self.nextBtn addTarget:self action:@selector(deleteAdvertisement) forControlEvents:UIControlEventTouchUpInside];
    //[self.nextBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [self.nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self openCountdown];
    
    
}

#pragma mark -  开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 1; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
//                [self.nextBtn setTitle:@"重新发送" forState:UIControlStateNormal];
//                
//                self.nextBtn.userInteractionEnabled = YES;
                [self deleteAdvertisement];
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.nextBtn setTitle:[NSString stringWithFormat:@"跳过(%.2ds)", seconds] forState:UIControlStateNormal];
                //[self.getMaBtn setTitleColor:[UIColor colorFromHexCode:@"979797"] forState:UIControlStateNormal];
                //self.getMaBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


- (void)deleteAdvertisement{

    [self.adverView removeFromSuperview];
    
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
