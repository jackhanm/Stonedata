//
//  MHProductDescbottomView.m
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProductDescbottomView.h"

@implementation MHProductDescbottomView

-(instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title rightTitle:(NSString *)rightTitle isShowRight:(BOOL)isShow
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *linebg1 =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(1))];
        linebg1.backgroundColor = KColorFromRGB(0xE0E0E0);
        [self addSubview:linebg1];
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.textColor = KColorFromRGB(0x666666);
        self.titleLabel.text = @"上拉查看图文详情";
        self.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(kRealValue(-0));
        }];
        UIImageView *rightIcon = [[UIImageView alloc]init];
        rightIcon.image = kGetImage(@"ic_public_up");
        [self addSubview:rightIcon];
        [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleLabel.mas_left).offset(-10);
            make.centerY.equalTo(self.mas_centerY).offset(kRealValue(-0));
            make.width.mas_equalTo(kRealValue(22));
            make.height.mas_equalTo(kRealValue(22));
        }];
//        UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(49), kScreenWidth, kRealValue(1))];
//        linebg2.backgroundColor = KColorFromRGB(0xE0E0E0);
//        [self addSubview:linebg2];
//        UIView *linebg =  [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(50), kScreenWidth, kRealValue(10))];
//        linebg.backgroundColor = KColorFromRGB(0xF0F1F4);
//        [self addSubview:linebg];
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
