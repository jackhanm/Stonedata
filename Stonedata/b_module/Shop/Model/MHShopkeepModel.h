//
//  MHShopkeepModel.h
//  mohu
//
//  Created by AllenQin on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHShopkeepModel : MHBaseModel

@property (nonatomic, copy) NSString * availableBalance;
@property (nonatomic, copy) NSString *directFans;
@property (nonatomic, copy) NSString *indirectFans;
@property (nonatomic, copy) NSString * monthTradeMoney;
@property (nonatomic, copy) NSString * pendingSettlement;
@property (nonatomic, copy) NSString *todayOrderNum;
@property (nonatomic, copy) NSString * todayProfit;
@property (nonatomic, copy) NSString * todayTradeMoney;
@property (nonatomic, copy) NSString * totalCommissionProfit;
@property (nonatomic, copy) NSString * totalSettlement;
@property (nonatomic, copy) NSString * totalSpreadAward;
@property (nonatomic, copy) NSString * totalWithdraw;
@property (nonatomic, copy) NSString * shopName;
@property (nonatomic, copy) NSString * shopkeeperQRCode;
@property (nonatomic, copy) NSString * shopkeeperYQCode;
@property (nonatomic, copy) NSString * userRole;
@property (nonatomic, copy) NSString * shopAvatar;

@end
