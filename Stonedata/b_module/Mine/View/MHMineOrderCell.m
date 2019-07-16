


//
//  MHMineOrderCell.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineOrderCell.h"
#import "MHOrderItemView.h"
@implementation MHMineOrderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createview];
    }
    return self;
}
-(void)createview
{
    [self addSubview:self.bgimageview];
    self.bgview = [[UIView alloc] init];
    self.bgview.frame = CGRectMake(kRealValue(10),kRealValue(3),kRealValue(355),kRealValue(123));
    self.bgview.backgroundColor= KColorFromRGB(0xffffff);
    self.bgview.layer.cornerRadius = kRealValue(6);
    [self.bgimageview addSubview:self.bgview];
    
    [self.bgview addSubview:self.alltitle];
    [self.bgview addSubview:self.rightIcon];
    [self.bgview addSubview:self.righttitle];

    
    [self.alltitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgview.mas_left).offset(kRealValue(15));
        make.top.equalTo(self.bgview.mas_top).offset(kRealValue(10));
        make.width.mas_equalTo(kRealValue(120));
        make.height.mas_equalTo(kRealValue(30));
    }];
    [self.rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgview.mas_right).offset(kRealValue(-10));
        make.top.equalTo(self.bgview.mas_top).offset(kRealValue(15));
        make.width.mas_equalTo(kRealValue(20));
        make.height.mas_equalTo(kRealValue(20));
    }];
    [self.righttitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightIcon.mas_left).offset(kRealValue(35));
        make.top.equalTo(self.bgview.mas_top).offset(kRealValue(5));
        make.width.mas_equalTo(kRealValue(90));
        make.height.mas_equalTo(kRealValue(40));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = KColorFromRGB(0xF2F2F2);
    [self.bgview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.bgview.mas_width);
        make.height.mas_equalTo(1/kScreenScale);
        make.top.equalTo(self.alltitle.mas_bottom).offset(kRealValue(10));
    }];
    
    
    NSInteger widthW = kRealValue(355)/4;
    NSArray *Arr = [NSArray arrayWithObjects:@"待付款",@"待收货",@"待评价",@"退换货" ,nil];
    NSArray *imageArr = [NSArray arrayWithObjects:@"ic_order_payment",@"ic_order_collect",@"ic_order_after",@"ic_order_complete",nil];
    for (int i = 0 ; i < 4; i++) {
        
      CGRect frame = CGRectMake(widthW *i, 60, widthW, kRealValue(60));
         MHOrderItemView *btnView = [[MHOrderItemView alloc] initWithFrame:frame title:Arr[i] imageStr:imageArr[i] imageHeight:kRealValue(18)];
        btnView.tag = 160000+i;
//        btnView.backgroundColor = kRandomColor;
        [self.bgview addSubview:btnView];
        
        UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(orderType:)];
        [btnView addGestureRecognizer:tapAct];
        
    }
   
    
    self.righttitle.userInteractionEnabled =YES;
    self.rightIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapAll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAllAct)];
    [self.righttitle addGestureRecognizer:tapAll];

}


-(void)tapAllAct
{
    MHLog(@"111");
    if (self.seeall) {
        self.seeall();
    }
}
-(void)orderType:(UITapGestureRecognizer *)sender
{
    if (self.seeorderWithtype) {
        self.seeorderWithtype(sender.view.tag);
    }
}
-(UILabel *)alltitle
{
    if (!_alltitle) {
        _alltitle = [[UILabel alloc]init];
        _alltitle.font = [UIFont fontWithName:kPingFangLight size:kFontValue(16)];
        _alltitle.textColor = [UIColor blackColor];
        _alltitle.textAlignment = NSTextAlignmentLeft;
        _alltitle.text =@"我的订单";
    }
    return _alltitle;
}
-(UILabel *)righttitle
{
    if (!_righttitle) {
        _righttitle = [[UILabel alloc]init];
        _righttitle.font = [UIFont fontWithName:kPingFangLight size:kFontValue(14)];
        _righttitle.textColor = KColorFromRGB(0x666666);
        _righttitle.userInteractionEnabled = YES;
        _righttitle.textAlignment = NSTextAlignmentLeft;
        _righttitle.text =@"全部订单";
    }
    return _righttitle;
}
-(UIImageView *)rightIcon
{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]init];
        _rightIcon.userInteractionEnabled = NO;
        _rightIcon.image= kGetImage(@"ic_public_more");
    }
    return _rightIcon;
}

-(UIImageView *)bgimageview
{
    if (!_bgimageview) {
        _bgimageview = [[UIImageView alloc]init];
        _bgimageview.userInteractionEnabled = YES;
        _bgimageview.backgroundColor = KColorFromRGB(0xF1F2F1);
        _bgimageview.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(130));
//        _bgimageview.image= kGetImage(@"back_shadow_order");
    }
    return _bgimageview;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
