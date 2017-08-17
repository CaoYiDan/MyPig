//
//  SPHomeDataManager.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPHomeDataManager : NSObject
/**
 * 获取动态数据
 */
+ (void)getMoreHomeDateWithPage:(NSInteger)page scoree:(NSString *)score success:(void(^)(NSArray *items, BOOL lastPage, NSString *score))success failure:(void(^)(NSError *NSError))failure;
+ (void)refreshHomeDatesuccess:(void(^)(NSArray *items, BOOL lastPage,NSString *score))success failure:(void(^)(NSError *NSError))failure;
/**
 * 获取轮播图数据
 */
+ (void)getBannerSuccess:(void(^)(NSArray *responseObject,NSArray *bannerImageArr))success failure:(void(^)(NSError *NSError))failure;
/**
 * 获取首页分类模块图片
 */
+ (void)getHomeCatrgorySuccess:(void(^)(NSArray *ImageArr))success failure:(void(^)(NSError *NSError))failure;


@end
