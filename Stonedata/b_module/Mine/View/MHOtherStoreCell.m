//
//  MHOtherStoreCell.m
//  mohu
//
//  Created by AllenQin on 2018/10/19.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHOtherStoreCell.h"

@implementation MHOtherStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackGroudColor;
        [self createview];
    }
    return self;
}

-(void)createview
{
    [self addSubview:self.bgView];
    [self addSubview:self.imagebg];
    [self.bgView addSubview:self.img];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.pricelabel];
    [self.bgView addSubview:self.richLabel];
    [self.bgView addSubview:self.salenumlabel];
    [self.bgView addSubview:self.Buybtn];
 
    
}


-(void)setProductModel:(MHProductModel *)ProductModel{
    _ProductModel = ProductModel;
    self.titleLabel.text = ProductModel.productName;
    if (ValidStr(ProductModel.productSmallImage)) {
        [self.img sd_setImageWithURL:[NSURL URLWithString:ProductModel.productSmallImage] placeholderImage:kGetImage(@"img_bitmap_long")];
    }else{
        [self.img sd_setImageWithURL:[NSURL URLWithString:ProductModel.productImage] placeholderImage:kGetImage(@"img_bitmap_long")];
    }
    self.pricelabel.text = [NSString stringWithFormat:@"¥ %@",ProductModel.retailPrice];
    self.salenumlabel.text = [NSString stringWithFormat:@"已售%@件",ProductModel.sellCount];
    [_richLabel setAttributedText:[NSString stringWithFormat:@"赚 %@",ProductModel.marketPrice] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"c81f25"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(268));
        make.width.mas_equalTo(kScreenWidth);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(0);
    }];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(175));
        make.width.mas_equalTo(kScreenWidth);
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView.mas_top);
    }];
    
    [self.Buybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(80));
        make.height.mas_equalTo(kRealValue(25));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-kRealValue(15));
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-kRealValue(15));
    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kRealValue(15));
        make.right.mas_equalTo(-kRealValue(15));
        make.top.mas_equalTo(self.img.mas_bottom).offset(kRealValue(10));
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(kRealValue(15));
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-kRealValue(15));
    }];
    [_richLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-kRealValue(17));
        make.left.mas_equalTo(_pricelabel.mas_right).offset(kRealValue(6));
    }];
    
    [self.salenumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(kRealValue(15));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kRealValue(4));
    }];
    
    
    ViewRadius(self.Buybtn, 4);
    
    
    
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
    }
    return _img;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _titleLabel.textColor =[UIColor blackColor];
        
    }
    return _titleLabel;
}
-(UILabel *)pricelabel
{
    if (!_pricelabel) {
        _pricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _pricelabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(16)];
        _pricelabel.textColor =[UIColor colorWithHexString:@"000000"];
        
    }
    return _pricelabel;
}
-(UILabel *)richLabel
{
    if (!_richLabel) {
        _richLabel = [[RichStyleLabel alloc]initWithFrame:CGRectZero];
        _richLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(11)];
        _richLabel.textColor =[UIColor colorWithHexString:@"c81f25"];
        
    }
    return _richLabel;
}
-(UILabel *)salenumlabel
{
    if (!_salenumlabel) {
        _salenumlabel = [[UILabel alloc]init];
        _salenumlabel.font = [UIFont systemFontOfSize:kRealValue(11)];
        _salenumlabel.textColor =[UIColor colorWithHexString:@"858585"];
        _salenumlabel.text = @"已售2345";
    }
    return _salenumlabel;
}

-(UIButton *)Buybtn
{
    if (!_Buybtn) {
        _Buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _Buybtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        [_Buybtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"ff6041"],[UIColor colorWithHexString:@"e81400"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(76), kRealValue(24))] forState:UIControlStateNormal];
        _Buybtn.userInteractionEnabled = NO;
        [_Buybtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    return _Buybtn;
}


@end
