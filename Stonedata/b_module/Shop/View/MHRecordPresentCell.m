//
//  MHRecordPresentCell.m
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHRecordPresentCell.h"

@implementation MHRecordPresentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    [self addSubview:self.RecordPresentname];
    [self addSubview:self.RecordPresentbank];
    [self addSubview:self.RecordPresentnum];
    [self addSubview:self.RecordPresenttime];
    [self addSubview:self.RecordPresentcardnum];
     [self addSubview:self.RecordPresentstate];
    
    [self.RecordPresentname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(15));
        make.left.equalTo(self.mas_left).offset(kRealValue(15));
        make.width.mas_equalTo(kRealValue(100));
        make.height.mas_equalTo(kRealValue(20));
        
    }];
    
    [self.RecordPresentbank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(15));
        make.left.equalTo(self.RecordPresentname.mas_right).offset(kRealValue(38));
        make.width.mas_equalTo(kRealValue(100));
        make.height.mas_equalTo(kRealValue(20));
        
    }];
    
    [self.RecordPresentnum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(15));
        make.left.equalTo(self.RecordPresentbank.mas_right).offset(kRealValue(0));
        make.right.equalTo(self.mas_right).offset(-kRealValue(13));
        make.height.mas_equalTo(kRealValue(20));
        
    }];
    
    [self.RecordPresenttime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.RecordPresentname.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(self.mas_left).offset(kRealValue(15));
        make.width.mas_equalTo(kRealValue(100));
        make.height.mas_equalTo(kRealValue(20));
        
    }];
    
    [self.RecordPresentcardnum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.RecordPresentname.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(self.RecordPresentname.mas_right).offset(kRealValue(38));
        make.width.mas_equalTo(kRealValue(100));
        make.height.mas_equalTo(kRealValue(20));
        
    }];
    [self.RecordPresentstate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.RecordPresentname.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(self.RecordPresentbank.mas_right).offset(kRealValue(0));
        make.right.equalTo(self.mas_right).offset(-kRealValue(13));
        make.height.mas_equalTo(kRealValue(20));
        
    }];
    
    
    
}
-(UILabel *)RecordPresentname
{
    if (!_RecordPresentname) {
        _RecordPresentname = [[UILabel alloc]init];
        _RecordPresentname.text = @"陌币提现";
        _RecordPresentname.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        _RecordPresentname.textAlignment = NSTextAlignmentLeft;
        _RecordPresentname.textColor = KColorFromRGB(0x000000);
        
    }
    return _RecordPresentname;
}
-(UILabel *)RecordPresentbank
{
    if (!_RecordPresentbank) {
        _RecordPresentbank = [[UILabel alloc]init];
        _RecordPresentbank.text = @"中国银行";
        _RecordPresentbank.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        _RecordPresentbank.textAlignment = NSTextAlignmentLeft;
        _RecordPresentbank.textColor = KColorFromRGB(0x000000);
    }
    return _RecordPresentbank;
}
-(UILabel *)RecordPresentnum
{
    if (!_RecordPresentnum) {
        _RecordPresentnum = [[UILabel alloc]init];
        _RecordPresentnum.text = @"-1234";
        _RecordPresentnum.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        _RecordPresentnum.textAlignment = NSTextAlignmentRight;
        _RecordPresentnum.textColor = KColorFromRGB(0x000000);
    }
    return _RecordPresentnum;
}
-(UILabel *)RecordPresenttime
{
    if (!_RecordPresenttime) {
        _RecordPresenttime = [[UILabel alloc]init];
        _RecordPresenttime.text = @"09-10 19:28";
        _RecordPresenttime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        _RecordPresenttime.textAlignment = NSTextAlignmentLeft;
        _RecordPresenttime.textColor = KColorFromRGB(0x666666);
    }
    return _RecordPresenttime;
}
-(UILabel *)RecordPresentcardnum
{
    if (!_RecordPresentcardnum) {
        _RecordPresentcardnum = [[UILabel alloc]init];
        _RecordPresentcardnum.text = @"188****8888";
        _RecordPresentcardnum.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        _RecordPresentcardnum.textAlignment = NSTextAlignmentLeft;
        _RecordPresentcardnum.textColor = KColorFromRGB(0x666666);
    }
    return _RecordPresentcardnum;
}
-(UILabel *)RecordPresentstate
{
    if (!_RecordPresentstate) {
        _RecordPresentstate = [[UILabel alloc]init];
        _RecordPresentstate.text = @"提现失败";
        _RecordPresentstate.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(15)];
        _RecordPresentstate.textAlignment = NSTextAlignmentRight;
        _RecordPresentstate.textColor = KColorFromRGB(0xFB3131);
    }
    return _RecordPresentstate;
}




@end
