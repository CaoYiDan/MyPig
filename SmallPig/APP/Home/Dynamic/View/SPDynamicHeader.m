//
//  SPHomeHeader.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicHeader.h"
#import "SPActivityWebVC.h"
#import "SPDynamicHeaderCell.h"
#import "SPCommon.h"
@interface SPDynamicHeader ()<UICollectionViewDataSource,UICollectionViewDelegate>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;

@end
@implementation SPDynamicHeader
{
    UIButton *_activityTitle;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self sTitle];
        [self creatCollection];
    }
    return self;
}

//设置数据源
-(void)setActivityArr:(NSArray *)activityArr{
    _activityArr = activityArr;
    [self.collectionview reloadData];
}

//设置 活动专场 title
-(void)sTitle{
    
    UIView *base  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    base.backgroundColor = HomeBaseColor;
    [self addSubview:base];
    
    UILabel *sectionView = [[UILabel alloc]initWithFrame:CGRectMake(35, 10, 100, 40)];
    sectionView.text = @"活动专场";
    sectionView.font = BoldFont(16);
    [base addSubview:sectionView];
    
    UIImageView *pig = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 20, 20)];
    [pig setImage:[UIImage imageNamed:@"h_pig"]];
    [base addSubview:pig];
   
    
    UIImageView *more = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-47, 26, 37, 8)];
    [more setImage:[UIImage imageNamed:@"h_activity_more"]];
    [base addSubview:more];
    
    //添加点击事件
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    [btn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchDown];
    btn.backgroundColor = [UIColor clearColor];
    [base addSubview:btn];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.activityArr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPDynamicHeaderCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPHomeHeaderCellID forIndexPath:indexPath];
    cell.activityDict = self.activityArr[indexPath.row];
    cell.backgroundColor = HomeBaseColor;
    return cell;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) return UIEdgeInsetsMake(0, 10, 1, 10);
    
    return UIEdgeInsetsMake(1, 1, 5, 1);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0)  return 20;
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SPActivityWebVC *vc = [[SPActivityWebVC alloc]init];
    
    NSDictionary* activityDict = self.activityArr[indexPath.row];
    vc.titleName = activityDict[@"title"];
    vc.code = activityDict[@"code"];
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}

#pragma  mark 创建collectionView
-(void)creatCollection{
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_W/2, SCREEN_W/4+60);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,40, [UIScreen mainScreen].bounds.size.width,SCREEN_W/4+70) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=HomeBaseColor;
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    [_collectionview registerClass:[SPDynamicHeaderCell class] forCellWithReuseIdentifier:SPHomeHeaderCellID];
    [self addSubview:_collectionview];
}

-(void)more{
    !self.moreBlock?:self.moreBlock();
}

@end
