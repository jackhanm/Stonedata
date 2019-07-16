//
//  MHHomefleaOneCell.m
//  mohu
//
//  Created by yuhao on 2019/1/9.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHHomefleaOneCell.h"

@implementation MHHomefleaOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createview];
    }
    return self;
}
-(void)createview
{
    self.backgroundColor = KColorFromRGB(0xffffff);
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.saleNum];
    [self.bgView addSubview:self.salestatu];
    [self.bgView addSubview:self.img];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.pricelabel];
    [self.bgView addSubview:self.salenumlabel];
   
    [self.bgView addSubview:self.Buybtn];
    [self.bgView addSubview:self.takebtn];
}
-(void)createviewWithModel:(MHflealistModel *)model
{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.productSmallImage] placeholderImage:kGetImage(@"img_bitmap_white")];
    self.titleLabel.text = model.productName;
    
    
    self.pricelabel.text = [NSString stringWithFormat:@"当前拥有%ld件",model.ownCount];
    NSString *Str2 = [NSString stringWithFormat:@"转卖数量：%ld",model.ownCount];
    NSMutableAttributedString *attstring2 = [[NSMutableAttributedString alloc]initWithString:Str2];
    [attstring2 addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xe51c23) range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",model.ownCount].length)];
    [attstring2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontValue(11)] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",model.ownCount].length)];
    self.pricelabel.text = model.winnerTime;
    _salenumlabel.text = [NSString stringWithFormat:@"￥ %@",model.productPrice];
    
    if ([model.orderState isEqualToString:@"UNPAID"]) {
        self.salestatu.text = @"待付款";
        self.salestatu.textColor = KColorFromRGB(0xe2110a);
    }
    if ([model.orderState isEqualToString:@"COMPLETED"]) {
        self.salestatu.text = @"已付款";
        self.salestatu.textColor = KColorFromRGB(0x333333);
    }
    if ([model.orderState isEqualToString:@"RETURN_GOOD"]) {
        self.salestatu.text = @"已过期";
        self.salestatu.textColor = KColorFromRGB(0x999999);
    }
     _saleNum.text = @"";
    self.salestatu.text = @"待领取";
    self.salestatu.textColor = KColorFromRGB(0x333333);

   
    _Originpricelabel.text = [NSString stringWithFormat:@"%@",model.orderTime];
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(194));
        make.width.mas_equalTo(kRealValue(355));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(kRealValue(10));
    }];
    _bgView.layer.cornerRadius = 3;
    
  
    [self.saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.left).offset(kRealValue(16));
        make.top.mas_equalTo(self.bgView.mas_top).offset(kRealValue(12));
    }];
    [self.salestatu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.right).offset(-kRealValue(16));
       make.top.mas_equalTo(self.bgView.mas_top).offset(kRealValue(6));
    }];
    
    UIView *line1= [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(41), kRealValue(355-32), 1/kScreenScale)];
    line1.backgroundColor = KColorFromRGB(0xeee7e7);
    [self addSubview:line1];
    
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(100));
        make.width.mas_equalTo(kRealValue(100));
        make.left.mas_equalTo(self.bgView.left).offset(kRealValue(14));
        make.top.mas_equalTo(self.bgView.mas_top).offset(kRealValue(46));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(kRealValue(10));
        make.top.mas_equalTo(self.bgView.mas_top).offset(kRealValue(52));
        make.right.mas_equalTo(self.mas_right).offset(-kRealValue(30));
    }];
    UIView *line2= [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(168), kRealValue(355-32), 1/kScreenScale)];
    line2.backgroundColor = KColorFromRGB(0xeee7e7);
    [self addSubview:line2];
    
    

    [self.salenumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(10);
        make.bottom.mas_equalTo(self.img.mas_bottom).offset(kRealValue(2));
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.left).offset(kRealValue(16));
        make.top.mas_equalTo(line2.mas_bottom).offset(kRealValue(12));
    }];
    
    [self.Buybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(71));
        make.height.mas_equalTo(kRealValue(22));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-16);
        make.top.mas_equalTo(line2.mas_bottom).offset(kRealValue(7));
    }];
    [self.takebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(71));
        make.height.mas_equalTo(kRealValue(22));
        make.right.mas_equalTo(self.Buybtn.mas_left).offset(-16);
       make.top.mas_equalTo(line2.mas_bottom).offset(kRealValue(7));
    }];
   
    
}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor =[UIColor whiteColor];
    }
    return _bgView;
}
-(UIImageView *)img
{
    if (!_img) {
        _img = [[UIImageView alloc]init];
        //        _img.image =kGetImage(@"poster_01");
        
        _img.backgroundColor =kRandomColor;
    }
    return _img;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _titleLabel.textColor =[UIColor colorWithHexString:@"0x333333"];
        _titleLabel.numberOfLines =2;
      //  _titleLabel.text =@"Apple/苹果 iPhone X 64G 全网通4G 双卡双待无激活码";
        //        _titleLabel.backgroundColor =kRandomColor;
    }
    return _titleLabel;
}

