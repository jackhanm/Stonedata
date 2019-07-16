

//
//  MHMineuserInfoCommonViewSecond.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineuserInfoCommonViewSecond.h"

@implementation MHMineuserInfoCommonViewSecond

-(id)initWithFrame:(CGRect)frame  lefttitle:(NSString *)lefttitle righttitle:(NSString *)righttitle rightSubtitle:(NSString *)rightSubtitle istopLine:(BOOL)isTopline isBottonLine:(BOOL)isbottomLine
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.title];
        [self addSubview:self.righttitle];
        
        self.title.text = lefttitle;
        self.righttitle.text = righttitle;
        self.rightSubtitle.text = rightSubtitle;
        
        self.smallline = [[UIView alloc]init];
        self.smallline.backgroundColor = KColorFromRGB(0x999999);
        [self addSubview:self.smallline];
        [self addSubview:self.rightSubtitle];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(kRealValue(15));
            make.width.mas_equalTo(kRealValue(100));
            make.height.mas_equalTo(kRealValue(20));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [self.righttitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(kRealValue(-16));
            make.centerY.equalTo(self.mas_centerY);
//            make.width.mas_equalTo(kRealValue(40));
            make.height.mas_equalTo(kRealValue(25));
        }];
        [self.smallline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.righttitle.mas_left).offset(kRealValue(-5));
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(kRealValue(1));
            make.height.mas_equalTo(kRealValue(10));
        }];
        [self.rightSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.smallline.mas_left).offset(kRealValue(-5));
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(kRealValue(25));
        }];
        UIView *linetop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1/kScreenScale)];
        linetop.backgroundColor = KColorFromRGB(0xe0e0e0);
        [self addSubview:linetop];
        
        UIView *linebottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1/kScreenScale, kScreenWidth, 1/kScreenScale)];
        linebottom.backgroundColor = KColorFromRGB(0xe0e0e0);
        [self addSubview:linebottom];
        
        
        if (isTopline == NO ) {
            linetop.hidden =YES;
        }
        if (isbottomLine == NO) {
            linebottom.hidden = YES;
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
-(UILabel *)righttitle
{
    if (!_righttitle) {
        _righttitle = [[UILabel alloc]init];
        _righttitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _righttitle.textColor = KColorFromRGB(0x689DFF);
        _righttitle.userInteractionEnabled =YES;
        _righttitle.textAlignment = NSTextAlignmentRight;
    }
    return _righttitle;
}
-(UILabel *)rightSubtitle
{
    if (!_rightSubtitle) {
        _rightSubtitle = [[UILabel alloc]init];
         _rightSubtitle.userInteractionEnabled =YES;
        _rightSubtitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _rightSubtitle.textColor = KColorFromRGB(0x666666);
        _rightSubtitle.textAlignment = NSTextAlignmentRight;
    }
    return _rightSubtitle;
}

@end
