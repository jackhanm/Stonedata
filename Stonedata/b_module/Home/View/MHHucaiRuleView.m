//
//  MHHucaiRuleView.m
//  mohu
//
//  Created by yuhao on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHucaiRuleView.h"
@interface MHHucaiRuleView()
@property(nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIImageView *smallbgview;
@end
@implementation MHHucaiRuleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createviewWithFrame:frame];
    }
    return self;
}
-(void)createviewWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    //半透明的背景
    self.bgView = [[UIView alloc]initWithFrame:frame];
    self.bgView.backgroundColor = KColorFromRGBA(0x00000, 0.5);
    self.bgView.userInteractionEnabled = YES;
    [self addSubview:self.bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
    [self.bgView addGestureRecognizer:tap];
    
    self.smallbgview = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(45)/2, (kScreenHeight - kRealValue(340))/2, kRealValue(330), kRealValue(340))];
    self.smallbgview.image = kGetImage(@"弹窗h");
    self.smallbgview.layer.cornerRadius = kRealValue(10);
    self.smallbgview.centerX = self.centerX;
    self.smallbgview.userInteractionEnabled = YES;
    [self.bgView addSubview:self.smallbgview];
    
    UIScrollView *textscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(50), kRealValue(310), kRealValue(285))];
    textscrollview.backgroundColor = [UIColor whiteColor];
    textscrollview.showsHorizontalScrollIndicator = NO;
    textscrollview.showsVerticalScrollIndicator = NO;
    UILabel *label = [[UILabel alloc]init];
    label.text = @"1 .活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则 \n 2. 活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则 \n 3. 活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则活动规则";
     CGRect rect = [label.text boundingRectWithSize:CGSizeMake(kRealValue(300), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)]} context:nil];
    label.numberOfLines = 0;
    label.frame = CGRectMake(kRealValue(10), 0, kRealValue(300), rect.size.height);
   
    [textscrollview addSubview:label];
     textscrollview.contentSize = CGSizeMake(kRealValue(310), rect.size.height+30);
    [self.smallbgview addSubview:textscrollview];
    
    
    
    
   
    
    
    //    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [closeBtn setBackgroundImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    //    [closeBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    //    [self addSubview:closeBtn];
    //    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.smallbgview.mas_bottom).with.offset(kRealValue(40));
    //        make.centerX.mas_equalTo(self.smallbgview.mas_centerX);
    //        make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(30)));
    //    }];
    
}
-(void)showView{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.hidden = NO;
        
    } completion:^(BOOL fin){
      
    }];
}
-(void)hideView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = YES;
        
    } completion:^(BOOL fin){
        
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
