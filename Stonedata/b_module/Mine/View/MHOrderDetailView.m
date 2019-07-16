//
//  MHOrderDetailView.m
//  mohu
//
//  Created by AllenQin on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHOrderDetailView.h"

@implementation MHOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr withMoney:(NSString *)money withContent:(NSArray *)contentArr{
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
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(44), kScreenWidth, kRealValue(10))];
        lineView.backgroundColor = kBackGroudColor;
        [self addSubview:lineView];
        
        
        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(54), kScreenWidth, kRealValue(30))];
        [self addSubview:sectionView];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(kRealValue(18),kRealValue(12.5),kRealValue(30),kRealValue(15));
        label.text = @" 返佣 ";
        label.backgroundColor = [UIColor colorWithHexString:@"#FD5D3A"];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFontValue(11)];
        label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentLeft;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = kRealValue(3);
        [sectionView addSubview:label];
        label.centerY = kRealValue(15);
        
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.text = @"本单可赚";
        label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        label1.textColor = [UIColor blackColor];
        [self addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(30));
            make.top.equalTo(sectionView.mas_top).with.offset(0);
            make.left.equalTo(label.mas_right).with.offset(kRealValue(4));
        }];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.text = money;
        label2.textAlignment = NSTextAlignmentRight;
        label2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        label2.textColor = [UIColor blackColor];
        [self addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRealValue(30));
            make.top.equalTo(sectionView.mas_top).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(-kRealValue(15));
        }];
        
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(84), kScreenWidth, kRealValue(10))];
        lineView1.backgroundColor = kBackGroudColor;
        [self addSubview:lineView1];
        
        
        //title
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(94), kScreenWidth, kRealValue(37))];
        titleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleView];
        
        UIView *vview1 = [[UIView alloc] init];
        vview1.backgroundColor = [UIColor colorWithHexString:@"#E91111"];
        [titleView addSubview:vview1];
        [vview1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleView.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
            make.width.mas_equalTo(kRealValue(2));
            make.height.mas_equalTo(kRealValue(18));
        }];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"支付信息";
        titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [titleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleView.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(28));
        }];

        NSArray *arr = @[@"商品数量",@"商品总额",@"运费",@"优惠减免",@"实付款"];
        
        
        for (int i = 0 ; i < 5; i++) {
            UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(131) + (i*kRealValue(30)), kScreenWidth, kRealValue(30))];
            [self addSubview:sectionView];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = arr[i];
            label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            label1.textColor = [UIColor colorWithHexString:@"666666"];
            [sectionView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.left.equalTo(self.mas_left).with.offset(kRealValue(31));
            }];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.text = titleArr[i];
            label2.textAlignment = NSTextAlignmentRight;
            label2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            if (i == 4 || i == 3) {
               label2.textColor = [UIColor colorWithHexString:@"#E91111"];
            }else{
               label2.textColor = [UIColor blackColor];
            }
 
            [sectionView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.right.equalTo(self.mas_right).with.offset(-kRealValue(15));
            }];
            
        }
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(281), kScreenWidth, kRealValue(10))];
        lineView2.backgroundColor = kBackGroudColor;
        [self addSubview:lineView2];
//
//        //title
        UIView *titleView1 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(291), kScreenWidth, kRealValue(37))];
        titleView1.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleView1];
        
        UIView *vview2 = [[UIView alloc] init];
        vview2.backgroundColor = [UIColor colorWithHexString:@"#E91111"];
        [titleView1 addSubview:vview2];
        [vview2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleView1.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
            make.width.mas_equalTo(kRealValue(2));
            make.height.mas_equalTo(kRealValue(18));
        }];
        
        
        UILabel *titleLabel3 = [[UILabel alloc] init];
        titleLabel3.text = @"订单详情";
        titleLabel3.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        titleLabel3.textColor = [UIColor colorWithHexString:@"333333"];
        [titleView1 addSubview:titleLabel3];
        [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleView1.mas_centerY).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(kRealValue(28));
        }];
        
        NSArray *arr1 = @[@"订单编号",@"支付方式",@"支付时间"];

        for (int i = 0 ; i < 3; i++) {
            UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(328) + (i*kRealValue(30)), kScreenWidth, kRealValue(30))];
            [self addSubview:sectionView];

            UILabel *label1 = [[UILabel alloc] init];
            label1.text = arr1[i];
            label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            label1.textColor = [UIColor colorWithHexString:@"#666666"];
            [sectionView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.left.equalTo(self.mas_left).with.offset(kRealValue(31));
            }];

            UILabel *label2 = [[UILabel alloc] init];
            label2.text = contentArr[i];
            label2.textAlignment = NSTextAlignmentRight;
            label2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            label2.textColor = [UIColor colorWithHexString:@"#333333"];
            [sectionView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(sectionView.mas_centerY).with.offset(0);
                make.right.equalTo(self.mas_right).with.offset(-kRealValue(15));
            }];
            if (ValidStr(contentArr[i])) {
                label1.hidden = NO;
                label2.hidden = NO;
            }else{
                label1.hidden = YES;
                label2.hidden = YES;
            }

        }


        
        
    }
    return self;
}

@end
