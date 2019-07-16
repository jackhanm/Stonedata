//
//  MHProductDetailDesCell.m
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProductDetailDesCell.h"
#import "MHProductDescbottomView.h"
@implementation MHProductDetailDesCell
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
//    UILabel *label1 = [[UILabel alloc]init];
//    label1.text = @"商品简介";
//    label1.textColor = KColorFromRGB(0x000000);
//    label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
//    [self addSubview:label1];
//
//
//    UILabel *labeltitle1 = [[UILabel alloc]init];
//    labeltitle1.text = @"简 介";
//    labeltitle1.textColor = KColorFromRGB(0x000000);
//    labeltitle1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//    [self addSubview:labeltitle1];
//
//
//    self.labeldetail1 = [[UILabel alloc]init];
//    self.labeldetail1.text = @"蕴藏在圆形瓶身中的花果香调香水。柔美、温婉的开瓶香气引领你沉醉于幸福与幸运的环绕中。一场嗅觉的香氛邂逅。";
//    self.labeldetail1.textColor = KColorFromRGB(0x000000);
//    self.labeldetail1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//    [self addSubview:self.labeldetail1];
//
//    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(16);
//        make.top.equalTo(self.mas_top).offset(15);
//    }];
//
//    [labeltitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(16);
//        make.top.equalTo(label1.mas_bottom).offset(10);
//        make.width.mas_equalTo(60);
//    }];
//    self.labeldetail1.numberOfLines = 0;
//    [self.labeldetail1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(labeltitle1.mas_right).offset(19);
//        make.top.equalTo(label1.mas_bottom).offset(10);
//         make.right.equalTo(self.mas_right).offset(-16);
//    }];
    
   self.bottomView = [[MHProductDescbottomView alloc]initWithFrame:CGRectMake(0, kFontValue(0), kScreenWidth, 50) title:@"上拉查看图文详情" rightTitle:@"" isShowRight:NO];
    [self addSubview:self.self.bottomView ];
    
    
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
