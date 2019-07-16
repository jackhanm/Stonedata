//
//  MHHuGuesscell.h
//  mohu
//
//  Created by yuhao on 2018/10/6.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^gotoDetail)(void);
@interface MHHuGuesscell : UITableViewCell
@property (nonatomic, copy)gotoDetail PriceMoregotodetal;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView  *img;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pricelabel;
@property (nonatomic, strong) UILabel *Originpricelabel;
@property (nonatomic, strong) UILabel *salenumlabel;
@property (nonatomic, strong) UIView  *likebg;
@property (nonatomic, strong) UIButton *Buybtn;
@property (nonatomic, strong) UIImageView *imagebg;
@end
