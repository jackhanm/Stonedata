//
//  MHSearchUserListVC.h
//  mohu
//
//  Created by AllenQin on 2018/9/26.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
#import "CYLTableViewPlaceHolder.h"

@interface MHSearchUserListVC : MHBaseViewController

@property(copy,nonatomic)NSString *descStr;

-(instancetype)initWithName:(NSString *)name;

@end
