//
//  MHProductShareView.h
//  mohu
//
//  Created by 余浩 on 2018/9/22.
//  Copyright © 2018年 AllenQin. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MHProductShareView : UIView

@property (nonatomic, strong)NSMutableDictionary *dict;
@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong)NSString * comefrom;
@property (nonatomic, strong)NSString *shareId;
@property (nonatomic, strong)UIViewController * superVC;

@property (nonatomic,copy) void(^hidenClick)();
- (instancetype)initWithFrame:(CGRect)frame dict:(NSMutableDictionary *)dict dic:(NSMutableDictionary *)dic comefrom:(NSString *)comeform shareId:(NSString *)shareId;

@end
