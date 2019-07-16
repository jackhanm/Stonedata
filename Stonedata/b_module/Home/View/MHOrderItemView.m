
//  MHOrderItemView.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHOrderItemView.h"

@implementation MHOrderItemView
-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr imageHeight:(NSInteger )imageheight{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - imageheight)/2, 10, imageheight, imageheight)];
        //        imageView.backgroundColor =[UIColor redColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageStr]] placeholderImage:[UIImage imageNamed:imageStr]];
        [self addSubview:imageView];
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, imageheight+kRealValue(8)+10, frame.size.width, kRealValue(17))];
        self.titleLable.text = title;
        self.titleLable.textColor = KColorFromRGB(0x333333);
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.font = [UIFont fontWithName:kPingFangLight size:kFontValue(14)];
        [self addSubview:self.titleLable];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame title:(NSString *)title subtitle:(NSString *)subtitle imageHeight:(NSInteger )imageheight
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(10), frame.size.width, (frame.size.height - kRealValue(20))/2)];
        self.titleLable.text = title;
        self.titleLable.textColor = KColorFromRGB(0x333333);
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        [self addSubview:self.titleLable];
        
        self.subtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height - kRealValue(20))/2+ kRealValue(10), frame.size.width, (frame.size.height - kRealValue(20))/2)];
        self.subtitle.text = subtitle;
        self.subtitle.textColor = KColorFromRGB(0x999999);
        self.subtitle.textAlignment = NSTextAlignmentCenter;
        self.subtitle.font = [UIFont fontWithName:kPingFangLight size:kFontValue(14)];
        [self addSubview:self.subtitle];
        
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
