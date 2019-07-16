//
//  HQLStepView.h
//  mohu
//
//  Created by AllenQin on 2019/1/7.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQLStepView : UIView

// 指定初始化方法
- (instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray *)titlesArray stepIndex:(NSUInteger)stepIndex;

// 设置当前步骤
- (void)setStepIndex:(NSUInteger)stepIndex animation:(BOOL)animation;



@end
