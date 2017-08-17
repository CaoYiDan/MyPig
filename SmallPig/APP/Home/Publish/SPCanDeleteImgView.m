//
//  SPCanDeleteImgView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPCanDeleteImgView.h"

@implementation SPCanDeleteImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)addUI{
    CGFloat imageWH = (SCREEN_W-50)/4;
    self.userInteractionEnabled = YES;
    UIButton *delete = [[UIButton alloc]initWithFrame:CGRectMake(imageWH-30 , 0, 30, 30)];
    [delete setImage:[UIImage imageNamed:@"l_appointment_time"] forState:0];
    [delete addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchDown];
    [self addSubview:delete];
}

-(void)deleteClick{
    [self removeFromSuperview];
    [self.superview layoutSubviews];
    [self.superview layoutIfNeeded];
}
@end
