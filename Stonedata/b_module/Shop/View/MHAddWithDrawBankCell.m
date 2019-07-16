//
//  MHAddWithDrawBankCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAddWithDrawBankCell.h"

@implementation MHAddWithDrawBankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"所 属 银 行";
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).with.offset(kRealValue(16));
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"请选择";
        _contentLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#B0B0B0"];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(kRealValue(100));
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.height.mas_equalTo(kRealValue(44));
        }];
        _contentLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seletIndex)];
        [_contentLabel addGestureRecognizer:tap];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(44) , kScreenWidth,1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [self.contentView addSubview:lineView];
        
        
    }
    return self;
}

-(void)seletIndex{
    
    if (self.selectClick) {
        self.selectClick();
    }

}

@end
