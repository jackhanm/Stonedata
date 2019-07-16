//
//  MHLevelAssetCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHLevelAssetCell.h"
#import "RichStyleLabel.h"

@implementation MHLevelAssetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray *titleArr = @[@"待结算",@"累计结算",@"累计提现",@"累计推广奖励",@"累计佣金收益"];
        
        for (int i = 0; i<5; i++) {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kRealValue(108), kRealValue(81))];
            bgView.layer.masksToBounds = YES;
            bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
            bgView.layer.cornerRadius = kRealValue(5);
            [self addSubview:bgView];
            if (i<3) {
                bgView.left = kRealValue(16) + (kRealValue(108)*i) + (kRealValue(10)*(i));
                bgView.top = 0;
            }else{
                bgView.left = kRealValue(16) + (kRealValue(108)*(i-3)) + (kRealValue(10)*(i-3));
                bgView.top = kRealValue(91);
            }
            //title
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kRealValue(90), kRealValue(17))];
            titleLabel.text = titleArr[i];
            titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            [bgView addSubview:titleLabel];
            
            RichStyleLabel *descLabel = [[RichStyleLabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(40), kRealValue(90), kRealValue(32))];
            descLabel.tag = 3300 + i;
            descLabel.textAlignment = NSTextAlignmentLeft;
            descLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
            descLabel.textColor = [UIColor colorWithHexString:@"#000000"] ;
            [bgView addSubview:descLabel];

            
            
        }
    }
    return self;
}

-(void)setShopModel:(MHShopkeepModel *)shopModel{
    _shopModel = shopModel;
    RichStyleLabel *label1 = [self viewWithTag:3300];
    [label1 setAttributedText:[self fixString:shopModel.pendingSettlement] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
    RichStyleLabel *label2 = [self viewWithTag:3301];
    [label2 setAttributedText:[self fixString:shopModel.totalSettlement] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
    RichStyleLabel *label3 = [self viewWithTag:3302];
    [label3 setAttributedText:[self fixString:shopModel.totalWithdraw] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
    RichStyleLabel *label4 = [self viewWithTag:3303];
    [label4 setAttributedText:[self fixString:shopModel.totalSpreadAward] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
    RichStyleLabel *label5 = [self viewWithTag:3304];
    [label5 setAttributedText:[self fixString:shopModel.totalCommissionProfit] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
}

- (NSString *)fixString:(NSString *)str{
    if (str) {
        if ([str doubleValue] > 10000) {
            return [NSString stringWithFormat:@"%.2f万",[str doubleValue]/10000];
        }else{
            return str;
        }
    }else{
        return @"";
    }
}

@end
