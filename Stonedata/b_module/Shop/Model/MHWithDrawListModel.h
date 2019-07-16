//
//  MHWithDrawListModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHWithDrawListModel : MHBaseModel

@property (nonatomic, copy) NSString * bankName;
@property (nonatomic, copy) NSString * cardCode;
@property (nonatomic, assign) NSInteger cardId;
@property (nonatomic, assign) NSInteger withdrawType;

@end

NS_ASSUME_NONNULL_END
