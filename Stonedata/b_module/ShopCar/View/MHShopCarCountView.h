//
//  MHShopCarCountView.h
//  mohu
//
//  Created by 余浩 on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopCarCountViewEditBlock)(NSInteger count);
@interface MHShopCarCountView : UIView
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;
@property (nonatomic, strong) UILabel *editTextField;
@property (nonatomic, assign) NSInteger bigcount;
@property(nonatomic, copy) ShopCarCountViewEditBlock shopcarCountViewEditBlock;
- (void)configureShopcartCountViewWithProductCount:(NSInteger)productCount productStock:(NSInteger)productStock;
@end
