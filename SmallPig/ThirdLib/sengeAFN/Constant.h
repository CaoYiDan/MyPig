//
//  Constant.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/2.
//  Copyright © 2017年 李智帅. All rights reserved.
//
//==============================================================================



#define  SKILL @"SKILL"
#define  TAG   @"TAG"
#define HOBBY  @"HOBBY"
#pragma mark - Rect

//左右边距宽度
#define kMargin 10.0f

#define  headerHeight 130.0f
//==============================================================================
#pragma mark - FontSize

#define  font(x)  [UIFont systemFontOfSize:x]

#define  BoldFont(x) [UIFont boldSystemFontOfSize:x]

#define kFontNormal_14 font(14+1)
#define kFontNormal font(13+1)
#define kFontTitle font(16)
#define kFontSmall font(11+1)

//====================================================================================
#pragma mark - --------------> 通用颜色色值 start
#define BaseRed        RGBCOLOR(228,54,53)     /*全局红*/
#define GRAYCOLOR        RGBCOLOR(238,238,238)     /*灰色标签*/
#define BASEGRAYCOLOR        RGBCOLOR(239,239,244)     /*全局灰色背景*/
#define DarkRed        RGBCOLOR(236,35,45)     /*深红色*/
#define HomeBaseColor        RGBCOLOR(239,239,244)     /*首页背影颜色*/
//#define NAVIGATIONCOLOR     RGBCOLOR(0,125,197)     /*蓝色导航*/
#define NAVIGATIONCOLOR     [Common colorWithHexString:@"#00b0ec"]     /*蓝色导航*/

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBCOLORA(r,g,b,z) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:z]
//标签颜色
#define PURPLECOLOR        RGBCOLOR(147,109,200)     /*紫色标签*/
#define LIGHTPURPLECOLOR        RGBCOLOR(224,213,238)     /*淡紫色标签*/
#define PRINKCOLOR          RGBCOLOR(197,153,223)    /*粉红色标签*/
#define LIGHTPRINKCOLOR          RGBCOLOR(231,197,230)    /*淡粉红色标签*/
#define BULECOLOR   RGBCOLOR(62,142,208)   /*蓝色标签*/
#define LIGHTBULECOLOR       RGBCOLOR(191,220,236)   /*淡蓝色标签*/
#define GREENCOLOR      RGBCOLOR(129,165,89)      /*绿色标签*/
#define LIGHTGREENCOLOR      RGBCOLOR(216,236,190)     /*淡绿色标签*/
#define REDCOLOR      RGBCOLOR(168,39,39)   /*红色标签*/
#define LIGHTREDCOLOR      RGBCOLOR(239,186,186)     /*淡红色标签*/
#define ORANGECOLOR      RGBCOLOR(218,152,14)   /*橘色标签*/
#define LIGHTORANGECOLOR      RGBCOLOR(218,200,190)     /*淡橘色标签*/
#define BLUECOLOR2      RGBCOLOR(81,175,166)   /*蓝色标签2*/
#define LIGHTBLUECOLOR2      RGBCOLOR(191,230,219)     /*淡蓝色标签2*/
#define BUTTONTITLECOLOR    [Common colorWithHexString:@"#0061bb"]     /*按钮蓝色字体*/
#define BUTTON_ORDERTITLECOLOR    [Common colorWithHexString:@"#fe5a00"]     /*立即预定按钮蓝色字体*/
#define MyBlueColor      RGBCOLOR(28,138,223)   /*蓝色标签*/

//列表长分割线颜色
#define kLongSeparatorLineColor [UIColor hexStringToColor:@"#dddddd"]
//列表短分割线颜色
#define kShortSeparatorLineColor [UIColor hexStringToColor:@"#e6e9ed"]

#pragma mark - --------------> 通用颜色色值 end

#pragma mark - -------------->StorageUser  start
#define kStorageUserDict          @"userDict"
#define kStorageUserAddressDict          @"userAddressDict"


#define kStorageLat          @"lat"
#define KStorageLon          @"lon"

#define kStorageUserId          @"userId"
#define KStorageUserCode        @"code"
#define kStorageUserMobile      @"userMobile"
#define kStorageUserName        @"userName"
#define kStorageHeaderName      @"headerName"
#define kStorageUserRealName    @"realName"
#define kStorageUserType        @"userType"
#define kStorageUserSubType     @"userSubType"
#define kStorageUserStatus      @"userStatus"
#define kStorageDeviceToken      @"deviceToken"


#define kiPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark - -------------->StorageUser end

#pragma mark - --------------> log start
#ifdef DEBUG
#ifndef DLog
#   define NSLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef NSLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif

#pragma mark - --------------> log end


