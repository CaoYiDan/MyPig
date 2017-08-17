//
//  SPBaseNavigationController.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/23.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPBaseNavigationController.h"

@interface SPBaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation SPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf;
    weakSelf.delegate=weakSelf;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationBar setTranslucent:YES];
    self.navigationBar.barStyle=UIBarStyleBlackOpaque ;
    //设置背景颜色
    self.navigationBar.backgroundColor=[UIColor clearColor];
    //设置字体颜色
//    NSDictionary *dic = @{NSForegroundColorAttributeName: [UIColor blackColor]};
//    self.navigationController.navigationBar.titleTextAttributes =dic;

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate=weakSelf;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, 40, 40);
        button.titleLabel.font = [UIFont systemFontOfSize:1];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)back{
    [self popViewControllerAnimated:YES];
}

@end
