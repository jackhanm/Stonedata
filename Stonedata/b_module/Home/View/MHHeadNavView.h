//
//  MHHeadNavView.h
//  mohu
//
//  Created by 余浩 on 2018/9/19.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^goback)(NSString *productID);
typedef void(^goshare)(NSString *productID);
@interface MHHeadNavView : UIView
@property (nonatomic, copy)goback backblock;
@property (nonatomic, copy)goshare goshareblock;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong)UIButton *rightButton;
/*
 *初始化方法,height是白色区域的高度
 */
-(instancetype)initWithFrame:(CGRect)frame height:(NSInteger)height title:(NSString *)title;
/*
 *初始化方法,给数据
 */
@end
