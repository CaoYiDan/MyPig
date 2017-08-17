//
//  SPHomeDataManager.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPHomeDataManager.h"
#import "SPDynamicFrame.h"
#import "SPDynamicModel.h"

@implementation SPHomeDataManager

+(void)getMoreHomeDateWithPage:(NSInteger)page scoree:(NSString *)score success:(void (^)(NSArray *, BOOL, NSString *))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    // 当前用户code（未登录时传0）
    [dict setObject:isEmptyString([StorageUtil getCode])?@"0":[StorageUtil getCode] forKey:@"timeLineOwner"];
    
    //时间（传空的时候返回最新的）
    [dict setObject:score forKey:@"score"];
    
    [dict setObject:@(page) forKey:@"pageNum"];
    [dict setObject:@"2" forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSMutableArray *dataArr = [NSMutableArray array];
        NSLog(@"%@",responseObject);
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            //遍历 计算每个cell高度
            for (NSDictionary *dict in responseObject[@"data"]) {
                SPDynamicFrame *frame = [[SPDynamicFrame alloc]init];
                frame.status = [SPDynamicModel mj_objectWithKeyValues:dict];
                [dataArr addObject:frame];
            }
            
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /** 记录最后一条数据的时间*/
                SPDynamicFrame *lastModelF = [dataArr lastObject];
                
                success(dataArr,YES,lastModelF.status.score);
                
            });
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}


+(void)refreshHomeDatesuccess:(void (^)(NSArray *, BOOL,NSString*))success failure:(void (^)(NSError *))failure{

    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    // 当前用户code（未登录时传0）
    
    [dict setObject:isEmptyString([StorageUtil getCode])?@"0":[StorageUtil getCode] forKey:@"timeLineOwner"];
    
    // 时间（传空的时候返回最新的）
    [dict setObject:@"" forKey:@"score"];
    [dict setObject:@(1) forKey:@"pageNum"];
    [dict setObject:@"6" forKey:@"pageSize"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedList parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSMutableArray *arr = [NSMutableArray array];
        
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            //遍历 计算每个cell高度
            for (NSDictionary *dict in responseObject[@"data"]) {
                SPDynamicFrame *frame = [[SPDynamicFrame alloc]init];
                frame.status = [SPDynamicModel mj_objectWithKeyValues:dict];
                [arr addObject:frame];
            }
            
            //3.回到主线程，展示图片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                /** 记录最后一条数据的时间*/
                SPDynamicFrame *modelF = [arr lastObject];
                success(arr,YES,modelF.status.score);
               
            });
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}


@end
