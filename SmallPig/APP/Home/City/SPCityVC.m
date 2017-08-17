//
//  SPCityVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/29.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPCityVC.h"
#import "SPThirdLevelCell.h"

@interface SPCityVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)NSArray *hotCityArray;

@end

@implementation SPCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self sNav];
    
    [self creatCollection];
    
    //从文件读取地址字典
    [self getCityName];
}

//从文件读取地址字典
-(void)getCityName{

    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address1" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    
    //热门城市
    self.hotCityArray = @[@"深圳",@"广州",@"北京",@"天津",@"上海",@"南京"];
    
    //其他城市
    self.listArray = [dict objectForKey:@"address"];
    NSMutableArray *copyList = [[NSMutableArray alloc]initWithArray:self.listArray];
    
    //遍历 剔除掉 热门城市
    for (NSDictionary *dict in self.listArray) {
        NSString *name = dict[@"name"];
        for (NSString *city in self.hotCityArray) {
            if ([name isEqualToString:city]) {
                [copyList removeObject:dict];
            }
        }
    }
    self.listArray = copyList;
    
    [self.collectionview reloadData];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section ==0){
        return 0;
    }else if (section == 1){
        return self.hotCityArray.count;
    }else{
        return self.listArray.count;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPThirdLevelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPThirdLevelCellID forIndexPath:indexPath];
    if (indexPath.section ==1) {
         [cell setText:self.hotCityArray[indexPath.row]];
    }
    if (indexPath.section == 2) {
        NSDictionary *city = self.listArray[indexPath.row];
         [cell setText:city[@"name"]];
    }
    
    cell.backgroundColor = HomeBaseColor;
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, 40, 10, 40);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma  mark 返回的header视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_W, 40);
}

//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    
    if (kind ==UICollectionElementKindSectionHeader) {
        //定制头部视图的内容
       UICollectionReusableView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        UIImageView *locationImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 7, 22, 22)];
        
        [headerV addSubview:locationImg];
        
        UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 40)];
        textLab.backgroundColor = [UIColor whiteColor];
        [headerV addSubview:textLab];
        
        if (indexPath.section ==0) {
            [locationImg setImage: [UIImage imageNamed:@"c_location"]];
            textLab.font = kFontNormal;
            if (!isEmptyString(self.locationCity)) {
                textLab.text = self.locationCity;
            }else{
                textLab.text = @"定位失败";
            }
        }else if(indexPath.section ==1){
            [locationImg setImage: [UIImage imageNamed:@"c_hot"]];
            textLab.text = @"热门城市";
        }else{
            [locationImg setImage: [UIImage imageNamed:@"c_location"]];
            textLab.text = @"其他";
        }
        
        reusableView = headerV;
    }
       return reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *city = @"";
    if (indexPath.section == 1) {
        city = self.hotCityArray[indexPath.row];
    }else{
        NSDictionary *dict=self.listArray[indexPath.row];
        city = dict[@"name"];
    }
    !self.cityBlock?:self.cityBlock(city);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark 创建collectionView
-(void)creatCollection{
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_W-100)/3, 30);
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,84, [UIScreen mainScreen].bounds.size.width,SCREEN_H-20) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    [_collectionview registerClass:[SPThirdLevelCell class] forCellWithReuseIdentifier:SPThirdLevelCellID];
    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:_collectionview];
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(void)sNav{
    self.titleLabel.text = @"定位";
}

@end
