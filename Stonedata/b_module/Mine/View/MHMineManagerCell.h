//
//  MHMineManagerCell.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHMineitemViewTwo.h"

typedef void(^MHMineManagerCelltapact)(NSInteger tag);
@interface MHMineManagerCell : UITableViewCell
@property (nonatomic, copy)MHMineManagerCelltapact tapAct;
@property(nonatomic, strong)UIImageView *bgimageview;
@property(nonatomic, strong)UIView *bgview;
@property(nonatomic, strong)MHMineitemViewTwo * itemview;
@end
