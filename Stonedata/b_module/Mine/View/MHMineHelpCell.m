

//
//  MHMineHelpCell.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineHelpCell.h"
#import "MHMineitemViewTwo.h"
@implementation MHMineHelpCell
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
    self.bgview = [[UIView alloc] init];
    self.bgview.frame = CGRectMake(kRealValue(0),kRealValue(10),kScreenWidth,kRealValue(100));
    self.bgview.backgroundColor= [UIColor whiteColor];
    self.bgview.userInteractionEnabled = YES;
    self.bgview.layer.cornerRadius = kRealValue(6);
    [self.bgimageview addSubview:self.bgview];
    MHMineitemViewTwo * view = [[MHMineitemViewTwo alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(50)) title:@"设置" subtitle:@"解答您的疑难问题" imageStr:@"ic_my_help" righttitle:@"" isline:YES isRighttitle:NO];
    [self.bgview addSubview:view];
    MHMineitemViewTwo * view1 = [[MHMineitemViewTwo alloc]initWithFrame:CGRectMake(0, kRealValue(50), kScreenWidth, kRealValue(50)) title:@"关于我们" subtitle:@"解答您的疑难问题" imageStr:@"ic_my_help" righttitle:@"" isline:NO isRighttitle:NO];
    [self.bgview addSubview:view1];

    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(helpAct)];
    [view addGestureRecognizer:tap];
    
    
}
-(void)helpAct
{
    if (self.HelpCenter) {
        self.HelpCenter();
    }
}
-(UIImageView *)bgimageview
{
    if (!_bgimageview) {
        _bgimageview = [[UIImageView alloc]init];
        _bgimageview.userInteractionEnabled = YES;
        _bgimageview.backgroundColor = KColorFromRGB(0xF1F2F1);
        _bgimageview.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(53));
//        _bgimageview.image= kGetImage(@"back_shadow_my_function_tail");
    }
    return _bgimageview;
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
