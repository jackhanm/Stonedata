//
//  MHAddWithDrawyzmCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAddWithDrawyzmCell.h"

@implementation MHAddWithDrawyzmCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"验 证 码";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(16));
        }];
        
        _numberTextField = [UITextField new];
        _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _numberTextField.placeholder = @"请输入验证码";
        [_numberTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(13)]];
        [self.contentView addSubview:_numberTextField];
        [_numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(44));
            make.left.equalTo(self.contentView.mas_left).offset(kRealValue(100));
            make.right.equalTo(self.contentView.mas_right).offset(-kRealValue(101));
            make.top.equalTo(self.contentView.mas_top).offset(0);
        }];
        
        //发送验证码
        _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        _countDownCode.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        [_countDownCode setTitleColor:[UIColor colorWithHexString:@"689DFF"] forState:UIControlStateNormal];
        [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.contentView  addSubview:_countDownCode];
        [_countDownCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(44));
            make.left.equalTo(_numberTextField.mas_right).offset(0);
            make.width.mas_equalTo(kRealValue(80));
            make.top.equalTo(self.contentView.mas_top).offset(0);
        }];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(44) , kScreenWidth,1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [self.contentView addSubview:lineView];

        
        
    }
    return self;
}

@end
