//
//  SPHomeToolView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPDynamicModel;
@interface SPDynamicToolView : UIView
+ (instancetype)toolbar;
/**<##>model*/
@property (nonatomic, strong)SPDynamicModel *model;
@end
