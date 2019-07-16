//
//  MHAssestCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/30.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAssestCell.h"

@implementation MHAssestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(16), 0,kScreenWidth - kRealValue(32) , kRealValue(58))];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.frame = CGRectMake(kRealValue(10), kRealValue(31), kRealValue(85), kRealValue(17));
        _dataLabel.text = @"2022/08/20";
        _dataLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _dataLabel.textColor = [UIColor colorWithHexString:@"#6E6E6E"];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:_dataLabel];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.frame = CGRectMake(kRealValue(10), kRealValue(11), kRealValue(85), kRealValue(17));
        _timeLabel.text = @"08:20";
        _timeLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:_timeLabel];
        
        
//        _titlesLabel = [[UILabel alloc] init];
//        _titlesLabel.frame = CGRectMake(kRealValue(100),kRealValue(21),kRealValue(160),kRealValue(40));
//        _titlesLabel.text = @"恭喜您升级为店主恭喜您升级为店主恭喜您升级为店主恭喜";
//        _titlesLabel.numberOfLines = 2;
//        _titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
//        _titlesLabel.textColor = [UIColor colorWithHexString:@"#000000"];
//        _titlesLabel.textAlignment = NSTextAlignmentLeft;
//        [_bgView addSubview:_titlesLabel];
      
        

        _titlesLabel = [[YYLabel alloc]initWithFrame:CGRectMake(kRealValue(100), 0, kRealValue(160), kRealValue(40))];
        _titlesLabel.numberOfLines = 2;
        _titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _titlesLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _titlesLabel.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_titlesLabel];
        _titlesLabel.centerY = kRealValue(29);
       
        
        
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.frame = CGRectMake(kRealValue(237),kRealValue(10),kRealValue(96),kRealValue(20));
        _moneyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"#FB3131"];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_moneyLabel];
       
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(57) , kScreenWidth - kRealValue(32),1/kScreenScale )];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [_bgView addSubview:lineView];
        
    }
    return self;
}


-(void)createModel:(MHShopAssetModel *)model{

    _dataLabel.text = model.createDate;
    _timeLabel.text = model.createTime;
    if (model.type == 0) {
         _moneyLabel.text = [NSString stringWithFormat:@"+%@",model.money];
    }else  if (model.type == 1){
        _moneyLabel.text = [NSString stringWithFormat:@"-%@",model.money];
    }else  if (model.type == 2){
        _moneyLabel.text = [NSString stringWithFormat:@"+%@(冻结)",model.money];
    }else  if (model.type == 3){
       _moneyLabel.text = [NSString stringWithFormat:@"-%@(冻结)",model.money];
    }else  if (model.type == 4){
        _moneyLabel.text = [NSString stringWithFormat:@"-%@",model.money];
    }else  if (model.type == 5){
        _moneyLabel.text = [NSString stringWithFormat:@"+%@",model.money];
    }
    
    NSString *desc = model.desc;
    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
    textdesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    textdesc.color = [UIColor colorWithHexString:@"000000"];
    [textdesc setTextHighlightRange:[desc rangeOfString:model.orderCode]
                              color:[UIColor colorWithHexString:@"689DFF"]
                    backgroundColor:[UIColor colorWithHexString:@"666666"]
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){

                          }];
    _titlesLabel.attributedText = textdesc;
}


@end
