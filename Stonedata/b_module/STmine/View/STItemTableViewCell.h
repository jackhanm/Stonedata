//
//  STItemTableViewCell.h
//  Stonedata
//
//  Created by yuhao on 2019/7/15.
//  Copyright © 2019 hf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^seeAllorder)(void);
typedef void(^seeorderWithType)(NSInteger type);
@interface STItemTableViewCell : UITableViewCell
@property (nonatomic, copy)seeAllorder seeall;
@property (nonatomic, copy)seeorderWithType seeorderWithtype;
@end

NS_ASSUME_NONNULL_END
