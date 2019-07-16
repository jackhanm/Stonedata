//
//  ASYouHuiCounDownView.m
//  haochedai
//
//  Created by AllenQin on 2017/3/17.
//  Copyright © 2017年 AllenQin. All rights reserved.
//

#import "CTYouHuiCounDownView.h"

@implementation CTYouHuiCounDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _hourLabel  = [[UILabel alloc] init];
        _hourLabel.text = @"00";
        _hourLabel.backgroundColor = [UIColor whiteColor];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
        _hourLabel.layer.borderWidth = 1;
        _hourLabel.layer.borderColor = [[UIColor colorWithHexString:@"0xd91111"] CGColor];
        _hourLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(9)];
        _hourLabel.textColor = [UIColor redColor];
        [self addSubview:_hourLabel];
        [_hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kRealValue(15), kRealValue(14)));
        }];
        
        _leftColonLabel  = [[UILabel alloc] init];
        _leftColonLabel.text = @":";
        _leftColonLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(9)];
        _leftColonLabel.textColor = [UIColor whiteColor];
        [self addSubview:_leftColonLabel];
        [_leftColonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(_hourLabel.mas_right).with.offset(1);
            
        }];
        
        _minLabel  = [[UILabel alloc] init];
        _minLabel.text = @"00";
        _minLabel.layer.borderWidth = 1;
        _minLabel.layer.borderColor = [[UIColor colorWithHexString:@"0xd91111"] CGColor];
        _minLabel.textAlignment = NSTextAlignmentCenter;
        _minLabel.backgroundColor = [UIColor whiteColor];
        _minLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(9)];
        _minLabel.textColor = [UIColor redColor];
        [self addSubview:_minLabel];
        [_minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(_leftColonLabel.mas_right).with.offset(1);
            make.size.mas_equalTo(CGSizeMake(kRealValue(15),kRealValue(14)));
        }];
        
        _rightColonLabel  = [[UILabel alloc] init];
        _rightColonLabel.text = @":";
        _rightColonLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(9)];
        _rightColonLabel.textColor = [UIColor whiteColor];
        [self addSubview:_rightColonLabel];
        [_rightColonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(_minLabel.mas_right).with.offset(1);
        }];
        
        _secLabel  = [[UILabel alloc] init];
        _secLabel.textAlignment = NSTextAlignmentCenter;
        _secLabel.text = @"00";
        _secLabel.layer.borderWidth = 1;
        _secLabel.layer.borderColor = [[UIColor colorWithHexString:@"0xd91111"] CGColor];
        _secLabel.font = [UIFont systemFontOfSize:kFontValue(9)];
        _secLabel.backgroundColor = [UIColor whiteColor];
        _secLabel.textColor = [UIColor redColor];
        [self addSubview:_secLabel];
        [_secLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(_rightColonLabel.mas_right).with.offset(1);
             make.size.mas_equalTo(CGSizeMake(kRealValue(15), kRealValue(14)));
        }];
        
        
        
    }
    return self;
}



@end
