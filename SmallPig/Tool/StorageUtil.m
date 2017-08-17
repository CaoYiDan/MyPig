//
//  StorageUtil.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/5/30.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "StorageUtil.h"

@implementation StorageUtil

//获取用户地理信息
+(void)saveUserAddressDict:(NSDictionary*)dict{
[self saveObject:dict forKey:kStorageUserAddressDict];
}
+(NSDictionary*)getUserAddresssDict{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *obj = [defaults objectForKey:kStorageUserAddressDict];
    return   obj;
}


//用户纬度
+ (void)saveUserLat:(NSString *)userLat{
[self saveObject:userLat forKey:kStorageLat];
}
+ (NSString *)getUserLat{
return [self getObjectByKey:kStorageLat];
}

//经度
+ (void)saveUserLon:(NSString *)userLon{
[self saveObject:userLon forKey:KStorageLon];
}
+ (NSString *)getUserLon{
return [self getObjectByKey:KStorageLon];
}


+(void)saveUserDict:(NSDictionary *)dict{
 [self saveObject:dict forKey:kStorageUserDict];
}
+(NSDictionary*)getUserDict{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *obj = [defaults objectForKey:kStorageUserDict];
    return   obj;
}

//用户ID
+ (void)saveId:(NSString *)roleId
{
    [self saveObject:roleId forKey:kStorageUserId];
}
+ (NSString *)getId
{
    return @"3";
//    return [self getObjectByKey:kStorageUserId];
}

//code
+ (void)saveCode:(NSString *)code{
    [self saveObject:code forKey:KStorageUserCode];
}
+ (NSString *)getCode{
//    return [self getObjectByKey:KStorageUserCode];
    return @"1549950269066756729";
//    return @"1552509554767642633";
}

//用户手机号码
+ (void)saveUserMobile:(NSString *)userMobile
{
    [self saveObject:userMobile forKey:kStorageUserMobile];
}
+ (NSString *)getUserMobile
{
    return [self getObjectByKey:kStorageUserMobile];
}

//userType
+ (void)saveUserType:(NSString *)userType
{
    [self saveObject:userType forKey:kStorageUserType];
}
+ (NSString *)getUser
{
    return [self getObjectByKey:kStorageUserType];
}
//userSubType
+ (void)saveUserSubType:(NSString *)userSubType
{
    [self saveObject:userSubType forKey:kStorageUserSubType];
}
+ (NSString *)getUserSubType
{
    return [self getObjectByKey:kStorageUserSubType];
}
//用户的header姓名
+ (void)saveHeaderName:(NSString *)headerName{
    [self saveObject:headerName forKey:kStorageHeaderName];
}
+ (NSString *)getHeaderName{
    return [self getObjectByKey:kStorageHeaderName];
}

//用户的user昵称
+ (void)saveNickName:(NSString *)nickName{
  [self saveObject:nickName forKey:kStorageUserName];
}
+ (NSString *)getNickName{
  return [self getObjectByKey:kStorageUserName];
}

//realName
+ (void)saveRealName:(NSString *)realName
{
    [self saveObject:realName forKey:kStorageUserRealName];
}
+ (NSString *)getRealName
{
    return [self getObjectByKey:kStorageUserRealName];
}

+ (void)saveUserStatus:(NSString *)userStatus
{
    [self saveObject:userStatus forKey:kStorageUserStatus];
}
+ (NSString *)getUserStatus
{
    return [self getObjectByKey:kStorageUserStatus];
}

//手机的deviceToken
+ (void)saveDeviceToken:(NSString *)deviceToken{
      [self saveObject:deviceToken forKey:kStorageDeviceToken];
}
+ (NSString *)getDeviceToken{
    return [self getObjectByKey:kStorageDeviceToken];
}


//公用的保存和获取本地数据的方法
+ (void)saveObject:(NSObject *)obj forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];//把数据持久化到standardUserDefaults数据库
}
+ (NSString *)getObjectByKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *obj = [defaults objectForKey:key];
    
    if (!obj) return nil;
    
    return obj;
}

@end
