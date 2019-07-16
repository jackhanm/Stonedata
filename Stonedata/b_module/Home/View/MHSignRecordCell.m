//
//  MHSignRecordCell.m
//  mohu
//
//  Created by AllenQin on 2019/1/10.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHSignRecordCell.h"

@implementation MHSignRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
            _titlesLabel = [[UILabel alloc]init];
            _titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            _titlesLabel.textColor =[UIColor colorWithHexString:@"333333"];
//            _titlesLabel.text  = @"美妆蛋";
            _titlesLabel.numberOfLines = 1;
            [self addSubview:_titlesLabel];
            [_titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).with.offset(kRealValue(10));
                make.left.equalTo(self.mas_left).with.offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(285));
            }];
        
        
            _dataLabel = [[UILabel alloc]init];
            _dataLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
            _dataLabel.textColor =[UIColor colorWithHexString:@"999999"];
//            _dataLabel.text  = @"25ml/白色";
            [self addSubview:_dataLabel];
            [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom).with.offset(-kRealValue(7));
                make.left.equalTo(self.mas_left).with.offset(kRealValue(15));
            }];
        
        
            _stateLabel = [[UILabel alloc]init];
            _stateLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            _stateLabel.textColor =[UIColor colorWithHexString:@"#ff6371"];
//                        _stateLabel.text  = @"待发货";
            _stateLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_stateLabel];
            [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY).with.offset(0);
                make.right.equalTo(self.mas_right).with.offset(-kRealValue(15));
                make.width.mas_equalTo(kRealValue(100));
            }];
    
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(47), kScreenWidth, 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [self addSubview:lineView];

    }
    
    return self;
}


-(void)createModel:(MHSignRecordModel *)model{
    //获得积分
    if ([model.integralRecordType isEqualToString:@"INCOME"]) {
        _titlesLabel.text = [NSString stringWithFormat:@"连续签到%@天",model.remark];
        _dataLabel.text = [NSString stringWithFormat:@"%@",model.integralDate];
        NSString *interal = [NSString stringWithFormat:@"+%@",model.integralMoney];
        
        NSMutableAttributedString *mobiStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@积分",interal]];
        [mobiStr addAttribute:NSForegroundColorAttributeName value:  [UIColor colorWithHexString:@"#ff6371"] range:NSMakeRange(0,[interal length])];
        self.stateLabel.attributedText = mobiStr;
        
    }else if ([model.integralRecordType isEqualToString:@"EXPENSE"]){
        //激活积分
        _titlesLabel.text = [NSString stringWithFormat:@"激活%@积分",model.integralMoney];
        _dataLabel.text = [NSString stringWithFormat:@"%@",model.integralDate];
        self.stateLabel.text = @"已激活";
        self.stateLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
    }else if ([model.integralRecordType isEqualToString:@"EXPENSE_FREEZE"]){
        //待激活积分
        _titlesLabel.text = [NSString stringWithFormat:@"激活%@积分",model.integralMoney];
        _dataLabel.text = [NSString stringWithFormat:@"%@",model.integralDate];
        self.stateLabel.text = @"待激活";
        self.stateLabel.textColor = [UIColor colorWithHexString:@"#ff6371"];
    }
    
 
}

@end
