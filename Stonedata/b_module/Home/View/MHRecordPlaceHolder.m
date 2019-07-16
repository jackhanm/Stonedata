//
//  MHRecordPlaceHolder.m
//  mohu
//
//  Created by AllenQin on 2019/1/14.
//  Copyright © 2019 AllenQin. All rights reserved.
//

static float const kUIemptyOverlayLabelX         = 0;
static float const kUIemptyOverlayLabelY         = 0;
static float const kUIemptyOverlayLabelHeight    = 20;

#import "MHRecordPlaceHolder.h"

@interface MHRecordPlaceHolder ()

@property (nonatomic, strong) UIImageView *emptyOverlayImageView;

@end

@implementation MHRecordPlaceHolder

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)sharedInit {
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    self.contentMode =   UIViewContentModeTop;
//    [self addUIemptyOverlayImageView];
    [self addUIemptyOverlayLabel];
    return self;
}

- (void)addUIemptyOverlayImageView {
    self.emptyOverlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 180)];
    self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 - 100);
    self.emptyOverlayImageView.image = [UIImage imageNamed:@"img_empty"];
    [self addSubview:self.emptyOverlayImageView];
}

- (void)addUIemptyOverlayLabel {
    CGRect emptyOverlayViewFrame = CGRectMake(kUIemptyOverlayLabelX, kUIemptyOverlayLabelY, CGRectGetWidth(self.frame), kUIemptyOverlayLabelHeight);
    UILabel *emptyOverlayLabel = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
    emptyOverlayLabel.textAlignment = NSTextAlignmentCenter;
    emptyOverlayLabel.numberOfLines = 0;
    emptyOverlayLabel.text = @"暂无信息";
    emptyOverlayLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    emptyOverlayLabel.textColor = [UIColor colorWithHexString:@"333333"];
    emptyOverlayLabel.frame = ({
        CGRect frame = emptyOverlayLabel.frame;
        frame.origin.y = 130 + 10;
        frame;
    });
    [self addSubview:emptyOverlayLabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, CGRectGetWidth(self.frame), kUIemptyOverlayLabelHeight)];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 0;
    descLabel.text = @"快去签到赚积分吧！";
    descLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    descLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:descLabel];
    
    
    UIButton *signBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, kRealValue(74), kRealValue(28))];
    signBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [signBtn addTarget:self action:@selector(signClick) forControlEvents:UIControlEventTouchUpInside];
    [signBtn setTitle:@"去签到" forState:UIControlStateNormal];
   [signBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"ff6583"],[UIColor colorWithHexString:@"ff9a65"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(74), kRealValue(28))] forState:UIControlStateNormal];
    
    [self addSubview:signBtn];
    [signBtn.layer setCornerRadius:kRealValue(14)];
    [signBtn.layer setMasksToBounds:YES];
    signBtn.centerX = kScreenWidth/2;
    
}

-(void)signClick{
    if (self.openClick) {
        self.openClick();
    }
}

@end
