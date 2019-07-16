//
//  MHGuessOrderDetailCell.h
//  mohu
//
//  Created by yuhao on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^seeAllAlert)(void);
@interface MHGuessOrderDetailCell : UITableViewCell
@property(nonatomic, copy)seeAllAlert seeAll;
@property(strong,nonatomic) UIImageView *leftImageView;

@property(strong,nonatomic) UILabel    *titlesLabel;

@property(strong,nonatomic) UILabel    *saleLabel;

@property(strong,nonatomic) UILabel    *priceLabel;

@property(strong,nonatomic) UILabel    *numberLabel;

@property(strong,nonatomic) NSDictionary   *dataDict;

@property(strong,nonatomic) UILabel *textView;

@property(strong, nonatomic)UIView *prizeView;
@property(strong, nonatomic)UIView *prizenumView;
@property(strong, nonatomic)UIView *orderView;
@property(strong,nonatomic)NSMutableDictionary *dic;
@property(strong,nonatomic) UIImageView *prizePersonImage;
@property(strong,nonatomic) UILabel *prizePersonNamelabel;
@property(strong,nonatomic)UILabel *prizePersonPricelabel;
@property(strong,nonatomic)UILabel *prizenumlabel2;
@property(nonatomic, strong)UILabel *orderlabelnumtext;
@end
