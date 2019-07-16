//
//  MHWithDrawTitleCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHWithDrawTitleCell.h"

@implementation MHWithDrawTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), 0, kScreenWidth - kRealValue(32), kRealValue(49))];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = kRealValue(3);
        [self.contentView addSubview:bgView];
        
        UILabel *titlesLabel = [[UILabel alloc]init];
        titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        titlesLabel.textColor =[UIColor colorWithHexString:@"000000"];
        titlesLabel.text  = @"可提现资产";
        [bgView addSubview:titlesLabel];
        [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(15));
        }];
//
       UILabel *mobiLabel = [[UILabel alloc]init];
        mobiLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        mobiLabel.textColor =[UIColor colorWithHexString:@"0000000"];
        mobiLabel.textAlignment = NSTextAlignmentRight;
        mobiLabel.text  = @"陌币";
        [bgView addSubview:mobiLabel];
        [mobiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView.mas_right).with.offset(-kRealValue(15));
            make.bottom.equalTo(bgView.mas_bottom).with.offset(-kRealValue(12));
        }];

        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"000000"];
        _moneyLabel.text  = @"134";
        _moneyLabel.numberOfLines = 1;
        [bgView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(kRealValue(4));
            make.right.equalTo(mobiLabel.mas_left).with.offset(-kRealValue(3));
        }];

        UILabel *stateLabel = [[UILabel alloc]init];
        stateLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        stateLabel.textColor =[UIColor colorWithHexString:@"000000"];
        stateLabel.text  = @"陌币比例：1陌币=1元";
        stateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:stateLabel];
        [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_bottom).with.offset(kRealValue(8));
            make.right.equalTo(bgView.mas_right).with.offset(0);
        }];
        
        
    }
    
    return self;
}
@end
