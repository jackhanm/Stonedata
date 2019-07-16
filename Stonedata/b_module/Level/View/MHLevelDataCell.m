//
//  MHLevelDataCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHLevelDataCell.h"
#import "RichStyleLabel.h"

@implementation MHLevelDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray *titleArr = @[@"今日订单数",@"今日交易额",@"今日收益"];
        UIView *bgView1 = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), 0,kRealValue(343), kRealValue(49))];
        bgView1.layer.masksToBounds = YES;
        bgView1.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
        bgView1.layer.cornerRadius = kRealValue(5);
        [self addSubview:bgView1];
        
        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15) , kRealValue(90), kRealValue(17))];
        titleLabel1.text = @"本月销售额(元)";
        titleLabel1.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        titleLabel1.textColor = [UIColor blackColor];
        titleLabel1.textAlignment = NSTextAlignmentLeft;
        [bgView1 addSubview:titleLabel1];
        
        RichStyleLabel *descLabel1 = [[RichStyleLabel alloc] init];
        descLabel1.textAlignment = NSTextAlignmentRight;
        descLabel1.tag = 3400;
        descLabel1.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        descLabel1.textColor = [UIColor colorWithHexString:@"#000000"] ;
        [bgView1 addSubview:descLabel1];;

        [descLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView1.mas_right).with.offset(-kRealValue(15));
            make.top.equalTo(bgView1.mas_top).with.offset(kRealValue(13));
        }];
        //[descLabel1 setAttributedText:@"233.00" withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
        
        for (int i = 0; i<3; i++) {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16) + (kRealValue(108)*i) + (kRealValue(10)*(i)),kRealValue(59), kRealValue(108), kRealValue(81))];
            bgView.layer.masksToBounds = YES;
            bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
            bgView.layer.cornerRadius = kRealValue(5);
            [self addSubview:bgView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kRealValue(90), kRealValue(17))];
            titleLabel.text = titleArr[i];
            titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            [bgView addSubview:titleLabel];
            
            RichStyleLabel *descLabel = [[RichStyleLabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(40), kRealValue(90), kRealValue(32))];
            descLabel.textAlignment = NSTextAlignmentLeft;
            descLabel.tag = 3401+i;
            descLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
            descLabel.textColor = [UIColor colorWithHexString:@"#000000"] ;
            [bgView addSubview:descLabel];
            //[descLabel setAttributedText:@"233,28万" withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
        }
    }
    return self;
}

-(void)setShopModel:(MHShopkeepModel *)shopModel{
    _shopModel = shopModel;
    RichStyleLabel *label1 = [self viewWithTag:3400];
    [label1 setAttributedText:[self fixString:shopModel.monthTradeMoney] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
    RichStyleLabel *label2 = [self viewWithTag:3401];
    [label2 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",shopModel.todayOrderNum]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
    RichStyleLabel *label3 = [self viewWithTag:3402];
    
    [label3 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",shopModel.todayTradeMoney]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
    RichStyleLabel *label4 = [self viewWithTag:3403];
    [label4 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",shopModel.todayProfit]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
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
