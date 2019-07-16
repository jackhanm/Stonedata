//
//  MHExtensionCell.h
//  mohu
//
//  Created by AllenQin on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHShopkeepModel.h"

@interface MHExtensionCell : UITableViewCell

@property(strong,nonatomic)MHShopkeepModel *shopModel;

@property(strong,nonatomic)UIViewController *superVC;

@end
