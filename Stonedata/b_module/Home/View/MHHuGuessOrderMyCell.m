//
//  MHHuGuessOrderMyCell.m
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHuGuessOrderMyCell.h"

@implementation MHHuGuessOrderMyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)changeview
{
    [self.NowBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(145));
        make.right.equalTo(self.bgViewImage.mas_right).offset(-kRealValue(10));
        make.width.mas_equalTo(kRealValue(80));
        make.height.mas_equalTo(kRealValue(25));
    }];
    
}
-(void)createview
{
    [self addSubview:self.bgViewImage];
    [self.bgViewImage addSubview:self.orderNum];
    [self.bgViewImage addSubview:self.orderStatus];
    [self.bgViewImage addSubview:self.productImage];
    [self.bgViewImage addSubview:self.productname];
    [self.bgViewImage addSubview:self.productPrice];
    [self.bgViewImage addSubview:self.ordertimer];
    [self.bgViewImage addSubview:self.NowBuy];
    [self.bgViewImage addSubview:self.takebtn];
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(10));
        make.left.equalTo(self.bgViewImage.mas_left).offset(kRealValue(10));
    }];
    [self.orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(10));
        make.right.equalTo(self.bgViewImage.mas_right).offset(-kRealValue(10));
    }];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(38), kRealValue(343), 1/kScreenScale)];
    line1.backgroundColor = KColorFromRGB(0xEDEFF0);
    [self.bgViewImage addSubview:line1];

    [self.productImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(50));
        make.left.equalTo(self.bgViewImage.mas_left).offset(kRealValue(10));
        make.width.mas_equalTo(kRealValue(80));
        make.height.mas_equalTo(kRealValue(80));
    }];
    [self.productname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(50));
        make.left.equalTo(self.productImage.mas_right).offset(kRealValue(10));
        make.right.equalTo(self.bgViewImage.mas_right).offset(kRealValue(-20));
    }];
    self.productname.numberOfLines = 0;

    [self.productPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.productImage.mas_bottom).offset(kRealValue(0));
        make.left.equalTo(self.productImage.mas_right).offset(kRealValue(10));
    }];
