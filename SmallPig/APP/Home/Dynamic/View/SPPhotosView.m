//
//  SPPhotosView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPhotosView.h"
#import "SDPhotoBrowser.h"
@interface SPPhotosView() <SDPhotoBrowserDelegate>
@end
@implementation SPPhotosView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self sUI];
    }
    return self;
}

-(void)sUI{
 
}

-(void)setImgArr:(NSArray *)imgArr{
    _imgArr = imgArr;
    for (int i =0; i<imgArr.count; i++) {
        UIImageView *img = [[UIImageView alloc]init];
        
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        [img sd_setImageWithURL:[NSURL URLWithString:imgArr[i]]];
        img.tag = i;
        [self addSubview:img];
        img.userInteractionEnabled = YES;
//        //创建手势对象
//        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tap:)];
//        //配置属性
//        //轻拍次数
//        tap.numberOfTapsRequired =1;
//        //轻拍手指个数
//        tap.numberOfTouchesRequired =1;
//        //讲手势添加到指定的视图上
//        [img addGestureRecognizer:tap];
    }
    
}

-(void)tap:(UITapGestureRecognizer*)gesture{
    UIImageView *img = (UIImageView *)gesture.view;
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = img.tag;
    photoBrowser.imageCount = _imgArr.count;
    photoBrowser.sourceImagesContainerView = img.superview;
    [photoBrowser show];
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlString = self.imgArr[index];
    return [NSURL URLWithString:urlString];
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    int i =0;
    CGFloat wid = self.frameWidth;
    
    for (UIImageView *img in self.subviews) {
        if (self.imgArr.count == 1) {
            
            img.frame = CGRectMake(0, 0, self.frameWidth, self.frameHeight);
            
        }else if (self.imgArr.count == 2){
            img.frame = CGRectMake(i*((self.frameWidth/2-1)+1), 0, self.frameWidth/2-1, self.frameWidth/2-1);
            
        }else if (self.imgArr.count == 3){
            
            if (i ==0) {
                img.frame = CGRectMake(0, 0, self.frameWidth/4*3-1, self.frameWidth/2-1);
            }else{
            img.frame = CGRectMake(self.frameWidth/4*3,(i-1)*self.frameWidth/4, self.frameWidth/4, self.frameWidth/4-1);
            }
            
        }else if (self.imgArr.count == 4){
            if (i <2) {
                img.frame = CGRectMake(i*self.frameWidth/2, 0, self.frameWidth/2-1, self.frameWidth/3-1);
            }else if (i==2){
            img.frame = CGRectMake(0 , wid/3, self.frameWidth/2-1, self.frameWidth/3);
            }else if (i ==3){
            img.frame = CGRectMake(self.frameWidth/2, wid/3, self.frameWidth/2, self.frameWidth/3);
            }
            
        }else if (self.imgArr.count == 5){
            if (i ==0) {
                img.frame = CGRectMake(0, 0, self.frameWidth/4*3-1, self.frameWidth/2-1);
            }else if(i<3){
                img.frame = CGRectMake(self.frameWidth/4*3,(i-1)*self.frameWidth/4, self.frameWidth/4, self.frameWidth/4-1);
            }else if (i<5){
             img.frame = CGRectMake((i-3)*self.frameWidth/2, wid/2, self.frameWidth/2-1, self.frameWidth/3);
            }
            
        }else if (self.imgArr.count == 6){
            
            if (i ==0) {
                img.frame = CGRectMake(0, 0, self.frameWidth/4*3-1, self.frameWidth/2-1);
            }else if(i<3){
                img.frame = CGRectMake(self.frameWidth/4*3,(i-1)*self.frameWidth/4, self.frameWidth/4, self.frameWidth/4-1);
            }else if (i<6){
                img.frame = CGRectMake((i-3)*self.frameWidth/3, wid/2, self.frameWidth/3-1, self.frameWidth/3);
            }
            
        }else if (self.imgArr.count == 7){
           
            if (i ==0) {
                img.frame = CGRectMake(0, 0, self.frameWidth/4*3-1, self.frameWidth/2-1);
            }else if(i<3){
                img.frame = CGRectMake(self.frameWidth/4*3,(i-1)*self.frameWidth/4, self.frameWidth/4, self.frameWidth/4-1);
            }else if (i<5){
               img.frame = CGRectMake((i-3)*self.frameWidth/2, wid/2, self.frameWidth/2-1, self.frameWidth/3-1);
            }else if (i<7){
                img.frame = CGRectMake((i-5)*self.frameWidth/2, wid/2+wid/3, self.frameWidth/2-1, self.frameWidth/3);
            }

            
        }else if (self.imgArr.count == 8){
            
            if (i <2) {
                img.frame = CGRectMake(i*self.frameWidth/2, 0, self.frameWidth/2-1, self.frameWidth/3-1);

            }else if (i<5){
                img.frame = CGRectMake((i-2)*wid/3 , wid/3, self.frameWidth/3-1, self.frameWidth/3-1);
            }else if (i <8){
                img.frame = CGRectMake((i-5)*wid/3, wid/3*2, self.frameWidth/3-1, self.frameWidth/3);
            }

        }else if (self.imgArr.count == 9){
            if (i <3) {
                img.frame = CGRectMake(i*wid/3, 0, self.frameWidth/3-1, self.frameWidth/3-1);
            }else if (i<6){
                img.frame = CGRectMake((i-3)*wid/3 , wid/3, self.frameWidth/3-1, self.frameWidth/3-1);
            }else if (i <9){
                img.frame = CGRectMake((i-6)*wid/3, wid/3*2, self.frameWidth/3-1, self.frameWidth/3);
            }
        }
      i ++;
    }
}

@end
