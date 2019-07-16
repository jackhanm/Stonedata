//
//  MHMineHeadCell.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^gotomesg)(void);
typedef void(^gotoUserInfo)(void);
@interface MHMineHeadCell : UITableViewCell
@property(nonatomic, strong)UIImageView *bgimageview;
@property(nonatomic, copy)gotomesg Gotomeg;
@property(nonatomic, copy)gotoUserInfo GotoUserInfo;
@property(nonatomic, strong)UIImageView *bgimageSmallview;
@property(nonatomic, strong)UIImageView *headimageview;
@property(nonatomic, strong)UILabel *username;
@property(nonatomic, strong)UIImageView *userleverImage;
@property(nonatomic, strong)UILabel *userlever;

@end
