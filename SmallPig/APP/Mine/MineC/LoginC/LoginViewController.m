//
//  LoginViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (nonatomic,strong)UIButton * nextBtn;
@property (nonatomic,strong)UIButton * goHomeBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image=[UIImage imageNamed:@"dlok2"];
    [self.view insertSubview:imageView atIndex:0];
    [self createUI];
    // Do any additional setup after loading the view.
}

#pragma mark - createUI
- (void)createUI{

    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn setImage:[UIImage imageNamed:@"dlok_r1_c1"] forState:UIControlStateNormal];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn addTarget:self action:@selector(nextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(SCREEN_H/3*2);
        make.left.offset(SCREEN_W/2-100);
        make.width.offset(80);
        make.height.offset(80);
    }];
    
    self.goHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.goHomeBtn setImage:[UIImage imageNamed:@"dlok_r1_c3"] forState:UIControlStateNormal];
    [self.view addSubview:self.goHomeBtn];
    [self.goHomeBtn addTarget:self action:@selector(goHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.goHomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(SCREEN_H/3*2);
        make.left.offset(SCREEN_W/2+30);
        
        make.width.offset(80);
        make.height.offset(80);
    }];
}

#pragma mark - nextBtn完善信息
- (void)nextBtn:(UIButton *)btn{

    
}

#pragma mark - goHomeBtn返回首页
- (void)goHomeBtn:(UIButton *)btn{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
