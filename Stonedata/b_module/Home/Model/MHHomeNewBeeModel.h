//
//  MHHomeNewBeeModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHHomeNewBeeModel : MHBaseModel

@property (nonatomic, assign) NSInteger activityId;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, strong) NSString * marketPrice;
@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, strong) NSString * productImage;
@property (nonatomic, strong) NSString * productName;
@property (nonatomic, strong) NSString * retailPrice;


@end

NS_ASSUME_NONNULL_END
