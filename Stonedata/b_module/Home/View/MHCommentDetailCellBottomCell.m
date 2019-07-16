//
//  MHCommentDetailCellBottomCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHCommentDetailCellBottomCell.h"

@implementation MHCommentDetailCellBottomCell
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
    UIView *linebg1 =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1/kScreenScale)];
    linebg1.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [self addSubview:linebg1];
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = KColorFromRGB(0x666666);
    self.titleLabel.userInteractionEnabled = YES;
    self.titleLabel.text = @"查看全部评价";
    self.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(-5));
        make.width.mas_equalTo(kRealValue(113));
        make.height.mas_equalTo(kRealValue(29));
    }];
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.cornerRadius =kRealValue(29/2);
    self.titleLabel.backgroundColor = KColorFromRGB(0xF0F1F0);
    
//    UIImageView *rightIcon = [[UIImageView alloc]init];
//    rightIcon.image = kGetImage(@"ic_public_more");
//    [self addSubview:rightIcon];
//    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabel.mas_right).offset(-10);
//        make.centerY.equalTo(self.mas_centerY).offset(kRealValue(-5));
//        make.width.mas_equalTo(kRealValue(22));
//        make.height.mas_equalTo(kRealValue(22));
//    }];
    UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(49), kScreenWidth, 1/kScreenScale)];
    linebg2.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [self addSubview:linebg2];
    UIView *linebg =  [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(50), kScreenWidth, kRealValue(10))];
    linebg.backgroundColor = KColorFromRGB(0xF0F1F4);
    [self addSubview:linebg];
    
    UITapGestureRecognizer *seeAllcomment = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeAllcommentAct)];
    [self.titleLabel addGestureRecognizer:seeAllcomment];
    
}
-(void)seeAllcommentAct
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationSeeAllComment object:nil];
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
