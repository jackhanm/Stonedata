//
//  MHHomefleaOneCell.h
//  mohu
//
//  Created by yuhao on 2019/1/9.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHflealistModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^oneStepSale)(void);
typedef void(^takeNow)(NSInteger type);
@interface MHHomefleaOneCell : UITableViewCell
@property (nonatomic, copy)takeNow TakeNow;
@property (nonatomic, copy)oneStepSale OneStepSale;


@property (nonatomic, strong) UILabel *saleNum;
@property (nonatomic, strong) UILabel *salestatu;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView  *img;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pricelabel;
@property (nonatomic, strong) UILabel *Originpricelabel;
@property (nonatomic, strong) UILabel *salenumlabel;
@property (nonatomic, strong) UIView  *likebg;
@property (nonatomic, strong) UIButton *Buybtn;
@property (nonatomic, strong) UIButton *takebtn;
@property (nonatomic, strong) UIImageView *imagebg;
-(void)createviewWithModel:(MHflealistModel *)model;
@end

NS_ASSUME_NONNULL_END
