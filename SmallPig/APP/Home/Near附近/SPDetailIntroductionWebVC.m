//
//  SPDetailIntroductionWebVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/10.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDetailIntroductionWebVC.h"

@interface SPDetailIntroductionWebVC ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView*webView;
@end

@implementation SPDetailIntroductionWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadWeb];
    
    [self addUI];
    
    //显示菊花加载，有一个缓冲加载的界面
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}



// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadWeb
{
    // 1. URL 定位资源,需要资源的地址
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://192.168.1.227:8080/web/info.html?code=",self.code]];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}

#pragma mark 网页加载结束 代理回调
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)addUI{
    
    [self addNavigation];
    
    if (_haveLikeBtn) {
        [self addNoLikeBtn];
        [self addLikeBtn];
    }
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H)];
        _webView.delegate=self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

-(void)addNavigation{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W, 44)];
    titleLabel.text = self.titleName;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment  = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 44, 44)];
    [back setImage:[UIImage imageNamed:@"back"] forState:0];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:back];
}

-(void)addNoLikeBtn{
    
    UIButton *noLikeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_H2-60, 40, 40)];
    noLikeBtn.tag = 2;
    [noLikeBtn setImage:[UIImage imageNamed:@"n_nolike"] forState:0];
    [noLikeBtn addTarget:self action:@selector(likeOrNotLike:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:noLikeBtn];
}

-(void)addLikeBtn{
    UIButton *likeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-50, SCREEN_H2-60, 40, 40)];
    likeBtn.tag  = 1;
    [likeBtn setImage:[UIImage imageNamed:@"n_like"] forState:0];
    [likeBtn addTarget:self action:@selector(likeOrNotLike:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:likeBtn];
}

-(void)likeOrNotLike:(UIButton *)btn{
    
    !self.likeOrNo?:self.likeOrNo(btn.tag);

    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
