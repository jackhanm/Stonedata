//
//  MHProDetailViewController.h
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHProDetailViewController : MHBaseViewController
@property (nonatomic, strong)NSString *productId;
@property (nonatomic, assign)NSInteger productdetailTYpe;
@property (nonatomic, assign)long resttime;
@property (nonatomic, strong)NSString *comeform;
@property (nonatomic, strong)NSString *beginTime;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, strong)NSString *activityId;
@end
