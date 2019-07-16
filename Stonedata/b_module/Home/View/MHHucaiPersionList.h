//
//  MHHucaiPersionList.h
//  mohu
//
//  Created by yuhao on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHHucaiPersionList : UIView
-(void)showView;
-(void)hideView;
@property(nonatomic,strong)NSString *comeform;
@property(nonatomic, strong)NSMutableDictionary * dic;
@property(nonatomic, strong)NSMutableArray *array;
@property(nonatomic, strong)NSString *title;
@end
