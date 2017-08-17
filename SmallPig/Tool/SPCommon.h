//
//  SPCommon.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPCommon : UIView
//转换颜色色值
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//最普遍的尺寸大小回弹动画
+(CAKeyframeAnimation *)getCAKeyframeAnimation;
//获取当前控制器
+(UIViewController *)getCurrentVC;
@end
