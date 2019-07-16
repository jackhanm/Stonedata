//
//  MHOrderItemView.h
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHOrderItemView : UIView
-(id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr imageHeight:(NSInteger )imageheight;
-(id)initWithFrame:(CGRect)frame title:(NSString *)title subtitle:(NSString *)subtitle imageHeight:(NSInteger )imageheight;
@property (nonatomic, strong)UILabel *titleLable;
@property (nonatomic, strong)UILabel *subtitle;
@end
