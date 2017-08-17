//
//  LGComposePhotosView.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/5/15.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "LGComposePhotosView.h"
#import "SPCanDeleteImgView.h"
@implementation LGComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
        [self addBtn];
    }
    return self;
}

-(void)addBtn{
    UIButton*btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"p_add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    self.btn=btn;
    [self addSubview:btn];
}

-(void)click{
    
    if (self.photos.count>=9) {
        Toast(@"最多可上传9张哦");
        return;
    }
    self.clickblock(110);
}

- (void)addPhoto:(UIImage *)photo
{
    if (self.photos.count==3) {
        //回传 ，更改父控件 frame;
        self.clickblock(200);
    }
    
    if (self.photos.count==7) {
        //回传 ，更改父控件 frame;
        self.clickblock(280);
    }
    
    SPCanDeleteImgView *photoView = [[SPCanDeleteImgView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
    
    // 存储图片
//     [_photos addObject:photo];
    [self.photos addObject:photo];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//     设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
   
    int maxCol = 4;
    CGFloat imageWH = (SCREEN_W-50)/4;
    CGFloat imageMargin = 10;
    CGRect lastphonoframe=CGRectZero;
    if (count==1) {
        lastphonoframe=CGRectMake(imageMargin, 10, 70, 70);
    }else{
    for (int i = 1; i<count; i++) {
        
       UIView *photoView = self.subviews[i];
        if ([photoView isKindOfClass:[UIImageView class]]) {
            int col = (i-1) % maxCol;
            photoView.originX = col * (imageWH + imageMargin)+imageMargin;
            
            int row = (i-1) / maxCol;
            photoView.originY = row * (imageWH + imageMargin)+10;
            photoView.frameWidth = imageWH;
            photoView.frameHeight= imageWH;
       
            lastphonoframe=CGRectMake( i % maxCol * (imageWH + imageMargin)+imageMargin, i / maxCol * (imageWH + imageMargin)+10, imageWH, imageWH);
        }else{
        }
    }
    }
     self.btn.frame=lastphonoframe;
//=
}

@end
