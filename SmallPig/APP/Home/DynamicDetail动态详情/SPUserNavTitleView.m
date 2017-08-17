//
//  SPUserNavTitleView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPDynamicModel.h"
#import "SPDetailIntroductionWebVC.h"
#import "SPUserNavTitleView.h"
#import "SPCommon.h"
@interface SPUserNavTitleView ()
/** 头像 */
@property (nonatomic, weak) UIImageView *iconImg;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 和发布地点*/
@property (nonatomic, weak) UILabel *timeAndAreaLabel;

@end

@implementation SPUserNavTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    /** 头像 */
    CGFloat iconW = 40;
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, iconW, iconW)];
    iconView.backgroundColor = HomeBaseColor;
    iconView.layer.cornerRadius  = iconW/2;
    iconView.clipsToBounds = YES;
    [self addSubview:iconView];
    self.iconImg = iconView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconW+15, 2,self.frameWidth-iconW-15, 20)];

    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.font = kFontNormal_14;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间  和 发布地点*/
    UILabel *timeAndAreaLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconW+15, 22, self.frameWidth-iconW-15, 20)];
    timeAndAreaLabel.font = Font(12);
    timeAndAreaLabel.textColor  = [UIColor lightGrayColor];
    timeAndAreaLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:timeAndAreaLabel];
    self.timeAndAreaLabel = timeAndAreaLabel;
}

-(void)setModel:(SPDynamicModel *)model{
    _model = model;
    
    //头像
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.promulgatorAvatar]];
    
    //姓名
    self.nameLabel .text = model.promulgatorName;
    
    //时间和发布地区
    self.timeAndAreaLabel .text = [NSString stringWithFormat:@"%@  %@",model.time,model.locationValue];
    
}

//赋值
-(void)setDict:(NSDictionary *)dict{
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:dict[@"commentorAvatar"]]];

    self.nameLabel.text = dict[@"commentorName"];
    
    self.timeAndAreaLabel .text = [NSString stringWithFormat:@"%@ %@",dict[@"time"],@""];
}

-(void)iconTap{
    
    SPDetailIntroductionWebVC *vc = [[SPDetailIntroductionWebVC alloc]init];
    vc.code = self.model.code;
    
    vc.titleName = self.model.promulgatorName;
    [[SPCommon getCurrentVC] presentViewController:vc animated:YES completion:nil];
}
@end
