//
//  SPDynamicDetialVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicDetialVC.h"
#import "SPUserNavTitleView.h"
#import "SPDyDetailImgCell.h"
#import "SPDyDetailEvaluateCell.h"
#import "SPDynamicModel.h"
#import "SDPhotoBrowser.h"
#import "SPFooterView.h"
#import "NSString+getSize.h"
#import "SPCommentModel.h"
#import "SPDyDetailBottomView.h"
#import <IQKeyboardManager.h>
#import "CMInputView.h"

@interface SPDynamicDetialVC ()<UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate>

//collection
@property(nonatomic,strong)UICollectionView*collectionview;
@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSMutableArray *imgHeightArr;//图片高度数组
@property(nonatomic,strong)NSMutableArray *praiseArr;//点赞数组
@property(nonatomic,strong)NSMutableArray *conmentArr;//评论数组
@property(nonatomic,strong)NSMutableArray *conmentHeightArr;//评论数组高度
@property(nonatomic,assign)BOOL shat;//关闭
@property(nonatomic,strong)SPDyDetailBottomView *toolView;//底部控件

//评价输入框
@property(nonatomic,strong)UIView *baseInputView;//评论框父控件
@property(nonatomic,strong)CMInputView *inputView;//评论框

//评价参数
@property(nonatomic,copy)NSString *beCommented;//被评论的人
@property(nonatomic,copy)NSString *type;//评论类型：FEED,COMMENT
@property(nonatomic,copy)NSString *beCommentedCode;//被评论数据的code，feedCode或者commentCode
@end

@implementation SPDynamicDetialVC
{
    CGFloat keyHeight;//键盘高度
}
#pragma  mark - -----------------lefecycle-----------------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self sNav];
    [self load];
    [self.view addSubview:self.toolView];
    //异步计算图片的高度
    [self calculateImgHeight];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
        
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
}
    
- (void)viewWillDisappear:(BOOL)animated{
        
    [super viewWillDisappear:animated];
        
    [IQKeyboardManager sharedManager].enable = YES;
        
}
    
//计算图片的高度
-(void)calculateImgHeight{
    
    //1.获取一个全局串行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.把任务添加到队列中执行
    dispatch_async(queue, ^{
        CGFloat totalH = 0;
        for (int i = 0;i<self.model.imgs.count;i++) {
            
            //3.获取加载的图片的大小，然后按比例返回高度  并返回image.
            UIImage *image = [self createImgHeightArrAt:i];
            
            totalH += image.size.height/image.size.width*SCREEN_W;
#warning  如果 图片总高度超出了总屏幕的高度，则停止计算，直接刷新，在页面滑动的时候，再加载剩余的图片
            if (totalH >SCREEN_H || i == self.model.imgs.count-1) {
                //4.回到主线程，创建UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    //创建collectionView
                    [self.collectionview reloadData];
                });
                return ;
            }
        }
    });
}

-(UIImage *)createImgHeightArrAt:(NSInteger)index{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.imgs[index]]];
    UIImage *image = [UIImage imageWithData:data];
    [self.imgHeightArr addObject:@(image.size.height/image.size.width*SCREEN_W)];
    return image;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    //.注册通知。检测键盘的弹出和隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyShowForDetail:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideForDetail:) name:UIKeyboardWillHideNotification object:nil];
//
    //直接评论
    if (self.directEvaluate) {
        [self startEvaluate];
    }
    
     self.collectionview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma  mark - 请求数据

-(void)load{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:self.model.code forKey:@"feedCode"];
    [dict setObject:[StorageUtil getCode] forKey:@"readerCode"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedGet parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        /** 点赞--数据较少 未生成模型*/
        self.praiseArr = responseObject[@"data"][@"praiseList"];
        
        /** 评论*/
        self.conmentArr = responseObject[@"data"][@"commentList"];
        
         /** 评论cell返回的高度*/
        self.conmentHeightArr = [self getCommentHeightArr];
        
        //给底部toolview 赋值
        [self.toolView setPrasizedCount:self.praiseArr.count evaluateNum:self.conmentArr.count ifPrasized:[responseObject[@"data"][@"praised"] boolValue]];
        
       [self.collectionview reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        Toast(@"网络错误");
    }];
}

-(NSMutableArray *)getCommentHeightArr{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    /** 评论cell返回的高度*/
    for (NSDictionary *dic in self.conmentArr) {
        
      [arr addObject:@([self getContentHeightWithDict:dic])];
    }
    return arr;
}

