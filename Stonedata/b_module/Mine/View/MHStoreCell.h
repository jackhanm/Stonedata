//
//  MHStoreCell.h
//  mohu
//
//  Created by AllenQin on 2018/10/18.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHProductModel.h"
#import "RichStyleLabel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHStoreCell : UITableViewCell

@property (nonatomic, strong) MHProductModel *ProductModel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView  *img;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pricelabel;
@property (nonatomic, strong) RichStyleLabel *richLabel;
@property (nonatomic, strong) UILabel *salenumlabel;
@property (nonatomic, strong) UIView  *likebg;
@property (nonatomic, strong) UIButton *Buybtn;
@property (nonatomic, strong) UIButton *shangjiaBtn;
@property (nonatomic, strong) UIImageView *imagebg;

@property (nonatomic,copy) void(^downClick)(void);



@end

NS_ASSUME_NONNULL_END