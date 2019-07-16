//
//  MHSignTableViewCell.m
//  mohu
//
//  Created by AllenQin on 2019/1/7.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHSignTableViewCell.h"



@implementation MHSignTableViewCell

//数据传入
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArr:(NSArray *)arr withIndex:(NSInteger )index withState:(NSInteger) state{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.circleViewArray = [NSMutableArray array];
        self.titleLabelArray = [NSMutableArray array];
        UIImageView * backImageView  = [[UIImageView alloc]initWithImage:kGetImage(@"dot_bg")];
        backImageView.frame = CGRectMake(kRealValue(10), 0, kRealValue(356), kRealValue(246));
        backImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:backImageView];
        
        UILabel *jifenLabel = [[UILabel alloc] init];
        jifenLabel.text = @"已经连续签到";
        jifenLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        jifenLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [backImageView addSubview:jifenLabel];
        [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(backImageView.mas_centerX).offset(0);
            make.top.equalTo(backImageView.mas_top).offset(kRealValue(19));
        }];
        
        UIButton *signBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, kRealValue(180), kRealValue(145), kRealValue(34))];
        signBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        [signBtn addTarget:self action:@selector(signClick:) forControlEvents:UIControlEventTouchUpInside];
        [signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [signBtn setTitle:@"已签到" forState:UIControlStateDisabled];
        if (state == 0) {
            [signBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"ff6583"],[UIColor colorWithHexString:@"ff9a65"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(145), kRealValue(34))] forState:UIControlStateNormal];
            signBtn.enabled = YES;
        }else{
            [signBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"999999"],[UIColor colorWithHexString:@"999999"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(145), kRealValue(34))] forState:UIControlStateNormal];
            signBtn.enabled = NO;
        }

        [backImageView addSubview:signBtn];
        [signBtn.layer setCornerRadius:kRealValue(17)];
        [signBtn.layer setMasksToBounds:YES];
        signBtn.centerX = kRealValue(178);
        //进度条
        self.stepView =[[HQLStepView alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(110), kRealValue(336), kRealValue(40)) titlesArray:arr stepIndex:index];
        [backImageView addSubview:self.stepView];
 
        NSArray *dayArr = @[@"第1天",@"第2天",@"第3天",@"第4天",@"第5天",@"第6天",@"第7天"];
        for (int i = 0; i<7; i++) {
            //字
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kRealValue(48) * i) + kRealValue(10), kRealValue(140), kRealValue(48), kRealValue(20))];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(11)];
            label.textColor = [UIColor colorWithHexString:@"666666"];
            label.text = dayArr[i];
            [backImageView addSubview:label];
            
            //图
            UIImageView *imageView = [[UIImageView alloc] initWithImage:kGetImage(@"sign_right")];
            imageView.frame = CGRectMake(0, kRealValue(145), kRealValue(13), kRealValue(9));
            [backImageView addSubview:imageView];
            imageView.centerX  = label.centerX;
            
            [self.titleLabelArray addObject:label];
            [self.circleViewArray addObject:imageView];
            
            if (index == -1) {
                label.hidden = NO;
                imageView.hidden = YES;
            }else{
                //判断是否显示
                if (i > index) {
                    label.hidden = NO;
                    imageView.hidden = YES;
                }else{
                    label.hidden = YES;
                    imageView.hidden = NO;
                }
            }
        }
        
        
        //天
        self.priceLabel  = [[RichStyleLabel alloc]init];
        self.priceLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        self.priceLabel .textColor =[UIColor colorWithHexString:@"#666666"];
        [backImageView addSubview:self.priceLabel];
        
        [self.priceLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(backImageView.mas_centerX).with.offset(0);
            make.top.equalTo(backImageView.mas_top).with.offset(kRealValue(55));
        }];
        [self.priceLabel setAttributedText:[NSString stringWithFormat:@"%ld天",index+1] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#ff6683"],NSFontAttributeName : [UIFont fontWithName:kPingFangSemibold size:kFontValue(29)]}];
   
        
    }
    return self;
}


