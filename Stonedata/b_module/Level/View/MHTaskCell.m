//
//  MHTaskCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHTaskCell.h"

@implementation MHTaskCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16),0, kRealValue(343), kRealValue(44))];
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
        bgView.layer.cornerRadius = kRealValue(5);
        [self addSubview:bgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kRealValue(240), kRealValue(44))];
        _titleLabel.text = @"邀请1人成为店主+300陌币";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_titleLabel];
        
        _titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(273), 0, kRealValue(60), kRealValue(24))];
        _titleBtn.userInteractionEnabled = NO;
        [_titleBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(60), kRealValue(24))] forState:UIControlStateNormal];
        [_titleBtn setTitle:@"去邀请" forState:UIControlStateNormal];
        _titleBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
         [bgView addSubview:_titleBtn];
         ViewRadius(_titleBtn, 5);
        _titleBtn.centerY = bgView.centerY;
        
        
        
    }
    return self;
}


@end
