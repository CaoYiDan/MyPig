//
//  SPHomeCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicCell.h"
#import "SPCommon.h"
#import "SPDynamicModel.h"
#import "SPDynamicFrame.h"
#import "SPDynamicToolView.h"
#import "SPPhotosView.h"
#import "SPDetailIntroductionWebVC.h"
@interface SPDynamicCell ()

/** 坐标 frame*/
@property (nonatomic, weak) SPDynamicFrame *homeFrame;
/** 图片 View */
@property (nonatomic, strong) UIView *topView;
/** 图片 View */
@property (nonatomic, strong) SPPhotosView *photosView;

@property (nonatomic, strong) UIView *textView;

/** 正文 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconImg;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 和发布地点*/
@property (nonatomic, weak) UILabel *timeAndAreaLabel;
/** 工具条 */
@property (nonatomic, strong) SPDynamicToolView *toolbar;
/** 回复按钮 */
@property (nonatomic, strong) UIButton *answerBtn;

@end

@implementation SPDynamicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    SPDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:SPHomeCellID];
    if (cell==nil) {
        cell = [[SPDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPHomeCellID];
//        cell.clipsToBounds = YES;
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创UI
        [self setupOriginal];
    }
    return self;
}

- (void)setupOriginal
{
    [self sTop];
    [self sBottom];
}

-(void)sTop{
    
     /** topView */
    UIView *topView = [[UIView alloc]init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    self.topView.backgroundColor = [UIColor whiteColor];
    
    /**图片View */
   [topView addSubview:self.photosView];
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = kFontNormal_14;
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor whiteColor];
    [topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

-(void)sBottom{
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = HomeBaseColor;
    iconView.layer.cornerRadius  = 25;
    iconView.clipsToBounds = YES;
    iconView.userInteractionEnabled = YES;
    [self.contentView addSubview:iconView];
    self.iconImg = iconView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap)];
    tap.numberOfTapsRequired = 1;
    [iconView addGestureRecognizer:tap];
    
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = HomeBaseColor;
    nameLabel.font = kFontNormal_14;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间  和 发布地点*/
    UILabel *timeAndAreaLabel = [[UILabel alloc] init];
    timeAndAreaLabel.font = Font(12);
    timeAndAreaLabel.numberOfLines = 2;
    timeAndAreaLabel.textColor  = [UIColor lightGrayColor];
    timeAndAreaLabel.backgroundColor = HomeBaseColor;
    [self.contentView addSubview:timeAndAreaLabel];
    self.timeAndAreaLabel = timeAndAreaLabel;
    
      /**工具栏*/
    self.toolbar = [SPDynamicToolView toolbar];
    [self.contentView addSubview:self.toolbar];
    
    //分割线
    UIView *line  =[[UIView alloc]init];
    line.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_W-20, 0.6));
        make.bottom.equalTo(self).offset(-15);
        make.left.offset(10);
    }];
}

-(SPPhotosView *)photosView{
    if (!_photosView) {
        _photosView = [[SPPhotosView alloc] init];
        _photosView.backgroundColor = [UIColor whiteColor];
    }
    return _photosView;
}

-(void)setStatusFrame:(SPDynamicFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    _statue = statusFrame.status;
    
    //上部分baseView
    _topView.frame = statusFrame.topViewF;
    
    //图片
    _photosView.frame = statusFrame.photosViewF;
    [_photosView setImgArr:statusFrame.status.imgs];
    
    //正文
    _contentLabel.frame = statusFrame.contentLabelF;
    _contentLabel.text = statusFrame.status.text;
    
    //头像
    _iconImg.frame = statusFrame.iconViewF;
    if (statusFrame.status.promulgatorAvatar) {
         [_iconImg sd_setImageWithURL:[NSURL URLWithString:statusFrame.status.promulgatorAvatar]];
    }
   
    //昵称
    _nameLabel.frame = statusFrame.nameLabelF;
    _nameLabel.text = statusFrame.status.promulgatorName;
    
    //发布时间 和地点
    _timeAndAreaLabel.frame = statusFrame.timeAndAreaLabelF;
    if (kiPhone5) {
        _timeAndAreaLabel.text = [NSString stringWithFormat:@"%@\n%@",statusFrame.status.time,statusFrame.status.locationValue];
    }else{
    _timeAndAreaLabel.text = [NSString stringWithFormat:@"%@ %@",statusFrame.status.time,statusFrame.status.locationValue];
    }
    //工具栏
    _toolbar .frame = statusFrame.toolbarF;
    [_toolbar setModel:statusFrame.status];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    //将图片view上的图片移除，不然错乱
    for (UIView *vi in self.photosView.subviews) {
        [vi removeFromSuperview];
    }
}

-(void)iconTap{
    
    SPDetailIntroductionWebVC *vc = [[SPDetailIntroductionWebVC alloc]init];
    vc.code = self.statue.code;
    NSLog(@"%@",self.statue.promulgatorName);
    vc.titleName = self.statue.promulgatorName;
    [[SPCommon getCurrentVC] presentViewController:vc animated:YES completion:nil];
}
@end
