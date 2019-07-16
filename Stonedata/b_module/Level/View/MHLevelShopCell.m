//
//  MHLevelShopCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHLevelShopCell.h"

@implementation MHLevelShopCell

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
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.sectionView];
    [self.sectionView addSubview:self.bgView];
    [self.bgView addSubview:self.img];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.pricelabel];
    [self.bgView addSubview:self.Buybtn];
}


-(void)setProductModel:(MHShopCarProductModel *)ProductModel{
     _ProductModel = ProductModel;
    self.titleLabel.text = ProductModel.productName;
    self.pricelabel.text = [NSString stringWithFormat:@"¥%@",ProductModel.retailPrice];
    [self.img sd_setImageWithURL:[NSURL URLWithString:ProductModel.productSmallImage] placeholderImage:nil];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(228));
        make.width.mas_equalTo(kRealValue(355));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(0);
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(218));
        make.width.mas_equalTo(kRealValue(335));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(_sectionView.mas_top).offset(kRealValue(1));
    }];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(139));
        make.width.mas_equalTo(kRealValue(335));
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.mas_top).offset(0);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(kRealValue(10));
        make.right.mas_equalTo(-kRealValue(10));
        make.top.mas_equalTo(self.img.mas_bottom).offset(kRealValue(10));
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(kRealValue(10));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kRealValue(15));
    }];
    [self.Buybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kRealValue(74));
        make.height.mas_equalTo(kRealValue(22));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-kRealValue(10));
        make.bottom.mas_equalTo(self.pricelabel.mas_bottom).offset(0);
    }];
    
    ViewRadius(self.Buybtn, 3);
    ViewBorderRadius(_bgView, kRealValue(6), 1, [UIColor colorWithHexString:@"fff4f4"]);

    
//    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kRealValue(5), kRealValue(5))];
//    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
//    maskLayer1.frame = self.bounds;
//    maskLayer1.path = maskPath1.CGPath;
//    self.layer.mask = maskLayer;
//    self.backgroundColor = [UIColor whiteColor];

}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor =[UIColor colorWithHexString:@"#fff4f4"];
    }
    return _bgView;
}

-(UIView *)sectionView{
    if (!_sectionView) {
        _sectionView = [[UIView alloc]init];
        _sectionView.backgroundColor =[UIColor whiteColor];
    }
    return _sectionView;
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
        _titleLabel.font = [UIFont systemFontOfSize:kFontValue(14)];
        _titleLabel.textColor =[UIColor colorWithHexString:@"000000"];
    }
    return _titleLabel;
}
-(UILabel *)pricelabel
{
    if (!_pricelabel) {
        _pricelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _pricelabel.font = [UIFont systemFontOfSize:kFontValue(17)];
        _pricelabel.textColor =[UIColor colorWithHexString:@"e10901"];
        
    }
    return _pricelabel;
}

-(UIButton *)Buybtn
{
    if (!_Buybtn) {
        _Buybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Buybtn setBackgroundColor:[UIColor colorWithHexString:@"d8031f"]];
        _Buybtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _Buybtn.userInteractionEnabled = NO;
        
        if ([GVUserDefaults standardUserDefaults].accessToken) {
            if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
                [_Buybtn setTitle:@"立即购买" forState:UIControlStateNormal];
            }else{
                [_Buybtn setTitle:@"立即分享" forState:UIControlStateNormal];
            }
            
        }else{
            [_Buybtn setTitle:@"立即购买" forState:UIControlStateNormal];
        }
    
     
    }
    return _Buybtn;
}



@end
