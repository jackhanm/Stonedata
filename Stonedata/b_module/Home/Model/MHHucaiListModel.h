//
//  MHHucaiListModel.h
//  mohu
//
//  Created by yuhao on 2018/10/15.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHHucaiListModel : MHBaseModel
//场次信息
@property(nonatomic, copy)NSString * roundName;
@property(nonatomic, strong)NSMutableArray *listrArr;
@end
