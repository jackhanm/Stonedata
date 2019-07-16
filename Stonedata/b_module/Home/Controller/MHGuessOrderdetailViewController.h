//
//  MHGuessOrderdetailViewController.h
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"

@interface MHGuessOrderdetailViewController : MHBaseViewController
-(instancetype)initWithwinningId:(NSString *)winningId comefrom:(NSString *)comeform statu:(NSString*)statu;
@property(nonatomic, strong)NSString * winningId;
@property (nonatomic, strong)NSString *comefrom;
@property (nonatomic, strong)NSString *statu;
@property (nonatomic, strong)UIView *shuline;
@property (nonatomic, strong)UILabel *EMSfuzhi;
@property (nonatomic, strong)UIImageView *EMSimage;
@end
