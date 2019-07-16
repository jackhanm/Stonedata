

//
//  MHProductDetailCellHeadTwo.m
//  mohu
//
//  Created by yuhao on 2018/10/19.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHProductDetailCellHeadTwo.h"

@implementation MHProductDetailCellHeadTwo
-(instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title rightTitle:(NSString *)rightTitle isShowRight:(BOOL)isShow
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.backgroundColor = [UIColor whiteColor];
        if (isShow) {
            UIImageView *rightIcon = [[UIImageView alloc]init];
            rightIcon.image = kGetImage(@"ic_public_more");
            [self addSubview:rightIcon];
            [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-16);
                make.centerY.equalTo(self.mas_centerY);
                make.width.mas_equalTo(kRealValue(22));
                make.height.mas_equalTo(kRealValue(22));
            }];
            self.RightitleLabel = [[UILabel alloc]init];
            self.RightitleLabel.textAlignment = NSTextAlignmentRight;
            self.RightitleLabel.textColor = KColorFromRGB(0x666666);
            self.RightitleLabel.text = rightTitle;
            self.RightitleLabel.font = [UIFont fontWithName:kPingFangRegular size:13];
            [self addSubview:self.RightitleLabel];
            [self.RightitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-36);
                make.centerY.equalTo(self.mas_centerY);
            }];
            self.titleLabel = [[UILabel alloc]init];
            self.titleLabel.textAlignment = NSTextAlignmentRight;
            self.titleLabel.textColor = KColorFromRGB(0x000000);
            self.titleLabel.text = title;
            self.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:14];
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(16);
                make.centerY.equalTo(self.mas_centerY);
            }];
            
            
        }else{
            self.RightitleLabel = [[UILabel alloc]init];
            self.RightitleLabel.textAlignment = NSTextAlignmentRight;
            self.RightitleLabel.textColor = KColorFromRGB(0x666666);
            self.RightitleLabel.text = rightTitle;
            self.RightitleLabel.font = [UIFont fontWithName:kPingFangRegular size:13];
            [self addSubview:self.RightitleLabel];
            [self.RightitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-16);
                make.centerY.equalTo(self.mas_centerY);
            }];
            self.titleLabel = [[UILabel alloc]init];
            self.titleLabel.textAlignment = NSTextAlignmentRight;
            self.titleLabel.textColor = KColorFromRGB(0x000000);
            self.titleLabel.text = title;
            self.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:14];
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(16);
                make.centerY.equalTo(self.mas_centerY);
            }];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAct)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
-(void)tapAct
{
    if (self.selectact) {
        self.selectact(@"", @"");
    }
}

@end
