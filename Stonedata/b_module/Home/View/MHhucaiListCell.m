


//
//  MHhucaiListCell.m
//  mohu
//
//  Created by yuhao on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHhucaiListCell.h"

@implementation MHhucaiListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    [self addSubview:self.headimage];
    [self addSubview:self.username];
    [self addSubview:self.acttime];
    [self addSubview:self.actprice];
    
    [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(10));
        make.width.height.mas_equalTo(kRealValue(38));
        make.left.equalTo(self.mas_left).offset(kRealValue(15));
    }];
    self.headimage.layer.masksToBounds = YES;
    self.headimage.layer.cornerRadius = kRealValue(19);
    
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(10));
        make.left.equalTo(self.headimage.mas_right).offset(kRealValue(10));
    }];
    [self.acttime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.username.mas_bottom).offset(kRealValue(4));
        make.left.equalTo(self.headimage.mas_right).offset(kRealValue(10));
    }];
    [self.actprice mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.mas_top).offset(kRealValue(20));
        make.right.equalTo(self.mas_right).offset(kRealValue(-10));
    }];
    
}
-(UIImageView *)headimage
{
    if (!_headimage) {
        _headimage = [[UIImageView alloc]init];
        _headimage.backgroundColor =kRandomColor;
    }
    return _headimage;
}
-(UILabel *)username
{
    if (!_username) {
        
        _username = [[UILabel alloc]init];
        _username.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        _username.textColor =[UIColor colorWithHexString:@"000000"];
        _username.numberOfLines =1;
        _username.text =@"长情****不仄言";
        //        _titleLabel.backgroundColor =kRandomColor;
    }
    return _username;
}
-(UILabel *)acttime
{
    if (!_acttime) {
        
        _acttime = [[UILabel alloc]init];
        _acttime.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(11)];
        _acttime.textColor =[UIColor colorWithHexString:@"666666"];
        _acttime.numberOfLines =1;
        _acttime.text =@"07/29 08:53";
        //        _titleLabel.backgroundColor =kRandomColor;
    }
    return _acttime;
}
-(UILabel *)actprice
{
    if (!_actprice) {
        
        _actprice = [[UILabel alloc]init];
        _actprice.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        _actprice.textColor =[UIColor colorWithHexString:@"F73315"];
        _actprice.numberOfLines =1;
        _actprice.text =@"已竞中 ¥56";
        //        _titleLabel.backgroundColor =kRandomColor;
    }
    return _actprice;
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
