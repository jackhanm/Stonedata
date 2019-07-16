//
//  MHProductDetailPicViewController.h
//  mohu
//
//  Created by 余浩 on 2018/9/22.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MHProductDetailPicViewControllerDelegate <NSObject>

- (void)showNavAddtitle:(CGFloat)offset;


@end
@interface MHProductDetailPicViewController : UIViewController
@property (nonatomic,weak) id<MHProductDetailPicViewControllerDelegate>ProPicViewDelegate;
@property (nonatomic, strong)NSMutableDictionary *dict;
- (instancetype)initWithDic:(NSMutableDictionary *)dic;
@end
