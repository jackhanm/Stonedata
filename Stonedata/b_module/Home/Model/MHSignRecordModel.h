//
//  MHSignRecordModel.h
//  mohu
//
//  Created by AllenQin on 2019/1/10.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHSignRecordModel : MHBaseModel

@property (nonatomic, strong) NSString * integralDate;
@property (nonatomic, strong) NSString * integralMoney;
@property (nonatomic, strong) NSString * integralRecordType;
@property (nonatomic, strong) NSString * remark;


@end

NS_ASSUME_NONNULL_END
