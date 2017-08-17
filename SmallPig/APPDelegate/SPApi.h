//
//  SPApi.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

//#define kUrlBase   @"http://192.168.1.77:8000"

#define kUrlBase   @"http://192.168.1.227:8000"

//登录
#define kUrlLogin      kUrlBase@"/v1/user/login"

//喜欢与不喜欢接口
#define kUrlLikeOrNO      kUrlBase@"/v1/like/add"

//获取曾经的筛选信息
#define kUrlHistorySifting      kUrlBase@"/v1/user/getLastSearchHistory"

//保存用户筛选信息
#define kUrladdSearchHistory      kUrlBase@"/v1/user/addSearchHistory"

//快速报价接口
#define kUrlQuotationAdd      kUrlBase@"/v1/quotation/add"
//获取所有等级接口
#define kUrlGetAllLevel      kUrlBase@"/v1/user/listAllLevels"

//个人信息更新
#define kUrlUpdateUser      kUrlBase@"/v1/user/updateUser"
//发布评论
#define kUrlFeedComment      kUrlBase@"/v1/comment/add"
//发布动态
#define kUrlFeedAdd      kUrlBase@"/v1/feed/add"
//个人信息
#define kUrlMine      kUrlBase@"/v1/user/getUser"
//短信发送
#define MessageSend kUrlBase@"/v1/sms/sendVerifyCode"
//短信验证
#define MessageCompare kUrlBase@"/v1/sms/sendVerifyCode"

//获取用户动态列表
#define kUrlFeedList     kUrlBase@"/v1/feed/list"
//获取动态详情
#define kUrlFeedGet     kUrlBase@"/v1/feed/get"
//获取活动列表
#define kUrlActivityList     kUrlBase@"/v1/activity/list"
//添加点赞
#define kUrlAddPraise     kUrlBase@"/v1/praise/add"
//查询附近人
#define kUrlSearchUser     kUrlBase@"/v1/user/searchUser"
//取消点赞
#define kUrlDeletePraise     kUrlBase@"/v1/praise/delete"



//获取用户信息
#define kUrlGetUser     kUrlBase@"/v1/user/getUser"
//获取用户等级信息
#define kUrlGetUserLevel     kUrlBase@"/v1/user/getLevel"
//我的武功
#define kUrlListSkill      kUrlBase@"/v1/user/listSkills"
//我的标签
#define kUrllistTag      kUrlBase@"/v1/user/listTag"

//根据用户获取 我的武功
#define listSkillsByUser      kUrlBase@"/v1/user/listSkillsByUser"

//根据用户获取 我的标签
#define listTagsByUser      kUrlBase@"/v1/user/listTagsByUser"

//根据用户获取 我的兴趣
#define listHobbiesByUser      kUrlBase@"/v1/user/listHobbiesByUser"

//获取三级标签
#define kUrlListLeafByParentCode      kUrlBase@"/v1/forest/listLeafByParentCode"
////登录
//#define kUrlLogin      kUrlBase@"/v1/user/login"
//
////登录
//#define kUrlLogin      kUrlBase@"/v1/user/login"
//
////登录
//#define kUrlLogin      kUrlBase@"/v1/user/login"
//我的预约
#define kUrlMineReserve      kUrlBase@"/v1/reservation/listMyReservations"
//预约我的
#define kUrlReserveMine      kUrlBase@"/v1/reservation/listMyReservations"
