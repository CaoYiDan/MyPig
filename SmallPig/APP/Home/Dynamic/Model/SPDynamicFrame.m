//
//  SPHomeFrame.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicFrame.h"
#import "SPDynamicModel.h"
#import "NSString+getSize.h"

@implementation SPDynamicFrame

-(void)setStatus:(SPDynamicModel *)status{
    _status = status;
    
    [self sTopF];
    [self sBottomF];
}

-(void)sTopF{
    /** 配图 */
    CGFloat contentX = kMargin;
    CGFloat originalH = 0;
    if (self.status.imgs.count) { // 有配图
        CGFloat photosX = 0;
        CGFloat photosY =  0;
        NSLog(@"%lu",(unsigned long)self.status.imgs.count);
        self.photosViewF = (CGRect){{photosX, photosY}, CGSizeMake(SCREEN_W-2*kMargin,[self heigtForPhoto:self.status.imgs.count])};
        originalH = CGRectGetMaxY(self.photosViewF) ;
        
    } else { // 没配图
        originalH = CGRectGetMaxY(self.contentLabelF) + 10;
    }
    
    /** 正文 */
    CGFloat maxW = SCREEN_W- 4*contentX;
    
//    /** topView*/
//    self.topViewF= CGRectMake(contentX, 0, SCREEN_W-2*contentX, originalH+contentSize.height+10);
    
    if (isEmptyString(self.status.text)) {
     
        self.contentLabelF = CGRectMake(contentX, CGRectGetMaxY(self.photosViewF),0, 0);
        
        /** topView*/
        self.topViewF= CGRectMake(contentX, 0, SCREEN_W-2*contentX, originalH);
        
    }else{
        
        CGSize contentSize = [self.status.text sizeWithFont:kFontNormal_14 maxW:maxW];
        self.contentLabelF = CGRectMake(contentX, CGRectGetMaxY(self.photosViewF), maxW, contentSize.height+10);
        
        /** topView*/
        self.topViewF= CGRectMake(contentX, 0, SCREEN_W-2*contentX, originalH+contentSize.height+10);

    }
}

-(void)sBottomF{
    
    CGFloat Y = CGRectGetMaxY(self.topViewF)+10;
    
    //头像
    CGFloat iconW = 50;
    self.iconViewF = CGRectMake(kMargin,Y,iconW , iconW);
    
    //昵称
    
    self.nameLabelF = CGRectMake(iconW+kMargin +kMargin,  Y, 100, 20);
    
    //发布时间和地点
    self.timeAndAreaLabelF = CGRectMake(self.nameLabelF.origin.x, CGRectGetMaxY(self.nameLabelF), SCREEN_W/2-(iconW+kMargin +kMargin), 30);
    
    //工具栏
    self.toolbarF = CGRectMake(SCREEN_W/2,Y , SCREEN_W/2-10, iconW);
    
    //cell高度
    self.cellHeight = CGRectGetMaxY(self.toolbarF)+25;
}

//根据图片的个数 返回不同的高度
-(CGFloat)heigtForPhoto:(NSInteger)count{
    if (count == 1) {
        
        //获取加载的图片的大小，然后按比例返回高度
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.status.imgs[0]]];
        UIImage *image = [UIImage imageWithData:data];
    
        return image.size.height/image.size.width*SCREEN_W;
    }else if (count ==2){
        return (SCREEN_W-20)/2;
    }else if (count == 3){
        return (SCREEN_W-20)/2;
    }else if (count == 4){
        return (SCREEN_W-20)/3*2;
    }else if (count == 5){
        return (SCREEN_W-20)/2+(SCREEN_W-20)/3;
    }else if (count == 6){
        return (SCREEN_W-20)/2+(SCREEN_W-20)/3;
    }else if (count == 7){
        return (SCREEN_W-20)/2+(SCREEN_W-20)/3*2;
    }else if (count == 8){
        return (SCREEN_W-20);;
    }else if (count == 9){
        return (SCREEN_W-20);
    }
    return 0;
}
@end
