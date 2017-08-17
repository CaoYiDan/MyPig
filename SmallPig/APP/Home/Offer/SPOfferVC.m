//
//  SPOfferVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/12.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPOfferVC.h"
#import "SPKungFuModel.h"
#import "SPOfferButton.h"
#import "SPOfferCategory.h"
#import "AddressViewController.h"

@interface SPOfferVC ()

@property(nonatomic ,strong)SPOfferCategory *categoryView;
@property(nonatomic ,strong)SPKungFuModel *model;
@end

@implementation SPOfferVC
{
    SPOfferButton *_city;
    SPOfferButton *_category;
    
    UITextField *_name;
    UITextField *_tel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self sUI];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choseOfferCity:) name:NotificationChoseOfferCity object:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)sUI{
    
    self.view.backgroundColor = BASEGRAYCOLOR;
    
    //选择类目
    SPOfferButton *category = [[SPOfferButton alloc]initWithFrame:CGRectMake(SCREEN_W/2-100, 50, 60, 100)];
    _category = category;
    [category setTitleColor:[UIColor blackColor] forState:0];
    [category setTitle:@"选择类目" forState:0];
    [category addTarget:self action:@selector(categoryChose) forControlEvents:UIControlEventTouchDown];
    [category setImage:[UIImage imageNamed:@"o_category"] forState:0];
    [self.view addSubview:category];
    
    //分割线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/2, 55, 1, 70)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,150, SCREEN_W, 100)];
    bottomView.backgroundColor =BASEGRAYCOLOR;
    [self.view addSubview:bottomView];
    
    //所在城市
    SPOfferButton *city = [[SPOfferButton alloc]initWithFrame:CGRectMake(SCREEN_W/2+40, 50, 60, 100)];
    _city = city;
    city.titleLabel.numberOfLines = 2;
    [city setTitleColor:[UIColor blackColor] forState:0];
    [city setTitle:@"选择城市" forState:0];
    [city addTarget:self action:@selector(city) forControlEvents:UIControlEventTouchDown];
    [city setImage:[UIImage imageNamed:@"o_location"] forState:0];
    [self.view addSubview:city];
    
    //输入姓名图片
    UIImageView *nameImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,10, 20, 20)];
    nameImg.image= [UIImage imageNamed:@"o_name"];
    [bottomView addSubview:nameImg];
    
    UITextField *nameText = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, 200, 40)];
    _name = nameText;
    nameText.placeholder = @"请输入您的姓名";
    nameText.font = kFontNormal;
    [bottomView addSubview:nameText];
    
    //分割线
    UIView *line1  = [[UIView alloc]initWithFrame:CGRectMake(10, 40, SCREEN_W-20, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:line1];
    
    //电话图片
    UIImageView *telImg = [[UIImageView alloc]initWithFrame:CGRectMake(10,51, 20, 20)];
    telImg.image= [UIImage imageNamed:@"o_tel"];
    [bottomView addSubview:telImg];
    
    UITextField *telText= [[UITextField alloc]initWithFrame:CGRectMake(40, 41, 200, 40)];
    _tel = telText;
    telText.font = kFontNormal;
    telText.placeholder = @"请输入您的联系电话";
    [bottomView addSubview:telText];
    
    //分割线
    UIView *line2  = [[UIView alloc]initWithFrame:CGRectMake(10, 81, SCREEN_W-20, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:line2];
    
    //快速报价
    UIButton *offerBtn= [[UIButton alloc]initWithFrame:CGRectMake(40, SCREEN_H2-50-49-64, SCREEN_W-80, 40)];
    offerBtn.layer.cornerRadius = 20;
    offerBtn.clipsToBounds = YES;
    offerBtn.titleLabel.font = font(13);
    offerBtn.layer.borderColor = RGBCOLOR(26, 134, 222).CGColor;
    [offerBtn setTitleColor:RGBCOLOR(26, 134, 222) forState:0];
    offerBtn.layer.borderWidth = 1.5f;
    [offerBtn setTitle:@"快速报价" forState:0];
    [offerBtn addTarget:self action:@selector(offer:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:offerBtn];
}

//选择分类界面
-(SPOfferCategory*)categoryView{
    if (!_categoryView) {
        _categoryView = [[SPOfferCategory alloc]initWithFrame:self.view.bounds];
         [self.view addSubview:_categoryView];
        WeakSelf;
        __weak typeof(_category) weakCategoryBtn = _category;
        _categoryView.choseCategory = ^(SPKungFuModel *model){
            [weakCategoryBtn setTitle:model.value forState:0];
            weakSelf.model= model;
        };
    }
    return _categoryView;
}

//选择了城市
-(void)choseOfferCity:(NSNotification *)notify{
    [_city setTitle:notify.object forState:0];
}

//分类
-(void)categoryChose{
  [self.categoryView setPonitZero];
  [UIView animateWithDuration:0.3 animations:^{
      self.categoryView.originY = 0;
  }];
}

//城市
-(void)city{
    //地址选择器
    AddressViewController *addressVC = [[AddressViewController alloc]init];
    addressVC.type = 1;
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:addressVC];
    [self presentViewController:naVC animated:YES completion:nil];
}

//快速报价
-(void)offer:(UIButton *)btn{
    
    if (!self.model) {
        Toast(@"请选择类目");
        return;
    }
    if (isEmptyString(_city.titleLabel.text) || [_city.titleLabel.text isEqualToString:@"选择城市"]) {
        Toast(@"请选择城市");
        return;
    }
    if (isEmptyString(_name.text)) {
        Toast(@"请输入姓名");
        return;
    }
    if (isEmptyString(_tel.text)) {
        Toast(@"请输入电话");
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:_city.titleLabel.text forKey:@"city"];
    [dict setObject:_category.titleLabel.text forKey:@"category"];
    [dict setObject:self.model.price forKey:@"price"];
    [dict setObject:self.model.code forKey:@"categoryCode"];
    [dict setObject:_name.text forKey:@"userName"];
    [dict setObject:_tel.text forKey:@"mobile"];

    [[HttpRequest sharedClient]httpRequestPOST:kUrlQuotationAdd parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        Toast(@"报价成功！");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
