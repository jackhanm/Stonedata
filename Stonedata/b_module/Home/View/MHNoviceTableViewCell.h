//
//  MHNoviceTableViewCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHNoviceTableViewCell : UITableViewCell

@property(strong,nonatomic) UIImageView *leftImageView;

@property(strong,nonatomic) UILabel    *titlesLabel;

@property(strong,nonatomic) UILabel    *saleLabel;

@property(strong,nonatomic) UILabel    *priceLabel;

@property(strong,nonatomic) UILabel    *originalPriceLabel;

@property(strong,nonatomic) UIButton   *goButton;

@end
