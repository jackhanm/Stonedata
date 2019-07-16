//
//  MHLevelDescCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHLevelDescCell.h"

@implementation MHLevelDescCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#d8011f"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(10), 0, kRealValue(355), kRealValue(339))];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kRealValue(5), kRealValue(5))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = view.bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
        
        
        UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"level_desc"]];
        [view addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(319));
            make.width.mas_equalTo(kRealValue(355));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(0);
        }];
        
    }
    return self;
}



@end
