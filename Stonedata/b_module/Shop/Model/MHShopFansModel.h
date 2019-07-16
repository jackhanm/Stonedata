//
//  MHShopFansModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/6.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHShopFansModel : MHBaseModel

@property (nonatomic, assign) NSInteger relationLevel;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString * userImage;
@property (nonatomic, strong) NSString * userNickName;
@property (nonatomic, assign) NSInteger userRole;
@property (nonatomic, strong) NSString * userTime;
@property (nonatomic, strong) NSString *userPhone;


@end
