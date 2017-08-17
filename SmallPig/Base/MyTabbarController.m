//
//  MyTabbarController.m
//  TimeMemory
//
//  Created by 李智帅 on 16/9/5.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import "MyTabbarController.h"
#import "SPHomeViewController.h"
#import "SelectionViewController.h"
#import "PersonnelViewController.h"
#import "MineViewController.h"
#import "SPBaseNavigationController.h"

@interface MyTabbarController ()<UITabBarControllerDelegate>
{

    SPBaseNavigationController * _homeNav;
}
@end

@implementation MyTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self createViewControllers];
    [self createTabbar];
   
}

-(void)createViewControllers{

    SPHomeViewController * homeVC =[[SPHomeViewController alloc]init];
    SPBaseNavigationController * homeNav = [[SPBaseNavigationController alloc]initWithRootViewController:homeVC];
    
    _homeNav = homeNav;
    homeNav.navigationBar.translucent = NO;
    homeNav.navigationBar.barStyle = UIBarStyleDefault;
    
    PersonnelViewController * personnelVC = [[PersonnelViewController alloc]init];
    
    SPBaseNavigationController * personnelNav = [[SPBaseNavigationController alloc]initWithRootViewController:personnelVC];
    //categoryNav.navigationBar.translucent = NO;
    SelectionViewController * selectionVC = [[SelectionViewController alloc]init];
    
    SPBaseNavigationController * selectionNav = [[SPBaseNavigationController alloc]initWithRootViewController:selectionVC];
    
//    ShoppingCartViewController * cartVC = [[ShoppingCartViewController alloc]init];
//    UINavigationController * cartNav = [[UINavigationController alloc]initWithRootViewController:cartVC];
    
    MineViewController * mineVC = [[MineViewController alloc]init];
    SPBaseNavigationController * mineNav = [[SPBaseNavigationController alloc]initWithRootViewController:mineVC];
    self.delegate = self;
    self.viewControllers = @[homeNav,selectionNav,personnelNav,mineNav];
    self.tabBar.tintColor = [UIColor colorWithRed:247/255 green:247/255 blue:247/255 alpha:1];
    self.tabBar.translucent = NO;
    
}

- (void)createTabbar{
    
    NSArray * unselectedArray = @[@"nav_r1_c1",@"nav_r1_c6",@"nav_r1_c10",@"nav_r1_c17"];
    
    NSArray * selectedArray = @[@"nav_hover_r1_c1",@"nav_hover_r1_c6",@"nav_hover_r1_c10",@"nav_hover_r1_c17"];
    
    NSArray * titleArray = @[@"首页",@"精选",@"私信",@"我的"];
    
    for (int i = 0; i<self.tabBar.items.count; i++) {
        
        UIImage * unselectedImage = [UIImage imageNamed:unselectedArray[i]];
        
        unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * selectedImage = [UIImage imageNamed:selectedArray[i]];
        
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem * item = self.tabBar.items[i];
        
        item = [item initWithTitle:titleArray[i] image:unselectedImage selectedImage:selectedImage];
        //tabbar 具体设计63 144 244
        [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:63/255 green:144/255.0 blue:244/255.0 alpha:1]} forState:UIControlStateSelected];
        
        [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        
    }

}

#pragma mark - tabbarDelegate
//代理方法,这个方法是来判断当点击某个tabBarItem时是否要点击下去,
//其实你可以这样理解:就是是否要点击这个tabBarItem.
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
    
    
    
//    //判断用户是否登陆
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"sid"]);
//    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"sid"] isEqualToString:@"0"]) {
//        //这里拿到你想要的tabBarItem,这里的方法有很多,还有通过tag值,这里看你的需要了
//        if ([viewController.tabBarItem.title isEqualToString:@"购物车"]||[viewController.tabBarItem.title isEqualToString:@"我"]) {
//            LoginViewController *vc = [LoginViewController new];
//            [self presentViewController:vc animated:YES completion:nil];
//            //这里的NO是关键,如果是这个tabBarItem,就不要让他点击进去
//            return YES;
//        }
//    }else{
//    
//        if ([viewController.tabBarItem.title isEqualToString:@"首页"]) {
//            
//            self.selectedIndex= 0;
//            //self.selectedViewController= _homeNav;
//            return YES;
//        }
//        if ([viewController.tabBarItem.title isEqualToString:@"分类"]) {
//            
//            self.selectedIndex= 1;
//            //self.selectedViewController= _homeNav;
//            return YES;
//        }
//        //return NO;
//        //self.selectedIndex = 3;
//    }
    //当然其余的还是要点击进去的
    return YES;
}
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    if ([viewController.tabBarItem.title isEqualToString:@"首页"]) {
//        
//        CATransition* animation = [CATransition animation];
//        [animation setDuration:10.0f];
//        [animation setType:@"rippleEffect"];
//        [animation setSubtype:kCATransitionFromRight];
//        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//        [self.view.layer addAnimation:animation forKey:@"switchView"];
//    }
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//动画
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    //点击tabBarItem动画
//    [self tabBarButtonClick:[self getTabBarButton]];
//    
//}
//
//- (UIControl *)getTabBarButton{
//    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
//    
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
//            [tabBarButtons addObject:tabBarButton];
//        }
//    }
//    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
//    
//    return tabBarButton;
//}
//
//#pragma mark - 点击动画
//- (void)tabBarButtonClick:(UIControl *)tabBarButton
//{
//    for (UIView *imageView in tabBarButton.subviews) {
//        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
//            //需要实现的帧动画,这里根据自己需求改动
//            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//            animation.keyPath = @"transform.scale";
//            animation.values = @[@1.0,@1.1,@0.9,@1.0];
//            animation.duration = 0.3;
//            animation.calculationMode = kCAAnimationCubic;
//            //添加动画
//            [imageView.layer addAnimation:animation forKey:nil];
//        }
//    }
//}


@end
