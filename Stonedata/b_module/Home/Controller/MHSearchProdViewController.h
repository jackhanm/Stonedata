//
//  MHSearchProdViewController.h
//  mohu
//
//  Created by AllenQin on 2018/9/18.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
#import "CYLTableViewPlaceHolder.h"

@interface MHSearchProdViewController : MHBaseViewController


-(instancetype)initWithName:(NSString *)name;

@property(copy,nonatomic)NSString *descStr;

@end
