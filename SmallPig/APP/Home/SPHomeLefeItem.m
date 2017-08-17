//
//  SPHomeLefeItem.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/29.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPHomeLefeItem.h"
#import "SPMyButtton.h"

@implementation SPHomeLefeItem

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frameWidth, self.frameHeight-20);
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleLabel.frame = CGRectMake(0, self.frameHeight-20, self.frameWidth, 20);
    self.titleLabel.font = kFontNormal;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