//
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(138), kRealValue(343), 1/kScreenScale)];
    line2.backgroundColor = KColorFromRGB(0xEDEFF0);
    [self.bgViewImage addSubview:line2];
    
    [self.ordertimer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(150));
        make.left.equalTo(self.bgViewImage.mas_left).offset(kRealValue(10));
    }];

   
    
    [self.takebtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(145));
        make.right.equalTo(self.bgViewImage.mas_right).offset(-kRealValue(10));
        make.width.mas_equalTo(kRealValue(71));
        make.height.mas_equalTo(kRealValue(25));
    }];
    self.takebtn.layer.cornerRadius = kRealValue(5);
    self.takebtn.hidden = YES;
    
    self.NowBuy.layer.masksToBounds = YES;
    self.NowBuy.layer.cornerRadius = kRealValue(5);
    [self.NowBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(71));
        make.height.mas_equalTo(kRealValue(25));
        make.right.mas_equalTo(self.takebtn.mas_left).offset(-16);
        make.top.mas_equalTo(line2.mas_bottom).offset(kRealValue(7));
    }];
    self.NowBuy.hidden = YES;
  
}
-(UIImageView *)bgViewImage
{
    if (!_bgViewImage) {
        
        _bgViewImage = [[UIImageView alloc]init];
        _bgViewImage.frame = CGRectMake(kRealValue(16), kRealValue(10), kScreenWidth-2*kRealValue(16), kRealValue(178));
        _bgViewImage.backgroundColor = [UIColor whiteColor];
        _bgViewImage.layer.masksToBounds = YES;
        _bgViewImage.layer.cornerRadius = 5;
        _bgViewImage.userInteractionEnabled =YES;
        //        _bgViewImage.image = kGetImage(@"back_shadow_evaluate");
        
    }
    return _bgViewImage;
}
-(UILabel *)orderNum
{
    if (!_orderNum) {
        _orderNum = [[UILabel alloc]init];
        _orderNum.text = @"订单编号402592";
        _orderNum.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        _orderNum.textAlignment = NSTextAlignmentLeft;
        _orderNum.textColor = KColorFromRGB(0x666666);
        
    }
    return _orderNum;
}
-(UILabel *)orderStatus
{
    if (!_orderStatus) {
        _orderStatus = [[UILabel alloc]init];
        _orderStatus.text = @"待领取";
        _orderStatus.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _orderStatus.textAlignment = NSTextAlignmentRight;
        _orderStatus.textColor = KColorFromRGB(0x333333);
        
    }
    return _orderStatus;
}
-(UIImageView *)productImage
{
    if (!_productImage) {
        
        _productImage = [[UIImageView alloc]init];
        _productImage.backgroundColor = kRandomColor;
        
    }
    return _productImage;
}
-(UILabel *)productname
{
    if (!_productname) {
        _productname = [[UILabel alloc]init];
        _productname.text = @"SUBLIMAGE香奈儿奢华精萃精华液";
        _productname.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _productname.textAlignment = NSTextAlignmentLeft;
        _productname.textColor = KColorFromRGB(0x000000);
        
    }
    return _productname;
}
-(UILabel *)productsize
{
    if (!_productsize) {
        _productsize = [[UILabel alloc]init];
        _productsize.text = @"";
        _productsize.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _productsize.textAlignment = NSTextAlignmentLeft;
        _productsize.textColor = KColorFromRGB(0x666666);
        
    }
    return _productsize;
}
-(UILabel *)productPrice
{
    if (!_productPrice) {
        _productPrice = [[UILabel alloc]init];
        _productPrice.text = @"¥103";
        _productPrice.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
        _productPrice.textAlignment = NSTextAlignmentLeft;
        _productPrice.textColor = KColorFromRGB(0x000000);
        
    }
    return _productPrice;
}
-(UILabel *)productCommentTitle
{
    if (!_productCommentTitle) {
        _productCommentTitle = [[UILabel alloc]init];
        _productCommentTitle.text = @"评分";
        _productCommentTitle.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _productCommentTitle.textAlignment = NSTextAlignmentLeft;
        _productCommentTitle.textColor = KColorFromRGB(0x000000);
        
    }
    return _productCommentTitle;
}

-(UILabel *)ordertimer
{
    if (!_ordertimer) {
        _ordertimer = [[UILabel alloc]init];
        _ordertimer.text = @"07/29 08:53";
        _ordertimer.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _ordertimer.textAlignment = NSTextAlignmentLeft;
        _ordertimer.textColor = KColorFromRGB(0x666666);
        
    }
    return _ordertimer;
}
-(void)btnAct
{
    if (self.TakeNow) {
        self.TakeNow(1);
    }
}
-(void)btnAct1
{
    if (self.PriceMoregotodetal) {
        self.PriceMoregotodetal();
    }
}
-(UIButton *)NowBuy
{
    if (!_NowBuy) {
        _NowBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_NowBuy setTitle:@"立即领取" forState:UIControlStateNormal];
        _NowBuy.backgroundColor =KColorFromRGB(0xffffff);
        _NowBuy.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _NowBuy.layer.cornerRadius = 3;
        _NowBuy.layer.borderWidth = 1/kScreenScale;
        _NowBuy.layer.borderColor = KColorFromRGB(0xe51c23).CGColor;
        [_NowBuy addTarget:self action:@selector(btnAct1) forControlEvents:UIControlEventTouchUpInside];
        [_NowBuy setTitleColor:KColorFromRGB(0xe51c23) forState:UIControlStateNormal];
        
    }
    return _NowBuy;
}
-(UIButton *)takebtn
{
    if (!_takebtn) {
        _takebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //        [_Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
        //
        [_takebtn addTarget:self action:@selector(btnAct) forControlEvents:UIControlEventTouchUpInside];
        
        
        _takebtn.backgroundColor = KColorFromRGB(0xe51c23);
        _takebtn.userInteractionEnabled = YES;
        _takebtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        [_takebtn setTitle:@"一键转卖" forState:UIControlStateNormal];
    }
    return _takebtn;
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
