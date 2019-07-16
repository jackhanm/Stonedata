//
//  MHLimitbuyListModel.h
//  mohu
//
//  Created by yuhao on 2018/10/4.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHLimitbuyListModel : MHBaseModel
//id
@property (nonatomic, strong)NSString *id;
//活动名
@property (nonatomic, copy)NSString *name;
//活动开始时间
@property (nonatomic, copy)NSString *beginTime;
//活动结束时间
@property (nonatomic, copy)NSString *endTime;
//活动规则
@property (nonatomic, copy)NSString *ruleType;
//活动规则
@property (nonatomic, copy)NSString *loading;

@end
