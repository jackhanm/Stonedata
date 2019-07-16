//
//  MHHeadNavView.m
//  mohu
//
//  Created by 余浩 on 2018/9/19.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHHeadNavView.h"

@implementation MHHeadNavView
-(instancetype)initWithFrame:(CGRect)frame height:(NSInteger)height title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self createviewWithheight:height title:title];
    }
    return self;
}
-(void)createviewWithheight:(NSInteger)height title:(NSString *)title
{
  
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];//该透明色设置不会影响子视图
    //添加返回按钮
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backButton setImage:[UIImage imageNamed:@"left_back"] forState:(UIControlStateNormal)];
    backButton.frame = CGRectMake(5, 25 + kTopHeight - 64, 33, 33);
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:backButton];
    
    
    self.rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightButton setImage:[UIImage imageNamed:@"ic_share_grey"] forState:(UIControlStateNormal)];
    self.rightButton.frame = CGRectMake(kScreenWidth -39, 25 + kTopHeight - 64, 33, 33);
    self.rightButton.adjustsImageWhenHighlighted = NO;
    self.rightButton.hidden =YES;
    [self.rightButton addTarget:self action:@selector(shareAct) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.rightButton];
    
    _titleLabel= [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont fontWithName:kPingFangMedium size:16];
    _titleLabel.textColor = [UIColor colorWithHexString:@"000000" andAlpha:0];
    _titleLabel.text = @"限时抢购";
    _titleLabel.frame = CGRectMake(5, 25 + kTopHeight - 64, kScreenWidth/1.5, 25);
    _titleLabel.centerX = self.centerX;
    _titleLabel.centerY = backButton.centerY;
    [self addSubview:_titleLabel];
}
-(void)backBtnClicked
{
    if (self.backblock) {
        self.backblock(@"");
    }
}
-(void)shareAct
{
    if (self.goshareblock) {
        self.goshareblock(@"");
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
