//
//  SPOfferButton.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/12.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPOfferButton.h"

@implementation SPOfferButton
{
    UILabel *_textLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(-20,13.5+33, 100, self.frameHeight-self.frameWidth)];
        _textLabel.numberOfLines = 2;
        _textLabel.font = font(12);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(13.5, 13.5, 33,33);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self setTitleColor:[UIColor clearColor] forState:0];
    _textLabel.text = title;
}

@end
