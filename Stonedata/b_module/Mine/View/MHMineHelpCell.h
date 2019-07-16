//
//  MHMineHelpCell.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^helpcenter)(void);

@interface MHMineHelpCell : UITableViewCell
@property(nonatomic, copy)helpcenter HelpCenter;
@property(nonatomic, strong)UIImageView *bgimageview;
@property(nonatomic, strong)UIView *bgview;
@end
