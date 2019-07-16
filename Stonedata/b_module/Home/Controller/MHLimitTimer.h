//
//  MHLimitTimer.h
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseViewController.h"
@class MHLimitbuyListModel;
@protocol MHLimitTimerdelegate<NSObject>
-(void)tableviewdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface MHLimitTimer : MHBaseViewController
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic ,assign)id <MHLimitTimerdelegate> delegate;
- (instancetype)initWithTypeId:(MHLimitbuyListModel *)model;
@end
