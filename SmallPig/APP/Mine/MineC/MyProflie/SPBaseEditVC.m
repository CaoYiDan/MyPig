//
//  SPBaseEditVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPBaseEditVC.h"

@interface SPBaseEditVC ()<UITextFieldDelegate>

@end

@implementation SPBaseEditVC
{
    UITextField *_textFiled;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    
    [self setBaseImgViewWithImgage:[UIImage imageNamed:@"gr_birthday"]];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 100, 30)];
    title.text = self.titletText;
    [self.view addSubview:title];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 150, SCREEN_W-20, 40)];
    _textFiled = textField;
    textField.delegate = self;
    textField.alpha = 0.6;
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.layer.borderWidth = 1.0f;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
    [textField becomeFirstResponder];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{

}

-(void)next{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:_textFiled.text forKey:self.codeText];
    [self postMessage:dict pushToVC:nil];
}
@end
