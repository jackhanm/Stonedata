//
//  MHLevelShopCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHShopCarProductModel.h"

@interface MHLevelShopCell : UITableViewCell

@property (nonatomic, strong) MHShopCarProductModel *ProductModel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UIImageView  *img;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pricelabel;
@property (nonatomic, strong) UIButton *Buybtn;

@end
