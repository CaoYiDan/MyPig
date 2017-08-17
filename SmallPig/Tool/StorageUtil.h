//
//  StorageUtil.h
//  LetsGo
//
//  Created by XJS_oxpc on 16/5/30.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface StorageUtil : NSObject

//保存用户地理信息
+(void)saveUserAddressDict:(NSDictionary*)dict;
+(NSDictionary*)getUserAddresssDict;

//用户纬度
+ (void)saveUserLat:(NSString *)userLat;
+ (NSString *)getUserLat;

//经度
+ (void)saveUserLon:(NSString *)userLon;
+ (NSString *)getUserLon;


//保存用户信息
+(void)saveUserDict:(NSDictionary*)dict;
+(NSDictionary*)getUserDict;

//Id
+ (void)saveId:(NSString *)roleId;
+ (NSString *)getId;

//code
+ (void)saveCode:(NSString *)code;
+ (NSString *)getCode;

//用户手机号
+ (void)saveUserMobile:(NSString *)userMobile;
+ (NSString *)getUserMobile;

//用户的Header姓名
+ (void)saveHeaderName:(NSString *)headerName;
+ (NSString *)getHeaderName;

//用户的user昵称
+ (void)saveNickName:(NSString *)nickName;
+ (NSString *)getNickName;

//正真的姓名
+ (void)saveRealName:(NSString *)realName;
+ (NSString *)getRealName;
//userType
+ (void)saveUserType:(NSString *)userType;
+ (NSString *)getUserType;
//第二种角色
+ (void)saveUserSubType:(NSString *)userSubType;
+ (NSString *)getUserSubType;
//用户认证状态
+ (void)saveUserStatus:(NSString *)userStatus;
+ (NSString *)getUserStatus;
//手机的deviceToken
+ (void)saveDeviceToken:(NSString *)deviceToken;
+ (NSString *)getDeviceToken;

@end
