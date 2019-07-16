//
//  MHHuGuesscell.m
//  mohu
//
//  Created by yuhao on 2018/10/6.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHuGuesscell.h"

@implementation MHHuGuesscell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createview];
    }
    return self;
}
-(void)createview
{
    self.backgroundColor = KColorFromRGB(0xFE8646);
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.img];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.pricelabel];
    [self.bgView addSubview:self.salenumlabel];
    [self.bgView addSubview:self.Originpricelabel];
    [self.bgView addSubview:self.Buybtn];
    
  
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(120));
        make.width.mas_equalTo(kRealValue(343));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(kRealValue(8));
    }];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(100));
        make.width.mas_equalTo(kRealValue(100));
        make.left.mas_equalTo(self.bgView.left).offset(kRealValue(10));
        make.top.mas_equalTo(self.bgView.mas_top).offset(kRealValue(10));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(kRealValue(10));
        make.top.mas_equalTo(self.mas_top).offset(kRealValue(20));
        make.right.mas_equalTo(self.mas_right).offset(-kRealValue(30));
    }];
    [_Originpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(kRealValue(10));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kRealValue(8));
       
    }];
    
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(10);
        make.bottom.mas_equalTo(self.img.mas_bottom).offset(0);
    }];
    
    

    [self.salenumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(10);
        make.bottom.mas_equalTo(self.pricelabel.mas_top).offset(-kRealValue(2));
    }];
   

   
    [self.Buybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(75));
        make.height.mas_equalTo(kRealValue(30));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.img.mas_bottom).offset(0);
    }];
    //
    ViewRadius(self.Buybtn, kRealValue(4));
    [_bgView shadowPathWith:[UIColor colorWithHexString:@"756A4B" andAlpha:0.15] shadowOpacity:1 shadowRadius:kRealValue(7) shadowSide:MHShadowPathMohu shadowPathWidth:2];

    
//    _salenumlabel.layer.cornerRadius =2;
//    _salenumlabel.layer.borderWidth =1/kScreenScale;
//    _salenumlabel.layer.borderColor= KColorFromRGB(0x689DFF).CGColor;
}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.cornerRadius =10;
        _bgView.backgroundColor =[UIColor whiteColor];
    }
    return _bgView;
}
-(UIImageView *)img
{
    if (!_img) {
        _img = [[UIImageView alloc]init];
        _img.image =kGetImage(@"poster_01");
        
        //        _img.backgroundColor =kRandomColor;
    }
    return _img;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _titleLabel.textColor =[UIColor colorWithHexString:@"0x2b2b2b"];
        _titleLabel.numberOfLines =2;
        _titleLabel.text =@"迪奥（Dior） 克里丝汀迪奥真我香氛 香氛系列 100ml…";
        //        _titleLabel.backgroundColor =kRandomColor;
    }
    return _titleLabel;
}
-(UILabel *)pricelabel
{
    if (!_pricelabel) {
        _pricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _pricelabel.font = [UIFont systemFontOfSize:kFontValue(14)];
        _pricelabel.textColor =[UIColor colorWithHexString:@"e20909"];
        _pricelabel.numberOfLines =1;
        _pricelabel.text = @"¥500-700";
        //        _pricelabel.backgroundColor =kRandomColor;
        
    }
    return _pricelabel;
}
-(UILabel *)Originpricelabel
{
    if (!_Originpricelabel) {
        _Originpricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _Originpricelabel.font = [UIFont systemFontOfSize:11];
        _Originpricelabel.textColor =[UIColor colorWithHexString:@"0x989898"];
        _Originpricelabel.numberOfLines =1;
//        _Originpricelabel.text = @"2.7万人已参团";
        
        //        _Originpricelabel.backgroundColor =kRandomColor;
        
    }
    return _Originpricelabel;
}
-(UILabel *)salenumlabel
{
    if (!_salenumlabel) {
        _salenumlabel = [[UILabel alloc]init];
        //        _salenumlabel.backgroundColor =kRandomColor;
        _salenumlabel.font = [UIFont systemFontOfSize:11];
        _salenumlabel.textColor =[UIColor colorWithHexString:@"e20909"];
        _salenumlabel.numberOfLines =1;
        _salenumlabel.text = @"价格区间";
       
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
        [_Buybtn addTarget:self action:@selector(btnAct) forControlEvents:UIControlEventTouchUpInside];
        _Buybtn.backgroundColor =KColorFromRGB(0xe10a08);
        _Buybtn.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        _Buybtn.userInteractionEnabled = NO;
        [_Buybtn setTitle:@"发起活动" forState:UIControlStateNormal];
    }
    return _Buybtn;
}
-(void)btnAct
{
    if (self.PriceMoregotodetal) {
        self.PriceMoregotodetal();
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
