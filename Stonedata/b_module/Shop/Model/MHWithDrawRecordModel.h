//
//  MHWithDrawRecordModel.h
//  mohu
//
//  Created by AllenQin on 2018/10/16.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHWithDrawRecordModel : MHBaseModel

@property (nonatomic, assign) CGFloat money;
@property (nonatomic, assign) NSInteger orderId;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSArray * progress;
@property (nonatomic, strong) NSString * recordName;
@property (nonatomic, strong) NSString * takeDate;
@property (nonatomic, strong) NSString * takeState;
@property (nonatomic, strong) NSString * takeTime;
@property (nonatomic, strong) NSString * takeTypeCode;
@property (nonatomic, strong) NSString * takeTypeName;


@end

NS_ASSUME_NONNULL_END
