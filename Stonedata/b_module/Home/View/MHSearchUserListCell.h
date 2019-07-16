//
//  MHSearchUserListCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/26.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHUserListModel.h"

@interface MHSearchUserListCell : UITableViewCell

@property (nonatomic,strong) MHUserListModel  *userListModel;

@property (nonatomic,strong) UILabel  *titleLabel;

@property (nonatomic,strong) UIImageView  *leftImageView;

@property (nonatomic,strong) UILabel  *footLabel;

@property (nonatomic,strong) UIButton  *selectBtn;


@end
