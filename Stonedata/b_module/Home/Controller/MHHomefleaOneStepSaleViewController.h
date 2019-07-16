//
//  MHHomefleaOneStepSaleViewController.h
//  mohu
//
//  Created by yuhao on 2019/1/8.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
#import "MHflealistModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHHomefleaOneStepSaleViewController : MHBaseViewController
- (instancetype)initWithmodel:(MHflealistModel *)model;
@property(nonatomic, strong)MHflealistModel *fleamodel;
@end

NS_ASSUME_NONNULL_END
