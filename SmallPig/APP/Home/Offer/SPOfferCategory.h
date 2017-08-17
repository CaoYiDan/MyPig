//
//  SPOfferCategory.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/13.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SPKungFuModel;
#import "SPBasePopView.h"
typedef void(^categoryChose)(SPKungFuModel *model);
@interface SPOfferCategory : SPBasePopView
/***/
@property(nonatomic,copy) categoryChose choseCategory;
//吊起时，将contentPonit 设置为 00
-(void)setPonitZero;
@end