-(CGFloat)getContentHeightWithDict:(NSDictionary *)dic{
    
    CGFloat maxW = SCREEN_W - 75;
    CGSize contentSize  = CGSizeZero;
    //因为 评论有两种类型 1.开始 拼接 “回复。。” 2.直接评论，
    if ([dic[@"type"] isEqualToString:@"COMMENT"]) {//1.评价回复
        
        contentSize = [[NSString stringWithFormat:@" 回复:%@ %@",dic[@"beCommentedUserName"],dic[@"content"]] sizeWithFont:kFontNormal maxW:maxW];
        
    }else{ //直接回复
        contentSize = [dic[@"content"] sizeWithFont:kFontNormal_14 maxW:maxW];
    }
    
    return contentSize.height+80;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return self.imgHeightArr.count;
    }else{
        return self.conmentArr.count;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {//大图
        SPDyDetailImgCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPDyDetailImgCellID forIndexPath:indexPath];
        cell.imgUrl = self.model.imgs[indexPath.row];
        cell.clipsToBounds = YES;
        return cell;
    } else if (indexPath.section ==1) {//评价
        SPDyDetailEvaluateCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPDyDetailEvaluateCellID forIndexPath:indexPath];
        NSDictionary *dict = self.conmentArr[indexPath.row];
        [cell setDic:dict andHeight:[self.conmentHeightArr[indexPath.row] doubleValue]];
        return cell;
    }
    
    return [[UICollectionViewCell alloc]init];
}

//返回的cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = 0;
    if (indexPath.section ==0) {

        h = [self.imgHeightArr[indexPath.row] doubleValue];
        
    }else{
        
        h= [self.conmentHeightArr[indexPath.row] doubleValue];
        
    }
    return CGSizeMake(SCREEN_W, h);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) return UIEdgeInsetsMake(10, 0,5, 0);
    
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0)  return 0;
    return 2;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma  mark 返回的footer视图大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==0) {
        CGFloat maxW = SCREEN_W-20;
        //根据字数多少返回对应的高度
        CGSize contentSize = [self.model.text sizeWithFont:kFontNormal maxW:maxW];
        return  CGSizeMake(SCREEN_W, contentSize.height+60);
    }
    return CGSizeZero;
}

#pragma  mark 返回Header视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind==UICollectionElementKindSectionFooter) {
        SPFooterView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];;
        footer.backgroundColor = [UIColor whiteColor];
        [footer setArr:self.praiseArr content:self.model.text];
        return footer;
    }
    return nil;
}

#pragma  cell 点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//查看大图
        SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
        photoBrowser.delegate = self;
        photoBrowser.currentImageIndex = indexPath.row;
        photoBrowser.imageCount = self.model.imgs.count;
        photoBrowser.sourceImagesContainerView = collectionView;
        [photoBrowser show];
        
    }else if (indexPath.section == 1){//回复评价
        
        NSDictionary *dict = self.conmentArr[indexPath.row];
        self.beCommented = dict[@"commentorCode"];
        self.type = @"COMMENT";
        self.beCommentedCode = dict[@"commentorCode"];
        
        [self baseTextView];
        [self.inputView becomeFirstResponder];
    }
}

#pragma  mark ---- 在页面滑动的时候，再加载剩余的图片
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (self.model.imgs.count>self.imgHeightArr.count && !self.shat) {
        
        self.shat = YES;
        //1.获取一个全局串行队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //2.把任务添加到队列中执行
        dispatch_async(queue, ^{
            
            for (int i = (int)self.imgHeightArr.count;i<self.model.imgs.count;i++) {
                
            //3.获取加载的图片的大小，然后按比例返回高度
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.imgs[i]]];
            UIImage *image = [UIImage imageWithData:data];
            [self.imgHeightArr addObject:@(image.size.height/image.size.width*SCREEN_W)];
            
            }
            //4.回到主线程，创建UI
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //刷新 section ==0 的界面
                [self.collectionview reloadData];
            });
        });
    }
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlString = self.model.imgs[index];
    return [NSURL URLWithString:urlString];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.imgs[index]]];
    
    return imageView.image;
}

