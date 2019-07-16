//
//  MHSumbitFootView.m
//  mohu
//
//  Created by AllenQin on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHSumbitFootView.h"

@implementation MHSumbitFootView

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _isDeployBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(44))];
        [_isDeployBtn setTitle:@"展开全部商品" forState:UIControlStateNormal];
        _isDeployBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        [_isDeployBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [self addSubview:_isDeployBtn];

        UILabel *line= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1/kScreenScale)];
        line.backgroundColor = [UIColor colorWithHexString:@"E0E0E0"];
        [_isDeployBtn addSubview:line];
        
        NSArray *arr = @[@"商品数量",@"商品总额",@"运费",@"优惠减免"];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(44), kScreenWidth, kRealValue(10))];
        lineView.backgroundColor = kBackGroudColor;
        [self addSubview:lineView];
        
        //title
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(54), kScreenWidth, kRealValue(37))];
        titleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"支付信息";
        titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        titleLabel.textColor = [UIColor blackColor];
        [titleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleView.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
        }];
        
        for (int i = 0 ; i < 4; i++) {
            UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(91) + (i*kRealValue(30)), kScreenWidth, kRealValue(30))];
            [self addSubview:sectionView];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = arr[i];
            label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
            label1.textColor = [UIColor blackColor];
            [sectionView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.left.equalTo(self.mas_left).with.offset(kRealValue(31));
            }];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.text = titleArr[i];
            if (i == 3) {
                label2.textColor = [UIColor colorWithHexString:@"FB3131"];
            }else{
                label2.textColor = [UIColor blackColor];
            }
            label2.textAlignment = NSTextAlignmentRight;
            label2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
            
            [sectionView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.right.equalTo(self.mas_right).with.offset(-kRealValue(15));
            }];
            
        }
        
        
        
    }
    return self;
}
@end
