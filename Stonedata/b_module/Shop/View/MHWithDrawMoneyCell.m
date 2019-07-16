//
//  MHWithDrawMoneyCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHWithDrawMoneyCell.h"
#import "CSMoneyTextField.h"

@implementation MHWithDrawMoneyCell

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
        titlesLabel.text  = @"提 现 金 额";
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
        mobiLabel.text  = @"元";
        [bgView addSubview:mobiLabel];
        [mobiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView.mas_right).with.offset(-kRealValue(15));
            make.bottom.equalTo(bgView.mas_bottom).with.offset(-kRealValue(12));
        }];
        

        
        CSMoneyTextField *tf = [[CSMoneyTextField alloc] initWithFrame:CGRectMake(kRealValue(103), kRealValue(5), kRealValue(200), kRealValue(44))];
        tf.borderStyle = UITextBorderStyleNone;
        tf.tag = 6666;
        tf.placeholder = @"0";
        tf.font = [UIFont fontWithName:@"DINCondensed-Bold" size:kRealValue(32)];
        tf.keyboardType = UIKeyboardTypeDecimalPad;
        tf.limit.delegate = self;
        tf.limit.max = @"9999999.99";
        [bgView addSubview:tf];
        
       _stateLabel = [[UILabel alloc]init];
        _stateLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _stateLabel.textColor =[UIColor colorWithHexString:@"#FB3131"];

        _stateLabel.textAlignment = NSTextAlignmentRight;
        _stateLabel.hidden = YES;
        [self.contentView addSubview:_stateLabel];
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_bottom).with.offset(kRealValue(8));
            make.centerX.equalTo(bgView.mas_centerX).with.offset(0);
        }];
        
        
    }
    
    return self;
}

#pragma mark -CSMoneyTFLimitDelegate
- (void)valueChange:(id)sender{
     _stateLabel.text  = @"余额不足";
    if ([sender isKindOfClass:[CSMoneyTextField class]]) {
        CSMoneyTextField *tf = (CSMoneyTextField *)sender;
        if ([tf.text doubleValue] > [self.maxString doubleValue]) {
            _stateLabel.hidden = NO;
        }else{
            _stateLabel.hidden = YES;
        }
    }
}

@end
