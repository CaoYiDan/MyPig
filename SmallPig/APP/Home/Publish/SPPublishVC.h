//
//  SPPublishVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/29.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPBaseHomePushVC.h"

typedef void(^publishFinish)();

@interface SPPublishVC : SPBaseHomePushVC

/**定位城市*/
@property(nonatomic,copy)NSString*locationCity;

/**回调*/
@property(nonatomic,copy) publishFinish publishFinsih;


@end
