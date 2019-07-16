//
//  MHSearchUserListCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/26.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHSearchUserListCell.h"

@implementation MHSearchUserListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = kRealValue(25);
        //        [_leftImageView setImage:[UIImage imageNamed:@"left_back"]];
        [self.contentView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(16));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"优惠券";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftImageView.mas_top).with.offset(0);
            make.left.equalTo(_leftImageView.mas_right).with.offset(kRealValue(10));
            make.width.mas_equalTo(kRealValue(180));
        }];
        
        _footLabel= [[UILabel alloc] init];
//        _footLabel.text = @"已优惠80元&每日分享可获优惠券";
        _footLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _footLabel.textColor = [UIColor colorWithHexString:@"666666"];
        [self.contentView addSubview:_footLabel];
        [_footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-kRealValue(15));
            make.left.equalTo(_leftImageView.mas_right).with.offset(kRealValue(10));
        }];
        
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(95), 0, kRealValue(76), kRealValue(25))];
        _selectBtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        ViewBorderRadius(_selectBtn, 3, 1/kScreenScale, [UIColor colorWithHexString:@"ff5300"]);
        _selectBtn.userInteractionEnabled = NO;
        [_selectBtn setTitleColor:[UIColor colorWithHexString:@"ff5300"] forState:UIControlStateNormal];
//        [_selectBtn setImage:[UIImage imageNamed:@"level_arrow"] forState:UIControlStateNormal];
        [_selectBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
//        [_selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _selectBtn.imageView.image.size.width +kRealValue(10), 0, _selectBtn.imageView.image.size.width)];
//        [_selectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _selectBtn.titleLabel.bounds.size.width-kRealValue(10), 0, -_selectBtn.titleLabel.bounds.size.width+kRealValue(0))];
//        [_selectBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(70), kRealValue(24))] forState:UIControlStateNormal];
        [self addSubview:_selectBtn];
        _selectBtn.centerY = kRealValue(34.5);

        ViewRadius(self.selectBtn, kRealValue(3));
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16), kRealValue(68), kScreenWidth - kRealValue(111), 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [self addSubview:lineView];

    }
    return self;
}

-(void)setUserListModel:(MHUserListModel *)userListModel{
    _userListModel = userListModel;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:userListModel.shopAvatar] placeholderImage:kGetImage(@"user_pic")];
    _titleLabel.text = _userListModel.shopName;
    _footLabel.text = [NSString stringWithFormat:@"%@个粉丝",_userListModel.fansCount];
    
}
@end
