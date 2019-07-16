//
//  MHMineitemView.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineitemView.h"

@implementation MHMineitemView
-(id)initWithFrame:(CGRect)frame title:(NSString *)title subtitle:(NSString *)subtitle imageStr:(NSString *)imageStr righttitle:(NSString *)righttitle
            isline:(BOOL)isline isRighttitle:(BOOL)isRight
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftIcon];
        [self addSubview:self.title];
        [self addSubview:self.subtitle];
        [self addSubview:self.rightIcon];
        [self addSubview:self.righttitle];
      
        
        self.leftIcon.image = kGetImage(imageStr);
        self.title.text = title;
        self.subtitle.text = subtitle;
        self.righttitle.text = righttitle;
        
        [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.width.mas_equalTo(kRealValue(40));
            make.height.mas_equalTo(kRealValue(40));
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftIcon.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.width.mas_equalTo(kRealValue(180));
            make.height.mas_equalTo(kRealValue(20));
        }];
        [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftIcon.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(33);
            make.width.mas_equalTo(kRealValue(180));
            make.height.mas_equalTo(kRealValue(20));
        }];
        [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(kRealValue(-10));
             make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(kRealValue(20));
            make.height.mas_equalTo(kRealValue(20));
        }];
        [self.righttitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightIcon.mas_left).offset(kRealValue(8));
             make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(kRealValue(60));
            make.height.mas_equalTo(kRealValue(20));
        }];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(60),self.frame.size.height-1, self.frame.size.width - kRealValue(60), 1/kScreenScale)];
        view.backgroundColor = KColorFromRGB(0xf0f0f0);
        [self addSubview:view];
        
        if (isline == NO) {
            view.hidden =YES;
        }
        if (isRight == NO) {
            self.righttitle.hidden =YES;
        }
        
        
    }
    return self;
}
-(UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}
-(UILabel *)subtitle
{
    if (!_subtitle) {
        _subtitle = [[UILabel alloc]init];
        _subtitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _subtitle.textColor = KColorFromRGB(0x999999);
        _subtitle.textAlignment = NSTextAlignmentLeft;
    }
    return _subtitle;
}
-(UILabel *)righttitle
{
    if (!_righttitle) {
        _righttitle = [[UILabel alloc]init];
        _righttitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _righttitle.textColor = KColorFromRGB(0xFB3131);
        _righttitle.textAlignment = NSTextAlignmentRight;
    }
    return _righttitle;
}
-(UIImageView *)leftIcon
{
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc]init];
//        _leftIcon.backgroundColor = kRandomColor;
    }
    return _leftIcon;
}
-(UIImageView *)rightIcon
{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]init];
        _rightIcon.image= kGetImage(@"ic_public_more");
    }
    return _rightIcon;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
