//
//  HQLStepView.m
//  mohu
//
//  Created by AllenQin on 2019/1/7.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "HQLStepView.h"

// 步骤条主题色
#define TINT_COLOR [UIColor colorWithRed:1.000 green:0.396 blue:0.514 alpha:1.00]

@interface HQLStepView ()

@property (nonatomic, copy) NSArray *titlesArray;
@property (nonatomic, assign) NSUInteger stepIndex;

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSMutableArray *circleViewArray;
@property (nonatomic, strong) NSMutableArray *titleLabelArray;
//@property (nonatomic, strong) UILabel *indicatorLabel;

@end

@implementation HQLStepView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray *)titlesArray stepIndex:(NSUInteger)stepIndex {
    self = [super initWithFrame:frame];
    if (self) {
        _titlesArray = [titlesArray copy];
        _stepIndex = stepIndex;
        
        // 进度条
        [self addSubview:self.progressView];
        
        for (NSString *title in _titlesArray) {
            
            // 圆圈
            UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(26),  kRealValue(26))];
            circle.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
            circle.layer.cornerRadius =  kRealValue(13);
            [self addSubview:circle];
            [self.circleViewArray addObject:circle];
            
            // 标题
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kRealValue(26),  kRealValue(26))];
            label.textColor = [UIColor whiteColor];
            label.text = [NSString stringWithFormat:@"+%@",title];
            label.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
            label.textAlignment = NSTextAlignmentCenter;
            [circle addSubview:label];
            [self.titleLabelArray addObject:label];
        }
        
        // 当前索引数字
//        [self addSubview:self.indicatorLabel];
    }
    return self;
}

// 布局更新页面元素
- (void)layoutSubviews {
    NSInteger perWidth = self.frame.size.width / self.titlesArray.count;
    
    // 进度条
    self.progressView.frame = CGRectMake(0, 0, self.frame.size.width - perWidth, 1);
    self.progressView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 4);
    
    CGFloat startX = self.progressView.frame.origin.x;
    for (int i = 0; i < self.titlesArray.count; i++) {
        // 圆圈
        UIView *cycle = self.circleViewArray[i];
        if (cycle) {
            cycle.center = CGPointMake(i * perWidth + startX, self.progressView.center.y);
        }
        
        // 标题
        UILabel *label = self.titleLabelArray[i];
        if (label) {
         cycle.center = CGPointMake(i * perWidth + startX, self.progressView.center.y);
        }
    }
    self.stepIndex = self.stepIndex;
}

#pragma mark - Custom Accessors

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor = TINT_COLOR;
        if (_stepIndex == -1) {
            _progressView.progress = 0;
        }else{
            _progressView.progress = self.stepIndex / ((self.titlesArray.count - 1) * 1.0);
        }

    }
    return _progressView;
}

//- (UILabel *)indicatorLabel {
//    if (!_indicatorLabel) {
//        _indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
//        _indicatorLabel.textColor = TINT_COLOR;
//        _indicatorLabel.textAlignment = NSTextAlignmentCenter;
//        _indicatorLabel.backgroundColor = [UIColor whiteColor];
//        _indicatorLabel.layer.cornerRadius = 23.0f / 2;
//        _indicatorLabel.layer.borderColor = [TINT_COLOR CGColor];
//        _indicatorLabel.layer.borderWidth = 1;
//        _indicatorLabel.layer.masksToBounds = YES;
//    }
//    return _indicatorLabel;
//}

- (NSMutableArray *)circleViewArray {
    if (!_circleViewArray) {
        _circleViewArray = [[NSMutableArray alloc] initWithCapacity:self.titlesArray.count];
    }
    return _circleViewArray;
}

- (NSMutableArray *)titleLabelArray {
    if (!_titleLabelArray) {
        _titleLabelArray = [[NSMutableArray alloc] initWithCapacity:self.titlesArray.count];
    }
    return _titleLabelArray;
}

// 设置当前进度索引，更新圆形图片、文本颜色、当前索引数字
- (void)setStepIndex:(NSUInteger)stepIndex {
    
    if (stepIndex == -1) {
        for (int i = 0; i < self.titlesArray.count; i++) {
            UIView *cycle = self.circleViewArray[i];
            UILabel *label = self.titleLabelArray[i];
            cycle.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
            label.textColor = [UIColor whiteColor];
        }
    }else{
        for (int i = 0; i < self.titlesArray.count; i++) {
            UIView *cycle = self.circleViewArray[i];
            UILabel *label = self.titleLabelArray[i];
            if (stepIndex >= i) {
                cycle.backgroundColor = TINT_COLOR;
                label.textColor = [UIColor whiteColor];
            } else {
                cycle.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
                label.textColor = [UIColor whiteColor];
            }
        }
    }
}

#pragma mark - Public

- (void)setStepIndex:(NSUInteger)stepIndex animation:(BOOL)animation {
    if (stepIndex < self.titlesArray.count) {
        // 更新颜色
        self.stepIndex = stepIndex;
        // 设置进度条
        [self.progressView setProgress:stepIndex / ((self.titlesArray.count - 1) * 1.0) animated:animation];
        // 设置当前索引数字
//        self.indicatorLabel.text = [NSString stringWithFormat:@"%lu", stepIndex + 1];
//        self.indicatorLabel.center = ((UIView *)[self.circleViewArray objectAtIndex:stepIndex]).center;
    }
}

@end
