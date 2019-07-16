//
//  MHMyJoinedViewController.h
//  mohu
//
//  Created by yuhao on 2018/10/17.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
#import "CYLTableViewPlaceHolder.h"
@interface MHMyJoinedViewController : MHBaseViewController
- (instancetype)initWithComeform:(NSString *)comeform;
@property(nonatomic, strong)NSString *comeform;
@end
