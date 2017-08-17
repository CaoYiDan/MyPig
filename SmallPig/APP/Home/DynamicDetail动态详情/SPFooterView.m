//
//  SPFooterView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPFooterView.h"

@implementation SPFooterView
{
    UILabel *_content;
    UIScrollView *_iconScroView;
    UIButton *_prasiedNum;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
    }
    return self;
}

-(void)sUI{
    //内容
    _content = [[UILabel alloc]init];
    _content.numberOfLines = 0;
    _content.font = kFontNormal;
    [self addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.width.offset(SCREEN_W-20);
    }];
    
    //小红心
    UIImageView *loveImg = [[UIImageView alloc]init];
    [loveImg setImage:[UIImage imageNamed:@"d_love_red"]];
    [self addSubview:loveImg];
    [loveImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.size.mas_offset(CGSizeMake(30, 30));
        make.top.equalTo(_content.mas_bottom).offset(10);
    }];
    
    //赞的头像的父控件
    _iconScroView = [[UIScrollView alloc]init];
    [self addSubview:_iconScroView];
    [_iconScroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loveImg.mas_right).offset(10);
        make.top.equalTo(loveImg);
        make.size.mas_offset(CGSizeMake(SCREEN_W-120, 40));
    }];
    
    //被赞总数
    _prasiedNum = [[UIButton alloc]init];
    [_prasiedNum setImage:[UIImage imageNamed:@"d_love_white"] forState:0];
    _prasiedNum.backgroundColor = DarkRed;
    _prasiedNum.titleLabel.font = font(12);
    _prasiedNum.layer.cornerRadius = 10;
    _prasiedNum.clipsToBounds = YES;
    [self addSubview:_prasiedNum];
    [_prasiedNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.size.mas_offset(CGSizeMake(80, 20));
        make.centerY.equalTo(loveImg);
    }];
}

-(void)setArr:(NSArray *)prasizedArr content:(NSString *)content{
    
    //内容
    _content .text = content;
    
    int i = 0;
    CGFloat hMargin = 5;
    CGFloat iconW = 30;
    for (NSDictionary *dic in prasizedArr) {
        UIImageView *icon  = [[UIImageView alloc]initWithFrame:CGRectMake(i*(iconW +hMargin), 0, iconW, iconW)];
        icon.layer.cornerRadius = iconW/2;
        icon.clipsToBounds = YES;
        [icon sd_setImageWithURL:[NSURL URLWithString:dic[@"praiserAvatar"]]];
        [_iconScroView addSubview:icon];
        i++;
    }
    
    //设置scrollview 的可滑动范围
    _iconScroView.contentSize = CGSizeMake(i*(iconW+hMargin) , 0);
    
    [_prasiedNum setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)prasizedArr.count] forState:0];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    //清除 图片，以免错乱
    for (UIView *vi in _iconScroView.subviews) {
        if ([vi isKindOfClass:[UIImageView class]]) {
            [vi removeFromSuperview];
        }
    }
}
@end
