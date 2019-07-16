//
//  MHflealistModel.h
//  mohu
//
//  Created by yuhao on 2019/1/10.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHflealistModel : MHBaseModel
@property (nonatomic, strong) NSString * recoverId;
@property (nonatomic, strong) NSString * productId;
@property (nonatomic, strong) NSString * skuId;
@property (nonatomic, strong) NSString * productName;
@property (nonatomic, strong) NSString * productCount;
@property (nonatomic, strong) NSString * productPrice;
@property (nonatomic, strong) NSString * productSmallImage;
@property (nonatomic, strong) NSString * productStandard;
@property (nonatomic, assign) NSInteger recoverCount;
@property (nonatomic, assign) NSInteger recoveredCount;
@property (nonatomic, strong) NSString * recoverPrice;
@property (nonatomic, assign) NSInteger  ownCount;
@property (nonatomic, strong) NSString * drawOrderCode;
@property (nonatomic, strong) NSString * winnerTime;
@property (nonatomic, assign) NSInteger  winningId;
@property (nonatomic, assign) NSInteger winningType;
@property (nonatomic, assign) NSInteger * recoverOrderId;
@property (nonatomic, strong) NSString * recoverOrderCode;
//UNPAID：未付款，COMPLETED：已付款，RETURN_GOOD：已退回
@property (nonatomic, strong) NSString * orderState;
@property (nonatomic, strong) NSString * orderPrice;
@property (nonatomic, strong) NSString * orderTime;
@end

NS_ASSUME_NONNULL_END
