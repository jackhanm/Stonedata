//
//  MHGuessOrderDetailCell.m
//  mohu
//
//  Created by yuhao on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHGuessOrderDetailCell.h"

@implementation MHGuessOrderDetailCell
-(void)setDic:(NSMutableDictionary *)dic
{
    _dic = dic;
    [self createview:dic];
    
    NSMutableDictionary *productdic= [dic valueForKey:@"orderProduct"];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[productdic valueForKey:@"productSmallImage"]] placeholderImage:kGetImage(kfailImage)];
    self.titlesLabel.text =[productdic valueForKey:@"productName"];
    self.priceLabel.text = [productdic valueForKey:@"productPrice"];
    self.prizePersonNamelabel.text = [dic valueForKey:@"winningUserNickName"];
    [self.prizePersonImage sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"winningUserAvatar"]] placeholderImage:kGetImage(kfailImage)];
    self.prizePersonPricelabel.text =[NSString stringWithFormat:@"竞中价¥%@",[dic valueForKey:@"winningPrice"]];
     self.numberLabel.text = [NSString stringWithFormat:@"%@场次",[productdic valueForKey:@"drawNumber"]];
}
-(void)createview:(NSMutableDictionary *)dic
{
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(10))];
    line1.backgroundColor = KColorFromRGB(0xF2F3F5);
    [self.contentView addSubview:line1];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(20), kRealValue(100), kRealValue(20))];
    titlelabel.text = @"中奖商品";
    titlelabel.textColor = KColorFromRGB(0x000000);
    titlelabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
    titlelabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:titlelabel];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(52), kScreenWidth-kRealValue(32), kRealValue(100))];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius =kRealValue(9);
    [bgView shadowPathWith:[UIColor colorWithHexString:@"756A4B" andAlpha:.15] shadowOpacity:1 shadowRadius:kRealValue(5) shadowSide:MHShadowPathMohu shadowPathWidth:2];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.backgroundColor = kRandomColor;
    [bgView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kRealValue(80), kRealValue(80)));
        make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
        make.left.equalTo(bgView.mas_left).with.offset(0);
    }];
    
    _titlesLabel = [[UILabel alloc]init];
    _titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    _titlesLabel.textColor =[UIColor colorWithHexString:@"000000"];
    _titlesLabel.text  = @"";
    _titlesLabel.numberOfLines = 1;
    [bgView addSubview:_titlesLabel];
    [_titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImageView.mas_top).with.offset(-kRealValue(2));
        make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
        make.width.mas_equalTo(kRealValue(233));
    }];
    
    _saleLabel = [[UILabel alloc]init];
    _saleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    _saleLabel.textColor =[UIColor colorWithHexString:@"666666"];
    _saleLabel.text  = @"";
    [bgView addSubview:_saleLabel];
    [_saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY).with.offset(-kRealValue(8));
        make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
    }];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    _priceLabel.textColor =[UIColor colorWithHexString:@"000000"];
    _priceLabel.text  = @"¥171";
    [bgView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(0);
        make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(9));
    }];
    
    _numberLabel = [[UILabel alloc]init];
    _numberLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    _numberLabel.textColor =[UIColor colorWithHexString:@"999999"];
    _numberLabel.text  = @"x1";
    [bgView addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(0);
        make.right.equalTo(bgView.mas_right).with.offset(-kRealValue(10));
    }];
    
    UILabel *LiuyantitleLabel = [[UILabel alloc] init];
    LiuyantitleLabel.text = @"留言";
    LiuyantitleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    LiuyantitleLabel.hidden = YES;
    LiuyantitleLabel.textColor = [UIColor blackColor];
    [self addSubview:LiuyantitleLabel];
    [LiuyantitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kRealValue(160));
        make.left.equalTo(self.mas_left).with.offset(kRealValue(16));
    }];
    
    _textView = [[UILabel alloc]init];
    _textView.frame = CGRectMake(kRealValue(16), kRealValue(175), kRealValue(309), kRealValue(31));
