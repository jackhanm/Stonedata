//
//  MHFansCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHShopFansModel.h"

@interface MHFansCell : UITableViewCell

@property (nonatomic,strong) UILabel  *titleLabel;

@property (nonatomic,strong) UIImageView  *leftImageView;

@property (nonatomic,strong) UILabel  *footLabel;

@property (nonatomic,strong) UIButton  *selectBtn;


@property (nonatomic,strong) UILabel  *levelLabel;

@property (nonatomic,strong) UILabel  *dataLabel;

@property (nonatomic,strong) UIImageView  *smallImageView;

@property (nonatomic,strong) UIViewController  *cellVC;



-(void)createModel:(MHShopFansModel *)model;

@end
