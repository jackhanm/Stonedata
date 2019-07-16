//
//  MHPageSectionModel.h
//  mohu
//
//  Created by 余浩 on 2018/9/18.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"
@class MHPageItemModel;
@interface MHPageSectionModel : MHBaseModel
@property (nonatomic, strong)NSMutableArray *itemArr;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy)NSString *visible;
@end