-(UILabel *)saleNum
{
    if (!_saleNum) {
        _saleNum = [[UILabel alloc]initWithFrame:CGRectZero];
        _saleNum.font = [UIFont systemFontOfSize:kFontValue(11)];
        _saleNum.textColor =[UIColor colorWithHexString:@"0x999999"];
        _saleNum.numberOfLines =1;
   //     _saleNum.text = @"交易编号：134613461345";
        
        //        _Originpricelabel.backgroundColor =kRandomColor;
        
    }
    return _saleNum;
}
-(UILabel *)salestatu
{
    if (!_salestatu) {
        _salestatu = [[UILabel alloc]initWithFrame:CGRectZero];
        _salestatu.font = [UIFont systemFontOfSize:kFontValue(14)];
        _salestatu.textColor =[UIColor colorWithHexString:@"0x333333"];
        _salestatu.numberOfLines =1;
     //   _salestatu.text = @"待领取";
        
        //        _Originpricelabel.backgroundColor =kRandomColor;
        
    }
    return _salestatu;
}


-(UILabel *)pricelabel
{
    if (!_pricelabel) {
        _pricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _pricelabel.font = [UIFont systemFontOfSize:kFontValue(11)];
        _pricelabel.textColor =[UIColor colorWithHexString:@"999999"];
        _pricelabel.numberOfLines =1;
    //    _pricelabel.text = @"2018-10-5 13:43:08";
        //        _pricelabel.backgroundColor =kRandomColor;
        
    }
    return _pricelabel;
}

-(UILabel *)salenumlabel
{
    if (!_salenumlabel) {
        _salenumlabel = [[UILabel alloc]init];
        //        _salenumlabel.backgroundColor =kRandomColor;
        _salenumlabel.font = [UIFont fontWithName:kPingFangRegular size:14];
        _salenumlabel.textColor =[UIColor colorWithHexString:@"e51c23"];
        _salenumlabel.numberOfLines =1;
    //    _salenumlabel.text = @"￥4888~5400";
        
        //        _salenumlabel.backgroundColor =kRandomColor;
    }
    return _salenumlabel;
}


-(UIButton *)Buybtn
{
    if (!_Buybtn) {
        _Buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //        [_Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
        //
        [_Buybtn addTarget:self action:@selector(btnAct1) forControlEvents:UIControlEventTouchUpInside];
        _Buybtn.backgroundColor =KColorFromRGB(0xe51c23);
        _Buybtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _Buybtn.layer.cornerRadius = 3;
        [_Buybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Buybtn.userInteractionEnabled = YES;
        [_Buybtn setTitle:@"一键转卖" forState:UIControlStateNormal];
    }
    return _Buybtn;
}
-(void)btnAct1{
    if (self.OneStepSale) {
        self.OneStepSale();
    }
}

-(UIButton *)takebtn
{
    if (!_takebtn) {
        _takebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //        [_Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
        //
        [_takebtn addTarget:self action:@selector(btnAct) forControlEvents:UIControlEventTouchUpInside];
        _takebtn.backgroundColor =KColorFromRGB(0xffffff);
        _takebtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _takebtn.layer.cornerRadius = 3;
        _takebtn.layer.borderWidth = 1/kScreenScale;
        _takebtn.layer.borderColor = KColorFromRGB(0xe51c23).CGColor;
        [_takebtn setTitleColor:KColorFromRGB(0xe51c23) forState:UIControlStateNormal];
        _takebtn.userInteractionEnabled = YES;
        [_takebtn setTitle:@"立即领取" forState:UIControlStateNormal];
    }
    return _takebtn;
}


-(void)btnAct
{
    if (self.TakeNow) {
        self.TakeNow(1);
    }
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
