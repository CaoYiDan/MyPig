//
//  SPHomeCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPDynamicFrame,SPDynamicModel;

static NSString *SPHomeCellID = @"SPHomeCellID";

@interface SPDynamicCell : UITableViewCell


@property (nonatomic, strong) SPDynamicFrame*statusFrame;

@property (nonatomic, strong) SPDynamicModel*statue;
/**<##>block回传*/
@property(nonatomic,copy) void(^block)(NSString *evaluateId);

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath*)indexPath;

@end
