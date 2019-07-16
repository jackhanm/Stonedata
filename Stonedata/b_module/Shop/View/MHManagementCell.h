//
//  MHManagementCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/30.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHMyOrderListModel.h"
#import "RichStyleLabel.h"

@interface MHManagementCell : UITableViewCell


@property(strong,nonatomic) UIImageView *leftImageView;

@property(strong,nonatomic) UILabel    *titlesLabel;

@property(strong,nonatomic) UILabel    *dataLabel;

@property(strong,nonatomic) UILabel    *dingdanLabel;

@property(strong,nonatomic) UILabel    *stateLabel;



@property(strong,nonatomic) RichStyleLabel    *priceLabel;

@property(strong,nonatomic) UILabel    *numberLabel;

@property(strong,nonatomic) UILabel *moneyLabel;

@property(strong,nonatomic) UILabel *alllabel;

@property (nonatomic, strong) UIScrollView *activityScroll;

@property(nonatomic, strong) NSArray *ActivityArr;

@property(nonatomic, strong)UIView *bgView;


-(void)createModel:(MHMyOrderListModel *)model;


@end
