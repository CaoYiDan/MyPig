//
//  SPUser.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPUser : NSObject

@property (nonatomic, copy) NSString *beFrom;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *nickName;

@property (nonatomic, copy) NSDictionary *level;

@property (nonatomic, copy) NSString *signature;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *imPasswd;

@property (nonatomic, copy) NSString *realName;

@property (nonatomic, copy) NSString *haunt;

@property (nonatomic, assign) int infoPercent;

@property (nonatomic, copy) NSString *createdAt;

@property (nonatomic, copy) NSString *updatedAt;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, assign) int id;

@property (nonatomic, assign) int gender;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *zodiac;

@property (nonatomic, copy) NSString *experience;

@property (nonatomic, copy) NSString *job;

@property (nonatomic, strong)NSArray *tags;

@property (nonatomic, strong)NSArray *skills;

@property (nonatomic, strong)NSArray *avatarList;
@end
