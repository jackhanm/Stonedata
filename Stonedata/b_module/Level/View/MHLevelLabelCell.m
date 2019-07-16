//
//  MHLevelLabelCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHLevelLabelCell.h"

@implementation MHLevelLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#d8011f"];
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 8;
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
            make.width.mas_equalTo(kRealValue(355));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(0);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(20), kScreenWidth, kRealValue(22))];
        titleLabel.text = @"活动规则";
        titleLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(21)];
        titleLabel.textColor = [UIColor colorWithHexString:@"#dc031b"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.centerX = kRealValue(355)/2;;
        [bgView addSubview:titleLabel];
    
        
        
        YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
        modifier.fixedLineHeight = 22;
        YYLabel *textLabel = [[YYLabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        textLabel.textColor = [UIColor colorWithHexString:@"282828"];
        textLabel.linePositionModifier = modifier;
        textLabel.text = @"1、普通用户登录APP，在升级店主模块购买任意一款大礼包，即可升级为店主;\n2、活动期间，开店的新店主可获得800陌币奖励，邀请6名专属粉丝开店即可解锁，解锁后可提现、可消费;\n3、升级店主之后，每邀请1名专属粉丝开店，即可获得300陌币奖励，陌币可消费、可提现；\n4、店主邀请25名专属粉丝开店，即可升级为掌柜子，掌柜子邀请1名专属粉丝开店，即可获得330陌币奖励；掌柜子的普通粉丝开店，掌柜子可获100陌币奖励，陌币可消费、可提现;\n5、店主邀请200名专属粉丝开店，即可升级为分舵主，分舵主邀请1名专属粉丝开店，即可获得360陌币奖励；分舵主的普通粉丝开店，即可获得150陌币奖励;\n6、店主及以上用户的粉丝在未来商视APP内购物，店主可获相应的购物返佣;\n7、如出现不可抗力或情势变更的情况，则主办方可依据相关法律法规的规定主张免责;\n8、本活动的最终解释权，在法律允许的范围内，归未来商视所有;\n9、本活动与苹果公司（Apple.Inc）无关。";
        [bgView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.width.mas_equalTo(kRealValue(323));
            make.left.equalTo(bgView.mas_left).offset(kRealValue(16));
            make.top.equalTo(self.mas_top).offset(0);
        }];
    }
    return self;
}
@end
