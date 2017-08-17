//
//  SPDetailIntroductionWebVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/10.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^likeOrNoBlock) (NSInteger feel);
@interface SPDetailIntroductionWebVC : UIViewController
/**<##>coreId*/
@property(nonatomic,copy)NSString*code;
/**<##>导航栏标题*/
@property(nonatomic,copy)NSString *titleName;
/**block 回传*/
@property(nonatomic,copy)likeOrNoBlock likeOrNo ;
/**是否有喜欢与不喜欢按钮*/
@property(nonatomic,assign)BOOL  haveLikeBtn;

@end
