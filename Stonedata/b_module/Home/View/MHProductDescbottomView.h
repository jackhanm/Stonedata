//
//  MHProductDescbottomView.h
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHProductDescbottomView : UIView
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel * RightitleLabel;
-(instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title rightTitle:(NSString *)rightTitle isShowRight:(BOOL)isShow;
@end
