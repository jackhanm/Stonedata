//
//  MHHuGuessDetailViewController.h
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"

@interface MHHuGuessDetailViewController : MHBaseViewController
@property (nonatomic, assign) long resttimer;
@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) NSString *drawId;
@property (nonatomic, strong) NSString *comefrom;
- (instancetype)initWithdrawId:(NSString *)drawId comefrom:(NSString *)comeform;
@end
