//
//  SPDynamicDetialVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPBaseHomePushVC.h"
@class SPDynamicModel;
@interface SPDynamicDetialVC : SPBaseHomePushVC
/**模型*/
@property (nonatomic, strong)SPDynamicModel *model;
/**是否进入界面直接评论*/
@property(nonatomic,assign,getter=ifDirectEvaluate) BOOL directEvaluate;

@end
