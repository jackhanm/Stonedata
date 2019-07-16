//
//  MHProductDetailViewController.h
//  mohu
//
//  Created by AllenQin on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "SGPagingViewPopGestureVC.h"

typedef void(^ProSizeChangeTitle)(NSString *str);
@protocol MHProductDetailViewControllerDelegate <NSObject>

- (void)showNavAddtitle:(CGFloat)offset;
- (void)changeNavTitle:(BOOL)isShow;
- (void)changeskipable:(BOOL)isable;
- (void)ShowAlert;
- (void)showShareAlert;
@end
@interface MHProductDetailViewController : SGPagingViewPopGestureVC
@property (nonatomic, copy)ProSizeChangeTitle changetitle;
@property (nonatomic,weak) id<MHProductDetailViewControllerDelegate>ProDetailViewDelegate;
@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong)NSString *comeform;
@property (nonatomic, strong)NSString *protype;
@property (nonatomic, assign) long resttimer;
- (instancetype)initWithNsmudic:(NSMutableDictionary *)dic  explandDic:(NSMutableDictionary *)explandDic productDetailtype:(NSInteger)productDetailtype;

@end
