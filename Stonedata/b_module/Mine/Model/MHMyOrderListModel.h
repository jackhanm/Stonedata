//
//  MHMyOrderListModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMyOrderListModel : MHBaseModel

@property (nonatomic, strong) NSString * orderCommissionProfit;
@property (nonatomic, strong) NSString * commissionProfit;
@property (nonatomic, strong) NSString * createDate;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * orderCode;
@property (nonatomic, strong) NSString * orderDiscountPrice;
@property (nonatomic, strong) NSString * orderTruePrice;
@property (nonatomic, assign) NSInteger orderId;
@property (nonatomic, strong) NSString *orderState;
@property (nonatomic, strong) NSString *orderType;
@property (nonatomic, assign) NSInteger totalProducts;
@property (nonatomic, strong) NSString * orderTradeState;
@property (nonatomic, strong) NSArray * products;

@end

NS_ASSUME_NONNULL_END
