//
//  MHSignTableViewCell.h
//  mohu
//
//  Created by AllenQin on 2019/1/7.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichStyleLabel.h"
#import "HQLStepView.h"
#import "ZJAnimationPopView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHSignTableViewCell : UITableViewCell

@property(strong,nonatomic)   RichStyleLabel *priceLabel;

@property(strong,nonatomic)   RichStyleLabel *dayLabel;
@property (nonatomic, strong) NSMutableArray *circleViewArray;
@property (nonatomic, strong) NSMutableArray *titleLabelArray;
@property (nonatomic, strong)HQLStepView    *stepView;
@property (nonatomic, strong) ZJAnimationPopView *popView;
@property (nonatomic,copy) void(^openClick)(NSDictionary *response);

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArr:(NSArray *)arr withIndex:(NSInteger )index withState:(NSInteger) state;




@end

NS_ASSUME_NONNULL_END