//    _textView.hidden =YES;
    _textView.text = @"We’re always listening to your feedback!!!";
    _textView.hidden =YES;
    _textView.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    _textView.textColor = [UIColor blackColor];
    [self addSubview:_textView];
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(216), kScreenWidth, kRealValue(10))];
    line2.backgroundColor = KColorFromRGB(0xF2F3F5);
    [self.contentView addSubview:line2];
    
    
    [self addSubview:self.prizeView];
    
    UILabel *prizePersonlabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(10), kRealValue(60), kRealValue(20))];
    prizePersonlabel.text =@"中奖好友";
    prizePersonlabel.textAlignment =NSTextAlignmentLeft;
    prizePersonlabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
    [self.prizeView addSubview:prizePersonlabel];
    
    self.prizePersonImage = [[UIImageView alloc]init];
    self.prizePersonImage.backgroundColor = kRandomColor;
    [self.prizeView addSubview:self.prizePersonImage];
    [self.prizePersonImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( prizePersonlabel.mas_bottom).offset(kRealValue(15));
        make.left.equalTo(prizePersonlabel.mas_left).offset(kRealValue(0));
        make.width.height.mas_equalTo(kRealValue(30));
    }];
    self.prizePersonImage.layer.masksToBounds = YES;
    self.prizePersonImage.layer.cornerRadius = kRealValue(15);
    
    self.prizePersonNamelabel = [[UILabel alloc]init];
    self.prizePersonNamelabel .text =@"";
    self.prizePersonNamelabel .textColor = KColorFromRGB(0x000000);
    self.prizePersonNamelabel .textAlignment =NSTextAlignmentLeft;
    self.prizePersonNamelabel .font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
    [self.prizeView addSubview:self.prizePersonNamelabel ];
    [self.prizePersonNamelabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.prizePersonImage.mas_centerY);
        make.left.equalTo(self.prizePersonImage.mas_right).offset(kRealValue(10));
        
    }];
    
    self.prizePersonPricelabel = [[UILabel alloc]init];
     self.prizePersonPricelabel .text =@"竞中价¥201元";
     self.prizePersonPricelabel .textColor = KColorFromRGB(0x666666);
     self.prizePersonPricelabel .textAlignment =NSTextAlignmentLeft;
     self.prizePersonPricelabel .font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
    [self.prizeView addSubview: self.prizePersonPricelabel ];
    [ self.prizePersonPricelabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.prizePersonImage.mas_centerY);
        make.right.equalTo(self.prizeView.mas_right).offset(kRealValue(-16));
        
    }];
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(330), kScreenWidth, kRealValue(10))];
    line3.backgroundColor = KColorFromRGB(0xF2F3F5);
    [self.contentView addSubview:line3];
    
    [self addSubview:self.prizenumView];
    UILabel *prizenumViewlabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(10), kRealValue(60), kRealValue(20))];
    prizenumViewlabel.text =@"参团好友";
    prizenumViewlabel.textAlignment =NSTextAlignmentLeft;
    prizenumViewlabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
    [self.prizenumView addSubview:prizenumViewlabel];
    
    UILabel *prizenumlabel2 = [[UILabel alloc]init];
    prizenumlabel2.text =@"已满员";
    prizenumlabel2.textAlignment =NSTextAlignmentLeft;
    prizenumlabel2.textColor = KColorFromRGB(0xFB3131);
    prizenumlabel2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [self.prizenumView addSubview:prizenumlabel2];
    
    [prizenumlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( self.prizenumView.mas_top).offset(kRealValue(13));
        make.right.equalTo(self.prizenumView.mas_right).offset(kRealValue(-16));
        
    }];
    
    NSInteger locate = kRealValue(15);
    NSInteger pading = kRealValue(8);
    NSInteger Imagewidth = kRealValue(30);
    NSMutableArray *Arr = [dic valueForKey:@"participateUser"];
    NSInteger count = Arr.count > 5?6:Arr.count;
    for (int i = 0; i < count; i ++) {
        UIImageView *prizenumImage = [[UIImageView alloc]init];
        prizenumImage.backgroundColor = kRandomColor;
        
        prizenumImage.frame= CGRectMake(locate + pading * i + Imagewidth*i, kRealValue(47), Imagewidth, Imagewidth);
        if (i == 5) {
            prizenumImage.image = kGetImage(@"ic _ public _ nuuprize");
        }else{
            NSString *Str = [Arr[i] valueForKey:@"userImage"];
            [prizenumImage sd_setImageWithURL:[NSURL URLWithString:Str] placeholderImage:kGetImage(kfailImage)];
        }
        [self.prizenumView addSubview:prizenumImage];
        prizenumImage.layer.masksToBounds = YES;
        prizenumImage.layer.cornerRadius = kRealValue(15);
    }
    
    UIImageView  *prizenumrightIcon = [[UIImageView alloc]init];
    prizenumrightIcon.image= kGetImage(@"ic_public_more");
    
    [self.prizenumView addSubview:prizenumrightIcon];
    
    
    UILabel  *prizenumrighttitle = [[UILabel alloc]init];
    prizenumrighttitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    prizenumrighttitle.textColor = KColorFromRGB(0x999999);
    prizenumrighttitle.textAlignment = NSTextAlignmentLeft;
    prizenumrighttitle.userInteractionEnabled = YES;
    prizenumrighttitle.text =@"查看全部";
    [self.prizenumView addSubview:prizenumrighttitle];
    
    [prizenumrightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.prizenumView.mas_right).offset(kRealValue(-15));
        make.top.equalTo(self.prizenumView.mas_top).offset(kRealValue(52));
        make.width.mas_equalTo(kRealValue(20));
        make.height.mas_equalTo(kRealValue(20));
    }];
    [prizenumrighttitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(prizenumrightIcon.mas_left).offset(kRealValue(18));
        make.top.equalTo(self.prizenumView.mas_top).offset(kRealValue(52));
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(20));
    }];
    
    UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeAllAct)];
    [prizenumrighttitle addGestureRecognizer:tapAct];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(433), kScreenWidth, kRealValue(10))];
    line4.backgroundColor = KColorFromRGB(0xF2F3F5);
    [self.contentView addSubview:line4];
    
    
    [self.contentView addSubview:self.orderView];
    UILabel *orderlabeltitle = [[UILabel alloc]init];
    orderlabeltitle.textAlignment = NSTextAlignmentRight;
    orderlabeltitle.text = @"订单信息";
    orderlabeltitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    orderlabeltitle.textColor = KColorFromRGB(0x000000);
    [self.orderView addSubview:orderlabeltitle];
    
    [orderlabeltitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_top).offset(kRealValue(10));
        make.left.equalTo(self.orderView.mas_left).offset(kRealValue(16));
    }];
    
    
    UILabel *orderlabelnum = [[UILabel alloc]init];
    orderlabelnum.textAlignment = NSTextAlignmentRight;
    orderlabelnum.text = @"订单编号";
    orderlabelnum.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    orderlabelnum.textColor = KColorFromRGB(0x666666);
    [self.orderView addSubview:orderlabelnum];
    
    [orderlabelnum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_top).offset(kRealValue(47));
        make.left.equalTo(self.orderView.mas_left).offset(kRealValue(31));
    }];
    
    
    UILabel *orderlabelfuzhi = [[UILabel alloc]init];
    orderlabelfuzhi.textAlignment = NSTextAlignmentRight;
    orderlabelfuzhi.text = @"复制";
    orderlabelfuzhi.userInteractionEnabled = YES;
    orderlabelfuzhi.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
    orderlabelfuzhi.textColor = KColorFromRGB(0xFF752B);
    [self.orderView addSubview:orderlabelfuzhi];
    
    UITapGestureRecognizer *orderlabelfuzhiAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fuzhiAct)];
    [orderlabelfuzhi addGestureRecognizer:orderlabelfuzhiAct];
    
    
    
    [orderlabelfuzhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_top).offset(kRealValue(47));
        make.right.equalTo(self.orderView.mas_right).offset(-kRealValue(10));
    }];
    
    UIView *orderline = [[UIView alloc]init];
    orderline.backgroundColor = KColorFromRGB(0x666666);
    [self.orderView addSubview:orderline];
    [orderline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_top).offset(kRealValue(47));
        make.right.equalTo(orderlabelfuzhi.mas_left).offset(-kRealValue(10));
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(kRealValue(16));
    }];
    
    self.orderlabelnumtext = [[UILabel alloc]init];
    self.orderlabelnumtext.textAlignment = NSTextAlignmentRight;
    self.orderlabelnumtext.text = [dic valueForKey:@"drawOrderCode"];
    self.orderlabelnumtext.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
    self.orderlabelnumtext.textColor = KColorFromRGB(0x666666);
    [self.orderView addSubview:self.orderlabelnumtext];
    
    [self.orderlabelnumtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_top).offset(kRealValue(47));
        make.right.equalTo(orderline.mas_left).offset(-kRealValue(10));
    }];
    
    
    UILabel *orderlabelgettime = [[UILabel alloc]init];
    orderlabelgettime.textAlignment = NSTextAlignmentRight;
    orderlabelgettime.text = @"领取时间";
    orderlabelgettime.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
    orderlabelgettime.textColor = KColorFromRGB(0x666666);
    [self.orderView addSubview:orderlabelgettime];
    
    [orderlabelgettime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_top).offset(kRealValue(67));
        make.left.equalTo(self.orderView.mas_left).offset(kRealValue(31));
    }];
    
    UILabel *orderlabeltimetext = [[UILabel alloc]init];
    orderlabeltimetext.textAlignment = NSTextAlignmentRight;
    orderlabeltimetext.text = [dic valueForKey:@"drawTime"];
    orderlabeltimetext.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
    orderlabeltimetext.textColor = KColorFromRGB(0x666666);
    [self.orderView addSubview:orderlabeltimetext];
    
    [orderlabeltimetext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_top).offset(kRealValue(67));
        make.right.equalTo(self.orderView.mas_right).offset(-kRealValue(10));
    }];

}
-(void)fuzhiAct
{
    UIPasteboard *copy = [UIPasteboard generalPasteboard];
    [copy setString:self.orderlabelnumtext.text];
    if (copy == nil )
    {
        
        KLToast(@"复制失败")
        
        
    }else{
        KLToast(@"复制成功")
        
        
    }
}
-(void)seeAllAct
{
    if (self.seeAll) {
        self.seeAll();
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
       
    }
    
    return self;
}

-(UIView *)prizenumView
{
    if (!_prizenumView) {
        _prizenumView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(340), kScreenWidth,kRealValue(93))];
        _prizenumView.backgroundColor = [UIColor whiteColor];
        
        
        
        //        UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(47), kScreenWidth, 1/kScreenScale)];
        //        linebg2.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        //        [GoodtrasportView addSubview:linebg2];
        
        
    }
    return _prizenumView;
}
-(UIView *)prizeView
{
    if (!_prizeView) {
        _prizeView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(226), kScreenWidth,kRealValue(93))];
        _prizeView.backgroundColor = [UIColor whiteColor];
        
        
        
        //        UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(47), kScreenWidth, 1/kScreenScale)];
        //        linebg2.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        //        [GoodtrasportView addSubview:linebg2];
        
        
    }
    return _prizeView;
}
-(UIView *)orderView
{
    if (!_orderView) {
        _orderView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(443), kScreenWidth,kRealValue(93))];
        _orderView.backgroundColor = [UIColor whiteColor];
        
        
        
        //        UIView *linebg2 =  [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(47), kScreenWidth, 1/kScreenScale)];
        //        linebg2.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        //        [GoodtrasportView addSubview:linebg2];
        
        
    }
    return _orderView;
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
