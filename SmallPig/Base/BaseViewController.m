//
//  BaseViewController.m
//  TimeMemory
//
//  Created by 李智帅 on 16/9/5.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRootNav];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)createRootNav{
    
    //设置导航不透明
    self.navigationController.navigationBar.translucent = NO;

    self.navigationController.navigationBar.barTintColor = WC;
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //左按钮
    self.leftButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:nil backgroundImageName:nil target:nil selector:nil];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    //标题
    self.titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 0, 100, 30) text:nil textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:16]];
    self.navigationItem.titleView = self.titleLabel;
    
    self.rightButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 44, 44) title:nil titleColor:nil imageName:nil backgroundImageName:nil target:nil selector:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
}

- (void)addLeftTarget:(SEL)selector{
    
    [self.leftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRightTarget:(SEL)selector{
    
    [self.rightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSInteger count = self.navigationController.viewControllers.count;
    self.navigationController.interactivePopGestureRecognizer.enabled = count > 1;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
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
