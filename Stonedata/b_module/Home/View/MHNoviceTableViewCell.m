//
//  MHNoviceTableViewCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHNoviceTableViewCell.h"

@implementation MHNoviceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(110), kRealValue(110)));
            make.top.equalTo(self.contentView.mas_top).with.offset(kRealValue(10));
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(10));
        }];
        
        _titlesLabel = [[UILabel alloc]init];
        _titlesLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
        _titlesLabel.textColor =[UIColor colorWithHexString:@"000000"];
        _titlesLabel.text  = @"美妆蛋beautyblender化妆海绵";
        _titlesLabel.numberOfLines = 1;
        [self.contentView addSubview:_titlesLabel];
        [_titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(kRealValue(9));
            make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
            make.width.mas_equalTo(kRealValue(235));
        }];
        
        _saleLabel = [[UILabel alloc]init];
        _saleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _saleLabel.textColor =[UIColor colorWithHexString:@"999999"];
        _saleLabel.text  = @"已的是111";
        [self.contentView addSubview:_saleLabel];
        [_saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titlesLabel.mas_bottom).with.offset(kRealValue(11));
            make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
        }];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        _priceLabel.textColor =[UIColor colorWithHexString:@"FB3131"];
        _priceLabel.text  = @"¥488";
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(kRealValue(3));
            make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
        }];
        
        _originalPriceLabel = [[UILabel alloc]init];
        

        _originalPriceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _originalPriceLabel.textColor =[UIColor colorWithHexString:@"666666"];
        [self.contentView addSubview:_originalPriceLabel];
        [_originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(0);
            make.left.equalTo(self.priceLabel.mas_right).with.offset(kRealValue(6));
        }];
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"¥233" attributes:attribtDic];
        _originalPriceLabel.attributedText = attribtStr;
        
        _goButton = [[UIButton alloc] init];
        [_goButton setBackgroundImage:[UIImage imageNamed:@"novice_go_button"] forState:UIControlStateNormal];
        [self.contentView addSubview:_goButton];
        [_goButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(kRealValue(7));
            make.right.equalTo(self.contentView.mas_right).with.offset(-kRealValue(3));
            make.size.mas_equalTo(CGSizeMake(kRealValue(100), kRealValue(40)));
        }];
        
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(130)-1/kScreenScale, kScreenWidth, 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"E0E0E0"];
        [self.contentView addSubview:lineView];

    }
    
    return self;
}


@end
