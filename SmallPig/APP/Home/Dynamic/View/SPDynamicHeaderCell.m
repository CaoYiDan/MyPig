//
//  SPHomeHeaderCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicHeaderCell.h"

@implementation SPDynamicHeaderCell
{
    UIImageView*_activityImgView;
    UILabel*_name;
    UILabel*_subName;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setUp{
    
    _activityImgView =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.frameWidth, self.frameWidth/2)];
    _activityImgView.backgroundColor = [UIColor whiteColor];
    _activityImgView.contentMode = UIViewContentModeScaleAspectFill;
    _activityImgView.clipsToBounds = YES;
    [self.contentView addSubview:_activityImgView];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frameWidth/2+15, self.frameWidth, 20)];
    _name.font = kFontNormal;
    _name.backgroundColor = HomeBaseColor;
    [self.contentView addSubview:_name];
    
    _subName = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frameWidth/2+35, self.frameWidth, 20)];
    _subName.font = font(12);
    _subName.textColor = [UIColor lightGrayColor];
    _subName.backgroundColor = HomeBaseColor;
    [self.contentView addSubview:_subName];
}

-(void)setActivityDict:(NSDictionary *)activityDict{
    _activityDict = activityDict;
//    [_activityImgView sd_setImageWithURL:[NSURL URLWithString:activityDict[@"imgUrl"]]];
    [_activityImgView sd_setImageWithURL:[NSURL URLWithString:@"https://gtd.alicdn.com/bao/uploaded/i2/666512320/TB2QjcYlCJjpuFjy0FdXXXmoFXa_!!666512320.jpg_480x480.jpg"]];
    
    _name.text = activityDict[@"title"];
    
    _subName.text = activityDict[@"subTitle"];
}

@end
