//
//  CardView.h
//  仿陌陌点点切换
//
//  Created by zjwang on 16/3/28.
//  Copyright © 2016年 Xsummerybc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPNearModel;
@interface CardView : UIView
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *labelTitle;
/**<#title#>*/
@property(nonatomic,assign)NSInteger type;

/**模型*/
@property (nonatomic, strong)SPNearModel *model;
@end
