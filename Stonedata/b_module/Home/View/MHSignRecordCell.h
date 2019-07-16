//
//  MHSignRecordCell.h
//  mohu
//
//  Created by AllenQin on 2019/1/10.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHSignRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHSignRecordCell : UITableViewCell

@property(strong,nonatomic) UILabel    *titlesLabel;

@property(strong,nonatomic) UILabel    *dataLabel;

@property(strong,nonatomic) UILabel    *stateLabel;


-(void)createModel:(MHSignRecordModel *)model;


@end

NS_ASSUME_NONNULL_END
