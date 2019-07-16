//
//  MHLevelShareCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHVIPlistScrollview.h"


@interface MHLevelShareCell : UITableViewCell

@property (nonatomic, strong) UISegmentedControl *segment;


@property (strong, nonatomic)  MHVIPlistScrollview *scrollView1;

@property (strong, nonatomic)  MHVIPlistScrollview *scrollView2;

@property (strong, nonatomic)  NSMutableArray  *bangdanArr;

@property (strong, nonatomic)  NSMutableArray *yaoqingArr;
@property (strong, nonatomic)  UIView *bgView;

@end