#pragma  mark - setter
#pragma  mark 创建collectionView
-(UICollectionView*)collectionview{
    if (!_collectionview) {
        
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width,SCREEN_H-50) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    [_collectionview registerClass:[SPDyDetailImgCell class] forCellWithReuseIdentifier:SPDyDetailImgCellID];
    [_collectionview registerClass:[SPDyDetailEvaluateCell class] forCellWithReuseIdentifier:SPDyDetailEvaluateCellID];
    [_collectionview registerClass:[SPFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

    [self.view addSubview:_collectionview];
    }
    return _collectionview;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (NSMutableArray *)imgHeightArr
{
    if (_imgHeightArr == nil) {
        _imgHeightArr = [NSMutableArray array];
        }
    return _imgHeightArr;
}

- (NSMutableArray *)praiseArr
{
    if (_praiseArr == nil) {
        _praiseArr = [NSMutableArray array];
    }
    return _praiseArr;
}

- (NSMutableArray *)conmentArr
{
    if ( _conmentArr== nil) {
        _conmentArr = [NSMutableArray array];
    }
    return _conmentArr;
}

- (NSMutableArray *)conmentHeightArr
{
    if ( _conmentHeightArr== nil) {
        _conmentHeightArr = [NSMutableArray array];
    }
    return _conmentHeightArr;
}

#pragma  mark 底部控件

-(SPDyDetailBottomView*)toolView{
    if (!_toolView) {
        _toolView = [[SPDyDetailBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_H2-50, SCREEN_W, 50) withCode:self.model.code];

        WeakSelf;
        _toolView.toolClick = ^(NSInteger tag){
            if (tag == 1) {//评论
                [weakSelf startEvaluate];
            }else if(tag == 2)
            {//点赞
             [weakSelf load];
            }        };
    }
   return  _toolView;
}

-(void)startEvaluate{
    WeakSelf;
    weakSelf.beCommented = weakSelf.model.promulgator;
    weakSelf.beCommentedCode = weakSelf.model.code;
    weakSelf.type = @"FEED";
    [weakSelf baseTextView];
    [weakSelf.inputView becomeFirstResponder];
}

#pragma  mark 评价输入框 父控件
-(UIView *)baseTextView{
    if (!_baseInputView) {
        _baseInputView=[[UIView alloc]initWithFrame:CGRectMake(0 ,SCREEN_H2,SCREEN_W , 38)];
        
        [_baseInputView addSubview:self.inputView];
        
        UIButton *sendBtn = [[UIButton alloc]init];
        sendBtn.backgroundColor = [UIColor orangeColor];
        [sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchDown];
        [sendBtn setTitle:@"发送" forState:0];
        [_baseInputView addSubview:sendBtn];
        [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.width.offset(70);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
        [self.view addSubview:_baseInputView];
    }
    return _baseInputView;
}

//输入框
- (CMInputView *)inputView{
    
    if (_inputView == nil) {
        _inputView = [[CMInputView alloc]initWithFrame:CGRectMake(0 , 0,SCREEN_W-70 , 38)];
        _inputView.font = [UIFont systemFontOfSize:18];
        _inputView.placeholder = @"回复点什么吧...";
        _inputView.placeholderColor = [UIColor grayColor];
        _inputView.placeholderFont = [UIFont systemFontOfSize:14];
        // 设置文本框最大行数
        WeakSelf;
        [_inputView textValueDidChanged:^(NSString *text, CGFloat textHeight) {
//            textHeight+=;
            NSLog(@"%.f",textHeight);
            CGRect frame = weakSelf.baseInputView.frame;
            frame.size.height = textHeight;
            frame.origin.y=SCREEN_H2-textHeight-keyHeight;
            weakSelf.baseInputView.frame = frame;
            weakSelf.inputView.frameHeight = textHeight;
        }];
        _inputView.maxNumberOfLines = 3;
    }
    return _inputView;
}

#pragma  mark 导航栏

-(void)sNav{
    
    SPUserNavTitleView *titleView = [[SPUserNavTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-60, 44)];
    titleView.model = self.model;
    self.navigationItem.titleView = titleView;

}

#pragma  mark - action


#pragma mark  消息触发事件
///键盘显示事件
- (void)keyShowForDetail:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    keyHeight= kbHeight;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGRect newRect = CGRectMake(0,SCREEN_H2-keyHeight-38,SCREEN_W, self.baseInputView.frameHeight);
        self.baseInputView.frame = newRect;
    }];
}

///键盘消失事件
- (void)keyboardWillHideForDetail:(NSNotification *)notify {
    
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    /*
     你想下沉到哪里就到哪里
     */
    [UIView animateWithDuration:duration animations:^{
        
        self.baseInputView.frame = CGRectMake(0, SCREEN_H2, SCREEN_W, 38);
        self.inputView.frameHeight = 38;
    }];
    //将输入框内容 置空
    self.inputView.text = @"";
    [self.inputView textDidChange2];
}

#pragma  mark 发送评价
-(void)send{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.beCommented  forKey:@"beCommented"];
    [dict setObject:[StorageUtil getCode] forKey:@"commentor"];
    
    if (isEmptyString(self.inputView.text)) {
        Toast(@"评论不能为空");
        return;
    }
    
    [dict setObject:self.inputView.text forKey:@"content"];
    [dict setObject:self.model.code forKey:@"feedCode"];
    [dict setObject:self.type forKey:@"type"];
    [dict setObject:self.beCommentedCode forKey:@"beCommentedCode"];
    
    //退下键盘
    [self coverTap];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedComment parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        //评论成功
        
        //刷新数据
        [self load];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark 点击键盘上半部分区域
-(void)coverTap{
    
    [self.view endEditing:YES];
}
@end