- (void)showSignToast:(NSDictionary *)dict{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(315), kRealValue(255))];
    bgView.backgroundColor = [UIColor clearColor];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kRealValue(314), kRealValue(228))];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = kRealValue(5);
    [bgView addSubview:contentView];
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kRealValue(315), kRealValue(184))];
    headView.image = kGetImage(@"dalgo_bga");
    [contentView addSubview:headView];
    headView.centerX = kRealValue(157);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(23), kRealValue(100), kRealValue(20))];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(16)];
    label.textColor = [UIColor colorWithHexString:@"ffffff"];
    label.text = @"已经累计签到";
    label.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:label];
    label.centerX = kRealValue(157);
    
    
    self.dayLabel  = [[RichStyleLabel alloc]initWithFrame:CGRectMake(0, kRealValue(90), kRealValue(50), kRealValue(30))];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel .font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    self.dayLabel .textColor =[UIColor colorWithHexString:@"ffffff"];
    [contentView addSubview:self.dayLabel];
    self.dayLabel.centerX = kRealValue(157);
    
    [self.dayLabel setAttributedText:[NSString stringWithFormat:@"%ld天",[dict[@"data"][@"userIntegral"][@"days"] integerValue]] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#ffffff"],NSFontAttributeName : [UIFont fontWithName:kPingFangSemibold size:kFontValue(29)]}];
    
    //积分
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(195), kRealValue(314), kRealValue(20))];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    contentLabel.textColor = [UIColor colorWithHexString:@"000000"];
    [contentView addSubview:contentLabel];
    contentLabel.centerX = kRealValue(157);
    
    NSString *jifenStr = [NSString stringWithFormat:@"+%@",dict[@"data"][@"userIntegral"][@"integral"]];
    NSMutableAttributedString *mobiStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@积分~每天签到有惊喜哦！",jifenStr]];
    
    [mobiStr addAttribute:NSForegroundColorAttributeName value:  [UIColor colorWithHexString:@"ff6371"] range:NSMakeRange(0,[jifenStr length])];
    contentLabel.attributedText = mobiStr;
    
    
    self.popView = [[ZJAnimationPopView alloc] initWithCustomView:bgView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.2 显示时背景的透明度
    self.popView.popBGAlpha = 0.5f;
    // 3.3 显示时是否监听屏幕旋转
    self.popView.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    self.popView.popAnimationDuration = 0.3f;
    self.popView.isClickBGDismiss = YES;
    // 3.5 移除时动画时长
    self.popView.dismissAnimationDuration = 0.3f;
    
    // 3.6 显示完成回调
    self.popView.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    self.popView.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [self.popView pop];
    
}


- (void)signClick:(UIButton *)sender{
    //签到
    [[MHUserService sharedInstance]initPostSignCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSInteger  indexNumber = [response[@"data"][@"userIntegral"][@"days"] integerValue] - 1;
            if ([response[@"data"][@"userIntegral"][@"signIn"] integerValue] == 0) {
                [sender setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"ff6583"],[UIColor colorWithHexString:@"ff9a65"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(145), kRealValue(34))] forState:UIControlStateNormal];
                sender.enabled = YES;
            }else{
                [sender setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"999999"],[UIColor colorWithHexString:@"999999"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(145), kRealValue(34))] forState:UIControlStateNormal];
                sender.enabled = NO;
            }
        
            for (int i = 0; i < self.titleLabelArray.count; i++) {
                UIImageView *imageView = self.circleViewArray[i];
                UILabel *label = self.titleLabelArray[i];
                if (indexNumber == -1) {
                    label.hidden = NO;
                    imageView.hidden = YES;
                }else{
                    //判断是否显示
                    if (i > indexNumber) {
                        label.hidden = NO;
                        imageView.hidden = YES;
                    }else{
                        label.hidden = YES;
                        imageView.hidden = NO;
                    }
                }
            }
         [self.stepView setStepIndex:indexNumber animation:YES];
          [self.priceLabel setAttributedText:[NSString stringWithFormat:@"%ld天",indexNumber+1] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#ff6683"],NSFontAttributeName : [UIFont fontWithName:kPingFangSemibold size:kFontValue(29)]}];
            if (self.openClick) {
                self.openClick(response);
            }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self showSignToast:response];
        });
            
        }else{
            KLToast(@"今天已签到，不可重复签到");
        }
    }];
}

@end
