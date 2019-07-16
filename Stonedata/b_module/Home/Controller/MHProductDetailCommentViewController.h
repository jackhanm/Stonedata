//
//  MHProductDetailCommentViewController.h
//  mohu
//
//  Created by 余浩 on 2018/9/22.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MHProductDetailCommentViewControllerDelegate <NSObject>

- (void)showNavAddtitle:(CGFloat)offset;


@end
@interface MHProductDetailCommentViewController : UIViewController
@property (nonatomic,weak) id<MHProductDetailCommentViewControllerDelegate>ProCommentViewDelegate;
@property (nonatomic, strong)NSMutableDictionary *dict;
- (instancetype)initWithDic:(NSMutableDictionary *)dic;
@end
