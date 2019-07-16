//
//  MHMineOrderCell.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^seeAllorder)(void);
typedef void(^seeorderWithType)(NSInteger type);
@interface MHMineOrderCell : UITableViewCell
@property (nonatomic, copy)seeAllorder seeall;
@property (nonatomic, copy)seeorderWithType seeorderWithtype;
@property(nonatomic, strong)UIImageView *bgimageview;
@property(nonatomic, strong)UIView *bgview;
@property(nonatomic, strong)UILabel *alltitle;
@property(nonatomic, strong)UILabel *righttitle;
@property(nonatomic, strong)UIImageView *rightIcon;
@end
