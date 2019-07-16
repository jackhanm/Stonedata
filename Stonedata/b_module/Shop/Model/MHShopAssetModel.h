//
//  MHShopAssetModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/1.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHShopAssetModel : MHBaseModel

@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * createDate;
@property (nonatomic, strong) NSString * desc;
@property (nonatomic, copy) NSString * money;
@property (nonatomic, copy) NSString * orderCode;
@property (nonatomic, assign) NSInteger orderId;
@property (nonatomic, assign) NSInteger type;


@end
