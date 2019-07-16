//
//  MHMineProductCommentController.h
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"

@interface MHMineProductCommentController : MHBaseViewController
- (instancetype)initWithorderId:(NSString *)orderId;
@property(nonatomic, strong)NSString *oderdID;
@end
