//
//  MHMineHeadCell.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineHeadCell.h"

@implementation MHMineHeadCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createview];
        
    }
    return self;
}
-(void)createview
{
    [self addSubview:self.bgimageview];
    [self.bgimageview addSubview:self.bgimageSmallview];
    [self.bgimageSmallview addSubview:self.headimageview];
    [self.bgimageSmallview addSubview:self.username];
    [self.bgimageSmallview addSubview:self.userleverImage];
    [self.bgimageSmallview addSubview:self.userlever];
    

    [self.headimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(54));
        make.left.equalTo(self.bgimageSmallview.mas_left).offset(kRealValue(16));
        make.centerY.equalTo(self.bgimageSmallview.mas_centerY).offset(kRealValue(0));
        make.height.mas_equalTo(kRealValue(54));
    }];
    
   ViewBorderRadius(self.headimageview, kRealValue(27), 0, [UIColor whiteColor]);
    self.headimageview.backgroundColor = kRandomColor;
    
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headimageview.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.headimageview.mas_top).offset(kRealValue(5));
        make.width.mas_equalTo(kRealValue(200));
        make.height.mas_equalTo(kRealValue(20));
    }];
//    [self.userleverImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.headimageview.mas_right).offset(kRealValue(10));
//        make.top.equalTo(self.username.mas_bottom).offset(kRealValue(10));
//        make.width.mas_equalTo(kRealValue(12));
//        make.height.mas_equalTo(kRealValue(12));
//    }];
    [self.userlever mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headimageview.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.username.mas_bottom).offset(kRealValue(10));
        make.width.mas_equalTo(kRealValue(120));
        make.height.mas_equalTo(kRealValue(12));
       
    }];
    
//    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(60),kRealValue(65), kRealValue(60), kRealValue(24))];
//    lineview.backgroundColor = KColorFromRGBA(0x000000, 0.2);
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lineview.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(kRealValue(12), kRealValue(12))];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = lineview.bounds;
//    maskLayer.path = maskPath.CGPath;
//    lineview.layer.mask = maskLayer;
//    lineview.userInteractionEnabled = YES;
//    [self.bgimageSmallview addSubview:lineview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(godetail)];
    [self.bgimageSmallview addGestureRecognizer:tap];
    
    
    UIImageView *image = [[UIImageView alloc]init];
    image.userInteractionEnabled = YES;
    image.image = kGetImage(@"ic_public_more");
    [self.bgimageSmallview addSubview:image];
   [image addGestureRecognizer:tap];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgimageSmallview.mas_right).offset(-kRealValue(10));
        make.centerY.equalTo(self.bgimageSmallview.mas_centerY);
        make.width.mas_equalTo(kRealValue(20));
        make.height.mas_equalTo(kRealValue(20));
    }];
//
//    UILabel *label = [[UILabel alloc]init];
//    label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//    label.textColor = [UIColor whiteColor];
//    label.userInteractionEnabled = YES;
//    label.textAlignment = NSTextAlignmentLeft;
//    label.text =@"资料";
//    [self.bgimageSmallview addSubview:label];
//   [label addGestureRecognizer:tap];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(image.mas_left).offset(kRealValue(19));
//        make.centerY.equalTo(self.bgimageSmallview.mas_centerY);
//        make.width.mas_equalTo(kRealValue(40));
//        make.height.mas_equalTo(kRealValue(25));
//    }];
//
//    UIButton *btnmesg = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnmesg setImage:kGetImage(@"ic_news_b") forState:UIControlStateNormal];
//    [btnmesg addTarget:self action:@selector(msgAct) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btnmesg];
//    [btnmesg mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.right.equalTo(self.bgimageSmallview.mas_right).offset(-kRealValue(10));
//        make.top.equalTo(self.bgimageSmallview.mas_top).offset(kRealValue(35));
//        make.width.mas_equalTo(kRealValue(21));
//        make.height.mas_equalTo(kRealValue(21));
//    }];
    
    // line
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(124), kScreenWidth-kRealValue(32), 1/kScreenScale)];
    line.backgroundColor = KColorFromRGB(kThemecolor);
    [self.bgimageSmallview addSubview:line];
   
    
}
-(void)godetail
{
    if (self.GotoUserInfo) {
        self.GotoUserInfo();
    }
}
-(void)msgAct
{
//    if (self.Gotomeg) {
//        self.Gotomeg();
//    }
}
-(UIImageView *)bgimageview
{
    if (!_bgimageview) {
        _bgimageview = [[UIImageView alloc]init];
        _bgimageview.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(125)+kStatusBarHeight);
        _bgimageview.backgroundColor = KColorFromRGB(0xffffff);
//        _bgimageview.image= kGetImage(@"back_shadow_my_head");
        _bgimageview.userInteractionEnabled = YES;
    }
    return _bgimageview;
}
-(UIImageView *)bgimageSmallview
{
    if (!_bgimageSmallview) {
        _bgimageSmallview = [[UIImageView alloc]init];
        _bgimageSmallview.frame = CGRectMake(kRealValue(0), kStatusBarHeight, kScreenWidth,kRealValue(125));
        _bgimageSmallview.userInteractionEnabled = YES;
//        _bgimageSmallview.image= kGetImage(@"back_function_my_head");
    }
    return _bgimageSmallview;
}
-(UIImageView *)headimageview
{
    if (!_headimageview) {
        _headimageview = [[UIImageView alloc]init];
//        _headimageview.backgroundColor = kRandomColor;
    }
    return _headimageview;
}
-(UIImageView *)userleverImage
{
    if (!_userleverImage) {
        _userleverImage = [[UIImageView alloc]init];
//        _userleverImage.backgroundColor = kRandomColor;
    }
    return _userleverImage;
}
-(UILabel *)username
{
    if (!_username) {
        _username = [[UILabel alloc]init];
        _username.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        _username.textColor = KColorFromRGB(0x333333);
        _username.textAlignment = NSTextAlignmentLeft;
        _username.text =@"谁喊痛任凭眼泪一直流";
    }
    return _username;
}
-(UILabel *)userlever
{
    if (!_userlever) {
        _userlever = [[UILabel alloc]init];
        _userlever.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _userlever.textColor =  KColorFromRGB(0x999999);
        _userlever.textAlignment = NSTextAlignmentLeft;
        _userlever.text =@"生活就要学会苦中做乐";
    }
    return _userlever;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
