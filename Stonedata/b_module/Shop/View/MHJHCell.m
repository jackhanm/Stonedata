//
//  MHJHCell.m
//  mohu
//
//  Created by AllenQin on 2019/1/10.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHJHCell.h"

@implementation MHJHCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16),0, kRealValue(343), kRealValue(60))];
        bgView.userInteractionEnabled = YES;
//        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
//        bgView.layer.cornerRadius = kRealValue(5);
        [self addSubview:bgView];
        
        
        _leftImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(16), 0, kRealValue(32), kRealValue(32))];
        _leftImageView.layer.cornerRadius = kRealValue(2);
        _leftImageView.layer.masksToBounds = YES;
        [bgView addSubview:_leftImageView];
        _leftImageView.backgroundColor = kRandomColor;
        _leftImageView.centerY =  bgView.centerY;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(57), kRealValue(12), kRealValue(240), kRealValue(17))];
        _titleLabel.text = @"邀请1人成为店主+300陌币";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_titleLabel];
        
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(57), kRealValue(33), kRealValue(240), kRealValue(17))];
        _descLabel.text = @"+300陌币";
        _descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _descLabel.textColor = [UIColor colorWithHexString:@"#fe5d00"];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:_descLabel];
        
        
        
        _titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(273), 0, kRealValue(60), kRealValue(24))];
        [_titleBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(60), kRealValue(24))] forState:UIControlStateNormal];
        [_titleBtn addTarget: self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#d4d4d4"]] forState:UIControlStateDisabled];
        [_titleBtn setTitle:@"确认激活" forState:UIControlStateNormal];
        [_titleBtn setTitle:@"已激活" forState:UIControlStateDisabled];
        
        _titleBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        [bgView addSubview:_titleBtn];
        ViewRadius(_titleBtn, 5);
        _titleBtn.centerY = bgView.centerY;
        
        
        
    }
    return self;
}


-(void)titleClick:(UIButton *)sender{
    //点击激活
    [[MHUserService sharedInstance]initwithJihuoIntegralId:[NSString stringWithFormat:@"%ld",_jfModel.integralId] userId:[NSString stringWithFormat:@"%ld",_jfModel.userId] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.jfModel.integralRecordType = @"EXPENSE";
            sender.enabled = NO;
        }
    }];
}


- (void)setJfModel:(MHJFModel *)jfModel{
    _jfModel  = jfModel;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:jfModel.userImage] placeholderImage:kGetImage(@"user_pic")];
    _titleLabel.text = [NSString stringWithFormat:@"%@邀请您帮忙激活",jfModel.userNickName];
    _descLabel.text = [NSString stringWithFormat:@"%@积分",jfModel.integralMoney];
    if ([jfModel.integralRecordType isEqualToString:@"EXPENSE"]) {
        _titleBtn.enabled = NO;
    }else{
        _titleBtn.enabled = YES;
    }
}


@end
