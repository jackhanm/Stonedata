//
//  MHJHCell.h
//  mohu
//
//  Created by AllenQin on 2019/1/10.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHJFModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHJHCell : UITableViewCell

@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)UIButton *titleBtn;

@property(strong,nonatomic)UIImageView *leftImageView;

@property(strong,nonatomic)UILabel *descLabel;

@property(strong,nonatomic)MHJFModel *jfModel;


@end

NS_ASSUME_NONNULL_END
