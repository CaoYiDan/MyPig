//
//  SPHomeHeaderCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPActivityCell.h"

@implementation SPActivityCell
{
    UIImageView*_activityImgView;
    UILabel*_name;
    UIImageView*_arrowImg;
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
    
    //图片
    _activityImgView =  [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.frameWidth-20, self.frameWidth/2)];
    _activityImgView.clipsToBounds = YES;
    _activityImgView.contentMode  = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_activityImgView];
    
    //遮挡住name因为圆角，使得上面的角也变圆角
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(10, self.frameWidth/2+10,self.frameWidth-20, 5)];
    vi.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:vi];
    
    //标题
    _name = [[UILabel alloc]initWithFrame:CGRectMake(10, self.frameWidth/2+10, self.frameWidth-20, 30)];
    _name.font = kFontNormal_14;
    _name.clipsToBounds = YES;
    _name.layer.cornerRadius = 5;
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    
    //箭头
    _arrowImg =  [[UIImageView alloc]initWithFrame:CGRectMake(self.frameWidth-30, self.frameWidth/2+16, 17, 17)];
    [_arrowImg setImage:[UIImage imageNamed:@"a_arrow"]];
    [self.contentView addSubview:_arrowImg];
}

-(void)setActivityDict:(NSDictionary *)activityDict{
    _activityDict = activityDict;
    
    [_activityImgView sd_setImageWithURL:[NSURL URLWithString:activityDict[@"imgUrl"]]];
    
    _name.text = [NSString stringWithFormat:@"    %@",activityDict[@"title"]];
}
@end
