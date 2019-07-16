//
//  MHFansCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHFansCell.h"
#import "MHNewbeeVC.h"

@implementation MHFansCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc]init];
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(16));
        }];
        
        UILabel *line= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kRealValue(343), 1/kScreenScale)];
        line.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [bgView addSubview:line];

        UIImageView *rightView = [[UIImageView alloc] initWithImage:kGetImage(@"leve_desc_arrow")];
        [bgView addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
            make.top.equalTo(bgView.mas_top).with.offset(kRealValue(24));
            make.right.equalTo(bgView.mas_right).with.offset(-kRealValue(10));
        }];
        
        
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.layer.cornerRadius = kRealValue(24.5);
        _leftImageView.layer.masksToBounds = YES;
        //        [_leftImageView setImage:[UIImage imageNamed:@"left_back"]];
        [bgView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(49), kRealValue(49)));
            make.top.equalTo(bgView.mas_top).with.offset(kRealValue(10));
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(10));
        }];
        
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.text = @"没有回头路可以走";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _titleLabel.textColor = [UIColor blackColor];
        [bgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftImageView.mas_top).with.offset(0);
            make.left.equalTo(_leftImageView.mas_right).with.offset(kRealValue(10));
            make.right.equalTo(bgView.mas_right).with.offset(-kRealValue(15));
        }];
        
        
        _smallImageView = [[UIImageView alloc] init];
        [bgView addSubview:_smallImageView];
        [_smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(16), kRealValue(16)));
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(kRealValue(8));
            make.left.equalTo(_leftImageView.mas_right).with.offset(kRealValue(10));
        }];
        
        
        
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _levelLabel.textColor = [UIColor colorWithHexString:@"#FF5100"];
        [bgView addSubview:_levelLabel];
        [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_smallImageView.mas_centerY).with.offset(0);
            make.left.equalTo(_smallImageView.mas_right).with.offset(kRealValue(1));
        }];
        
        
        
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _dataLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [bgView addSubview:_dataLabel];
        [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_smallImageView.mas_centerY).with.offset(0);
            make.left.equalTo(_levelLabel.mas_right).with.offset(kRealValue(8));
        }];
        
        _footLabel = [[UILabel alloc] init];
        _footLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _footLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        [bgView addSubview:_footLabel];
        _footLabel.text = @"建议：分享新人专享好货，引导首单成交";
        [_footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftImageView.mas_bottom).with.offset(kRealValue(5));
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(10));
        }];
        
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-kRealValue(86), kRealValue(59), kRealValue(44), kRealValue(22))];
        [_selectBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(44), kRealValue(22))] forState:UIControlStateNormal];
        [_selectBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_selectBtn addTarget: self action:@selector(pushLevel) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        [bgView addSubview:_selectBtn];
          ViewRadius(_selectBtn, 5);
        _selectBtn.hidden = YES;
        _footLabel.hidden = YES;
        
    }
    return self;
}


- (void)pushLevel{
    
    MHNewbeeVC *vc = [[MHNewbeeVC alloc] init];
    [self.cellVC.navigationController pushViewController:vc animated:YES];
    
}

-(void)createModel:(MHShopFansModel *)model{
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.userImage] placeholderImage:kGetImage(@"user_pic")];
    _titleLabel.text =  model.userNickName;
    _selectBtn.hidden = YES;
    _footLabel.hidden = YES;
    if (model.userRole == 0) {
        _levelLabel.text = @"内部员工";
        _smallImageView.image = kGetImage(@"ic_store_member_white");
    }else if (model.userRole == 1){
        _levelLabel.text = @"普通会员";
        _smallImageView.image  = kGetImage(@"ic_store_member_white");
        _selectBtn.hidden = NO;
        _footLabel.hidden = NO;


    }else if (model.userRole == 2){
        _levelLabel.text = @"店主";
        _smallImageView.image  = kGetImage(@"ic_store_store_white");
    }else if (model.userRole == 3){
        _levelLabel.text = @"掌柜子";
        _smallImageView.image  = kGetImage(@"ic_data_manager_white");

    }else if (model.userRole == 4){
        _levelLabel.text = @"分舵主";
        _smallImageView.image  = kGetImage(@"ic_data_rudder_white");
    }
    _dataLabel.text = model.userTime;
}

@end
