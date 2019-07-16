//
//  MHLevelSrollCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/17.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHLevelSrollCell.h"

@implementation MHLevelSrollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(10), 0, kRealValue(24), kRealValue(24))];
        _leftIcon.layer.masksToBounds = YES;
        _leftIcon.layer.cornerRadius = kRealValue(12);
        _leftIcon.backgroundColor = kRandomColor;
        [self addSubview:_leftIcon];
        _leftIcon.centerY = kRealValue(25);
        
        _leftTitle = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(55), 0, kRealValue(46), kRealValue(17))];
        _leftTitle.text = @"谁懂我...";
        _leftTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _leftTitle.textColor = [UIColor colorWithRed:255/255.0 green:81/255.0 blue:0/255.0 alpha:1];
        _leftTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_leftTitle];
        _leftTitle.centerY = kRealValue(25);
        
        _descTitle = [[UILabel alloc] init];
        _descTitle.frame = CGRectMake(kRealValue(103), 0, kRealValue(168), kRealValue(34));
        _descTitle.text = @"成功邀请“爱过弃过…”升级为店主";
        _descTitle.numberOfLines = 2;
        _descTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _descTitle.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _descTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_descTitle];
        _descTitle.centerY = kRealValue(25);
        
    
        _rightTitle = [[UILabel alloc] init];
//        _rightTitle.text = @"-500陌币";
        _rightTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _rightTitle.textColor = [UIColor colorWithRed:255/255.0 green:81/255.0 blue:0/255.0 alpha:1];
        _rightTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_rightTitle];
        [_rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(10));
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
        }];
        
    }
    return self;
}


-(void)creatModel:(MHLevelRecordModel *)model{
    [_leftIcon sd_setImageWithURL:[NSURL URLWithString:model.userImage] placeholderImage:kGetImage(@"user_pic")];
    if (model.userNickName.length >= 3) {
        NSString *first = [model.userNickName substringToIndex:1];//字符串开始
        NSString *last = [model.userNickName substringFromIndex:model.userNickName.length-1];//字符串结尾
        _leftTitle.text = [NSString stringWithFormat:@"%@*%@",first,last];
    }else{
         _leftTitle.text = model.userNickName;
    }
  
    if (ValidStr(model.relationUserNickName)) {
        _descTitle.text = [NSString stringWithFormat:@"成功邀请 %@升级为店主",model.relationUserNickName];
        _rightTitle.text = [NSString stringWithFormat:@"+%.0f陌币",model.scoreRecordMoney];
    }else{
        _descTitle.text = @"累计获得佣金奖励";
        _rightTitle.text = [NSString stringWithFormat:@"+%.0f陌币",model.scoreRecordMoney];
    }
   
}

@end
