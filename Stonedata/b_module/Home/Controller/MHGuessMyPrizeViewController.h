//
//  MHGuessMyPrizeViewController.h
//  mohu
//
//  Created by yuhao on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"

@interface MHGuessMyPrizeViewController : MHBaseViewController
@property (nonatomic, strong)NSString *winningId;
@property (nonatomic, strong)NSString *comefrom;
- (instancetype)initWithwinningId:(NSString *)winningId comefrom:(NSString *)comeform;

@end
