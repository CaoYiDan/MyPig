//
//  SPDynamicSectionView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicSectionView.h"

@implementation SPDynamicSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
    }
    return self;
}
-(void)sUI{
    
    self.backgroundColor = HomeBaseColor;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_W-20, 1)];
    line.backgroundColor =[UIColor lightGrayColor];
    [self addSubview:line];
    
    UILabel *sectionView = [[UILabel alloc]initWithFrame:CGRectMake(35, 15, SCREEN_W, 40)];
    sectionView.text = @"精选动态";
    sectionView.font = BoldFont(16);
    [self addSubview:sectionView];
    
    UIImageView *pig = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 20, 20)];
    [pig setImage:[UIImage imageNamed:@"h_pig"]];
    [self addSubview:pig];
}
@end
