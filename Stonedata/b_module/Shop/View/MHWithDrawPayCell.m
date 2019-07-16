//
//  MHWithDrawPayCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHWithDrawPayCell.h"

@implementation MHWithDrawPayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), 0, kScreenWidth - kRealValue(32), kRealValue(64))];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = kRealValue(3);
        [self.contentView addSubview:bgView];
        
        _leftImageView = [[UIImageView alloc] init];
        [bgView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(40), kRealValue(40)));
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(16));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"优惠券";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _titleLabel.textColor = [UIColor blackColor];
        [bgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).with.offset(kRealValue(8));
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(70));
        }];
        
        _footLabel= [[UILabel alloc] init];
//        _footLabel.text = @"已优惠80元&每日分享可获优惠券";
        _footLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _footLabel.textColor = [UIColor colorWithHexString:@"666666"];
        [bgView addSubview:_footLabel];
        [_footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bgView.mas_bottom).with.offset(-kRealValue(8));
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(70));
        }];
        
        _selectBtn = [[UIButton alloc] init];
        _selectBtn.userInteractionEnabled = NO;
        [_selectBtn setImage:kGetImage(@"ic_choice_unselect_border") forState:UIControlStateNormal];
        [_selectBtn setImage:kGetImage(@"ic_choice_select") forState:UIControlStateSelected];
        _selectBtn.selected = NO;
        [bgView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(55), kRealValue(55)));
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.right.equalTo(bgView.mas_right).with.offset(0);
        }];
        
        _editBtn = [[UIButton alloc]init];
        [_editBtn setImage:kGetImage(@"addwithDraw_dele") forState:UIControlStateNormal];
        [bgView addSubview:_editBtn];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
            make.right.equalTo(bgView.mas_right).with.offset(0);
        }];
    }
    return self;
}

-(void)createModel:(MHWithDrawListModel *)model{
    
    _footLabel.text =  model.cardCode;
    if (model.withdrawType == 1) {
        _titleLabel.text = @"支付宝";
        _leftImageView.image = kGetImage(@"ic_play_play");
    }else{
        _titleLabel.text = model.bankName;
        _leftImageView.image = kGetImage(@"ic_play_unionPay");
    }
    
}

@end
