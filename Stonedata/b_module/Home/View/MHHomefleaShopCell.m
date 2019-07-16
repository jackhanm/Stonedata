//
//  MHHomefleaShopCell.m
//  mohu
//
//  Created by yuhao on 2019/1/8.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHHomefleaShopCell.h"

@implementation MHHomefleaShopCell
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
    [self.bgView addSubview:self.img];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.pricelabel];
    [self.bgView addSubview:self.salenumlabel];
    [self.bgView addSubview:self.Originpricelabel];
    [self.bgView addSubview:self.Buybtn];
}
-(void)createviewWithModel:(MHflealistModel *)model
{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.productSmallImage] placeholderImage:kGetImage(@"img_bitmap_white")];
    self.titleLabel.text = model.productName;
   
    
    NSString *Str = [NSString stringWithFormat:@"回收数量: %ld/%ld",model.recoveredCount,model.recoverCount];
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
    [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0x000000) range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",model.recoveredCount].length)];
    [attstring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontValue(11)] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",model.recoveredCount].length)];
    self.Originpricelabel.attributedText = attstring;
    self.pricelabel.text = [NSString stringWithFormat:@"当前拥有%ld件",model.ownCount];
    NSString *Str2 = [NSString stringWithFormat:@"当前拥有%ld件",model.ownCount];
    NSMutableAttributedString *attstring2 = [[NSMutableAttributedString alloc]initWithString:Str2];
    [attstring2 addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xe51c23) range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",model.ownCount].length)];
    [attstring2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontValue(11)] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",model.ownCount].length)];
    self.pricelabel.attributedText = attstring2;
    if (!klStringisEmpty(model.recoverPrice)) {
        NSString *Str3 = [NSString stringWithFormat:@"回收价 ￥%@",model.recoverPrice];
        NSMutableAttributedString *attstring3 = [[NSMutableAttributedString alloc]initWithString:Str3];
        [attstring3 addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xe51c23) range:NSMakeRange(4, [NSString stringWithFormat:@"%@",model.recoverPrice].length+1)];
                [attstring3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangMedium size:kFontValue(14)] range:NSMakeRange(4, [NSString stringWithFormat:@"%@",model.recoverPrice].length+1)];
        _salenumlabel.attributedText = attstring3;
    }
   
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(132));
        make.width.mas_equalTo(kRealValue(355));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(kRealValue(10));
    }];
    _bgView.layer.cornerRadius = 3;
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(100));
        make.width.mas_equalTo(kRealValue(100));
        make.left.mas_equalTo(self.bgView.left).offset(kRealValue(14));
        make.top.mas_equalTo(self.bgView.mas_top).offset(kRealValue(16));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(kRealValue(10));
        make.top.mas_equalTo(self.mas_top).offset(kRealValue(24));
        make.right.mas_equalTo(self.mas_right).offset(-kRealValue(30));
    }];
    [_Originpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(kRealValue(10));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kRealValue(3));
        
    }];
    
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(10);
        make.top.mas_equalTo(self.Originpricelabel.mas_bottom).offset(kRealValue(39));
    }];
    
    
    
    [self.salenumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.img.mas_right).offset(10);
        make.bottom.mas_equalTo(self.img.mas_bottom).offset(kRealValue(2));
    }];
    
    
    
    [self.Buybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(71));
        make.height.mas_equalTo(kRealValue(22));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.img.mas_bottom).offset(0);
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
        _titleLabel.numberOfLines =1;
//        _titleLabel.text =@"阳澄湖大闸蟹礼券2888型公......";
        //        _titleLabel.backgroundColor =kRandomColor;
    }
    return _titleLabel;
}
-(UILabel *)Originpricelabel
{
    if (!_Originpricelabel) {
        _Originpricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _Originpricelabel.font = [UIFont systemFontOfSize:kFontValue(11)];
        _Originpricelabel.textColor =[UIColor colorWithHexString:@"0x999999"];
        _Originpricelabel.numberOfLines =1;
//        _Originpricelabel.text = @"回收数量：25/100";
        
        //        _Originpricelabel.backgroundColor =kRandomColor;
        
    }
    return _Originpricelabel;
}
-(UILabel *)pricelabel
{
    if (!_pricelabel) {
        _pricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _pricelabel.font = [UIFont systemFontOfSize:kFontValue(11)];
        _pricelabel.textColor =[UIColor colorWithHexString:@"999999"];
        _pricelabel.numberOfLines =1;
//        _pricelabel.text = @"当前拥有4件";
        //        _pricelabel.backgroundColor =kRandomColor;
        
    }
    return _pricelabel;
}

-(UILabel *)salenumlabel
{
    if (!_salenumlabel) {
        _salenumlabel = [[UILabel alloc]init];
        //        _salenumlabel.backgroundColor =kRandomColor;
        _salenumlabel.font = [UIFont systemFontOfSize:kFontValue(11)];
        _salenumlabel.textColor =[UIColor colorWithHexString:@"e51c23"];
        _salenumlabel.numberOfLines =1;
//        _salenumlabel.text = @"回收价￥4888";
        
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
        _Buybtn.backgroundColor =KColorFromRGB(0xe51c23);
        _Buybtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _Buybtn.layer.cornerRadius = 3;
        [_Buybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Buybtn.userInteractionEnabled = NO;
        [_Buybtn setTitle:@"一键转卖" forState:UIControlStateNormal];
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
