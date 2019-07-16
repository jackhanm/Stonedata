//
//  MHExtensionCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHExtensionCell.h"
#import "RichStyleLabel.h"
#import "MHNewbeeVC.h"

@implementation MHExtensionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray *titleArr = @[@"邀请好友",@"专属粉丝"];
        
        for (int i = 0; i<3; i++) {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kRealValue(108), kRealValue(81))];
            bgView.layer.masksToBounds = YES;
            bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
            bgView.layer.cornerRadius = kRealValue(5);
            bgView.left = kRealValue(16) + (kRealValue(108)*i) + (kRealValue(10)*(i));
            [self addSubview:bgView];
            if (i!=2) {
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kRealValue(90), kRealValue(17))];
                titleLabel.text = titleArr[i];
                titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
                titleLabel.textColor = [UIColor blackColor];
                titleLabel.textAlignment = NSTextAlignmentLeft;
                [bgView addSubview:titleLabel];
                
                RichStyleLabel *descLabel = [[RichStyleLabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(40), kRealValue(90), kRealValue(32))];
                descLabel.tag = 3500 +i;
                descLabel.textAlignment = NSTextAlignmentLeft;
                descLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
                descLabel.textColor = [UIColor colorWithHexString:@"#000000"] ;
                [bgView addSubview:descLabel];
//                [descLabel setAttributedText:@"233,28万" withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
            }else{
                UIImageView *imageview = [[UIImageView alloc]initWithFrame: CGRectMake(0,0, kRealValue(108), kRealValue(81))];
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer *gotogradetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotograde)];
                [imageview addGestureRecognizer:gotogradetap];
                imageview.image = kGetImage(@"level_invist");
                [bgView addSubview:imageview];
                
            }

            
            
        }
    }
    return self;
}


- (void)gotograde{
    MHNewbeeVC *vc = [[MHNewbeeVC alloc] init];
    [self.superVC.navigationController pushViewController:vc animated:YES];
    
}


-(void)setShopModel:(MHShopkeepModel *)shopModel{
    _shopModel = shopModel;
    RichStyleLabel *label1 = [self viewWithTag:3500];
    [label1 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",shopModel.indirectFans]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
    RichStyleLabel *label2 = [self viewWithTag:3501];
    
    [label2 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",shopModel.directFans]
] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
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
