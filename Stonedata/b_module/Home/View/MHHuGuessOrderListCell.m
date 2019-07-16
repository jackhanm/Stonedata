//
//  MHHuGuessOrderListCell.m
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHuGuessOrderListCell.h"
#import "MHStartprizeModelOrdersinger.h"
@implementation MHHuGuessOrderListCell

-(void)setPrizemoreModel:(MHStartprizeModelOrdersinger *)prizemoreModel
{
    self.drawnum.hidden =YES;
    self.NowBuy.hidden =YES;
    self.userImagel.hidden =YES;
    self.orderpross.hidden = YES;
    
    self.orderNum.text = [NSString stringWithFormat:@"活动编号:%@",prizemoreModel.shareCode];
    if ([prizemoreModel.status isEqualToString:@"ACTIVE"]) {
        //进行中
        //先判断是胡猜还是奖多多,再判断是发起者还是参与者
        if ([self.comeform isEqualToString:@"hucai"]) {
            if (self.userInfo==1) {
                //参与者
                self.orderStatus.text = @"进行中";
                self.userImagel.hidden =YES;
                self.orderpross.hidden = YES;
                self.drawnum.hidden = NO;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
                
            }else{
                self.orderStatus.text = @"进行中";
                self.userImagel.hidden =YES;
                self.orderpross.hidden = YES;
                self.drawnum.hidden = NO;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
            }
        }else{
            //奖多多
            if (self.userInfo==1) {
                //参与者
                self.orderStatus.text = @"进行中";
                self.userImagel.hidden =YES;
                self.orderpross.hidden = YES;
                self.drawnum.hidden = NO;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
                
            }else{
                self.orderStatus.text = @"进行中";
                self.userImagel.hidden =YES;
                self.orderpross.hidden = YES;
                self.drawnum.hidden = NO;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
            }
        }
        
        
        
    }
    if ([prizemoreModel.status isEqualToString:@"UNOPENED"]) {
        //满员未开奖
        if ([self.comeform isEqualToString:@"hucai"]) {
            if (self.userInfo==1) {
                //参与者
                self.orderStatus.text = @"等待开奖";
                self.userImagel.hidden =YES;
                self.orderpross.hidden = YES;
                self.drawnum.hidden = NO;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
            }else{
                self.orderStatus.text = @"等待开奖";
                self.userImagel.hidden =YES;
                self.orderpross.hidden = YES;
                self.drawnum.hidden = NO;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
            }
        }else{
            //奖多多
            if (self.userInfo==1) {
                //参与者
                
                self.orderStatus.text = @"等待开奖";
                self.userImagel.hidden =YES;
                self.orderpross.hidden = YES;
                self.drawnum.hidden = NO;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
                
            }else{
                
                self.orderStatus.text = @"立即开奖";
                self.userImagel.hidden =YES;
                self.orderpross.hidden = YES;
                self.drawnum.hidden = NO;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
            }
        }
        
    }
    if ([prizemoreModel.status isEqualToString:@"OPENED"]) {
        //已开奖

        if ([self.comeform isEqualToString:@"hucai"]) {
            if (self.userInfo==1) {
                //参与者
                self.orderStatus.text = @"已开奖";
                self.drawnum.hidden = YES;
                self.userImagel.hidden = NO;
                self.orderpross.hidden = NO;
                NSString *imagurl = [NSString stringWithFormat:@"%@",prizemoreModel.winnerUserImage];
                [self.userImagel sd_setImageWithURL:[NSURL URLWithString:imagurl] placeholderImage: kGetImage(@"img_bitmap_fail")];
                self.orderpross.text = [NSString stringWithFormat:@"中奖者:%@",prizemoreModel.winnerUserNickName];
            }else{
                self.orderStatus.text = @"已开奖";
                self.drawnum.hidden = YES;
                self.userImagel.hidden = NO;
                self.orderpross.hidden = NO;
                NSString *imagurl = [NSString stringWithFormat:@"%@",prizemoreModel.winnerUserImage];
                [self.userImagel sd_setImageWithURL:[NSURL URLWithString:imagurl] placeholderImage: kGetImage(@"img_bitmap_fail")];
                self.orderpross.text = [NSString stringWithFormat:@"中奖者:%@",prizemoreModel.winnerUserNickName];
            }
        }else{
            //奖多多
            if (self.userInfo==1) {
                //参与者
                
                self.orderStatus.text = @"已开奖";
                self.drawnum.hidden = YES;
                self.userImagel.hidden = NO;
                self.orderpross.hidden = NO;
                NSString *imagurl = [NSString stringWithFormat:@"%@",prizemoreModel.winnerUserImage];
                [self.userImagel sd_setImageWithURL:[NSURL URLWithString:imagurl] placeholderImage: kGetImage(@"img_bitmap_fail")];
                self.orderpross.text = [NSString stringWithFormat:@"中奖者:%@",prizemoreModel.winnerUserNickName];
                
            }else{
                self.orderStatus.text = @"已开奖";
                self.drawnum.hidden = YES;
                self.userImagel.hidden = NO;
                self.orderpross.hidden = NO;
                NSString *imagurl = [NSString stringWithFormat:@"%@",prizemoreModel.winnerUserImage];
                [self.userImagel sd_setImageWithURL:[NSURL URLWithString:imagurl] placeholderImage: kGetImage(@"img_bitmap_fail")];
                self.orderpross.text = [NSString stringWithFormat:@"中奖者:%@",prizemoreModel.winnerUserNickName];
            }
        }
        
        
        
        
    }
    if ([prizemoreModel.status isEqualToString:@"INVALID"]) {
        //已过期
        
        if ([self.comeform isEqualToString:@"hucai"]) {
            if (self.userInfo==1) {
                //参与者
                self.orderStatus.text = @"已失效";
                self.userImagel.hidden =YES;
                self.orderpross.hidden =YES;
                self.drawnum.hidden = NO;
                self.NowBuy.hidden= YES;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
            }else{
                self.orderStatus.text = @"已失效";
                self.userImagel.hidden =YES;
                self.orderpross.hidden =YES;
                self.drawnum.hidden = NO;
                self.NowBuy.hidden= YES;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
            }
        }else{
            //奖多多
            if (self.userInfo==1) {
                //参与者
                self.orderStatus.text = @"已失效";
                self.userImagel.hidden =YES;
                self.orderpross.hidden =YES;
                self.drawnum.hidden = NO;
                self.NowBuy.hidden= YES;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
                
            }else{
                self.orderStatus.text = @"已失效";
                self.userImagel.hidden =YES;
                self.orderpross.hidden =YES;
                self.drawnum.hidden = NO;
                self.NowBuy.hidden= YES;
                self.drawnum.text = [NSString stringWithFormat:@"进度%@/%@",prizemoreModel.userCount,prizemoreModel.drawNumber];
            }
        }
        
        
        
    }
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:prizemoreModel.productSmallImage] placeholderImage:kGetImage(@"img_bitmap_fail")];
    self.productname.text = [NSString stringWithFormat:@"%@",prizemoreModel.productName];
    self.productPrice.text=[NSString stringWithFormat:@"¥%@",prizemoreModel.productPrice];
    self.ordertimer.text =[NSString stringWithFormat:@"%@",prizemoreModel.shareDateTime];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        [self createview];
    }
    return self;
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
    [self.bgViewImage addSubview:self.userImagel];
    [self.bgViewImage addSubview:self.drawnum];
    [self.bgViewImage addSubview:self.orderpross];
    [self.bgViewImage addSubview:self.NowBuy];
    
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
    
    [self.userImagel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(145));
        make.right.equalTo(self.bgViewImage.mas_right).offset(-kRealValue(10));
        make.width.mas_equalTo(kRealValue(30));
        make.height.mas_equalTo(kRealValue(30));
        
    }];
    self.userImagel.layer.masksToBounds = YES;
    self.userImagel.layer.cornerRadius= kRealValue(15);

    [self.orderpross mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(145));
        make.right.equalTo(self.userImagel.mas_left).offset(-kRealValue(10));
        //make.width.mas_equalTo(kRealValue(80));
        make.height.mas_equalTo(kRealValue(25));
    }];
    
    [self.drawnum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(145));
        make.right.equalTo(self.bgViewImage.mas_right).offset(-kRealValue(10));
    }];

  
    [self.ordertimer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgViewImage.mas_top).offset(kRealValue(150));
        make.left.equalTo(self.bgViewImage.mas_left).offset(kRealValue(10));
    }];
    [self.bgViewImage addSubview:self.NowBuy];
    [self.bgViewImage addSubview:self.drawnum];
 
    self.NowBuy.frame = CGRectMake(kScreenWidth - kRealValue(130), kRealValue(145), kRealValue(80), kRealValue(25));

    self.NowBuy.layer.masksToBounds = YES;
    self.NowBuy.layer.cornerRadius = kRealValue(12);
    
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
        _orderStatus.textColor = KColorFromRGB(0xFF752B);
        
    }
    return _orderStatus;
}
-(UIImageView *)productImage
{
    if (!_productImage) {
        
        _productImage = [[UIImageView alloc]init];
//        _productImage.backgroundColor = kRandomColor;
        
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
-(UILabel *)orderpross
{
    if (!_orderpross) {
        _orderpross = [[UILabel alloc]init];
        _orderpross.text = @"中奖人：能被**有幸";
        _orderpross.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _orderpross.textAlignment = NSTextAlignmentLeft;
        _orderpross.textColor = KColorFromRGB(0x666666);
        
    }
    return _orderpross;
}
-(UILabel *)drawnum
{
    if (!_drawnum) {
        _drawnum = [[UILabel alloc]init];
        _drawnum.text = @"进度8/10";
        _drawnum.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        _drawnum.textAlignment = NSTextAlignmentRight;
        _drawnum.textColor = KColorFromRGB(0x666666);
        
    }
    return _drawnum;
}

-(UIButton *)NowBuy
{
    if (!_NowBuy) {
        _NowBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_NowBuy setTitle:@"立即领取" forState:UIControlStateNormal];
        _NowBuy.backgroundColor = KColorFromRGB(0xFF752B);
        _NowBuy.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        
    }
    return _NowBuy;
}
-(UIImageView *)userImagel
{
    if (!_userImagel) {
        
        _userImagel = [[UIImageView alloc]init];
//        _userImagel.backgroundColor = kRandomColor;
        
    }
    return _userImagel;
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
