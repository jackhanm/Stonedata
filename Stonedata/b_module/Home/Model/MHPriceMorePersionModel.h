//
//  MHPriceMorePersionModel.h
//  mohu
//
//  Created by yuhao on 2018/10/13.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHPriceMorePersionModel : MHBaseModel
//用户昵称
@property (nonatomic, copy)NSString *userNickName;
//用户头像
@property (nonatomic, copy)NSString *userImage;
//用户参团时间
@property (nonatomic, copy)NSString *attendTime;
//用户参团时间
@property (nonatomic, copy)NSString *winningTime;
//用户id
@property (nonatomic, copy)NSString *userId;
@end
