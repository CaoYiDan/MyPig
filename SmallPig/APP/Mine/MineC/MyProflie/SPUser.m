//
//  SPUser.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPUser.h"
#import "SPKungFuModel.h"

@implementation SPUser
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"tags" : [SPKungFuModel class],
             @"skills" : [SPKungFuModel class]
             };
}
@end
