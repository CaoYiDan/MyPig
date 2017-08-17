//
//  SPCategoryChoseView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/13.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPOfferCategory.h"
#import "SPKungFuModel.h"
@interface SPOfferCategory ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray*listArray1;

@property(nonatomic,strong)UITableView*levelTab1;
@property(nonatomic,strong)UITableView*levelTab2;

@end

@implementation SPOfferCategory
{
    UIScrollView *_scrollView;
    NSInteger _index;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
        [self load];
    }
    return self;
}

//请求一二级数据
-(void)load{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@%@",kUrlBase,@"/v1/user/listSkills"] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        self.listArray1 = [SPKungFuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.levelTab1 reloadData];
        [MBProgressHUD hideHUDForView:self animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)sUI{
    
    
    [self addSubview:[self baseScrollView]];
    
    UIView *base1 = [self baseView1];
    UIView *base2 = [self baseView2];
    
    //一级
    [base1 addSubview:[self shatBtnByLevel:1]];
    [base1 addSubview:self.levelTab1];
    
    //二级
    [base2 addSubview:[self shatBtnByLevel:2]];
    [base2 addSubview:self.levelTab2];
}

#pragma  mark - tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView ==self.levelTab1) {
        return self.listArray1.count;
    }else{
        if (self.listArray1.count == 0) return 0;
       
    SPKungFuModel *model = self.listArray1[_index];
        
       return model.subProperties.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (tableView == self.levelTab1) {
        SPKungFuModel *model1 = self.listArray1[indexPath.row];
        cell.textLabel .text = model1.value;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        SPKungFuModel *model1 = self.listArray1[_index];
        SPKungFuModel *model2 = model1.subProperties[indexPath.row];
        cell.textLabel .text = model2.value;
    }
    
    cell.textLabel.font = kFontNormal;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.levelTab1) {
        //一级点击
        _index = indexPath.row;
        
        [self.levelTab2 reloadData];
        
        [_scrollView setContentOffset:CGPointMake(SCREEN_W, 0) animated:YES];
        
    }else{
        
        [self shat];
        
        //二级点击
        SPKungFuModel *model1  = self.listArray1[_index];
        SPKungFuModel *model2 = model1.subProperties[indexPath.row];
        //回传
        !self.choseCategory?:self.choseCategory(model2);
    }
}

#pragma  mark - action
#pragma  mark 初始化，使得ContentOffset为（0，0）

-(void)setPonitZero{
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

#pragma  mark 关闭点击事件
-(void)shat{
    [UIView animateWithDuration:0.3 animations:^{
        self.originY = SCREEN_H+100;
    }];
}

#pragma  mark - setter

-(UIScrollView *)baseScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H2-64)];
    _scrollView.pagingEnabled = YES;
    [_scrollView setScrollEnabled:NO];
    _scrollView.contentSize = CGSizeMake(SCREEN_W*2, 0);
    _scrollView.backgroundColor =[UIColor clearColor];
    return _scrollView;
}

-(UIView *)baseView1{
    UIView *base1 = [[UIView alloc]initWithFrame:CGRectMake(40,SCREEN_H/2-170, SCREEN_W-80,340)];
    base1.layer.cornerRadius = 5;
    base1.clipsToBounds= YES;
    base1.backgroundColor = MyBlueColor;
    [_scrollView addSubview:base1];
    return base1;
}

-(UIView *)baseView2{
    UIView *base2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W+ 40, SCREEN_H/2-170, SCREEN_W-80, 340)];
    base2.layer.cornerRadius = 5;
    base2.clipsToBounds= YES;
    base2.backgroundColor = MyBlueColor;
    [_scrollView addSubview:base2];
    return base2;
}


- (NSMutableArray *)listArray1
{
    if (_listArray1 == nil) {
        
        _listArray1 = [NSMutableArray array];
        
    }
    return _listArray1;
}

-(UITableView *)levelTab1{
    if (!_levelTab1 ) {
        
        _levelTab1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_W-80,300) style:UITableViewStyleGrouped];
        
        _levelTab1.delegate = self;
        _levelTab1.dataSource = self;
        _levelTab1.rowHeight = 40;
        _levelTab1.contentInset = UIEdgeInsetsMake(-38, 0, 0, 0);
        
    }
    return _levelTab1;
}

-(UITableView *)levelTab2{
    if (!_levelTab2 ) {
        _levelTab2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_W-80, 300)style:UITableViewStyleGrouped];
        _levelTab2.delegate = self;
        _levelTab2.dataSource = self;
        _levelTab2.rowHeight = 40;
        _levelTab2.contentInset = UIEdgeInsetsMake(-38, 0, 0, 0);
        
    }
    return _levelTab2;
}

#pragma  mark 关闭按钮
-(UIButton *)shatBtnByLevel:(NSInteger)level{
    UIButton *shat = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-80)/2-50, 0, 100, 40)];
    [shat setTitle:[NSString stringWithFormat:@"分类 %ld级",(long)level] forState:0];
    [shat addTarget:self action:@selector(shat) forControlEvents:UIControlEventTouchDown];
    return shat;
}

@end
