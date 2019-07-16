//
//  MHProductDetailCellHeadTwo.h
//  mohu
//
//  Created by yuhao on 2018/10/19.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MHProductDetailCellHeadTapAct)(NSString *productID,NSString *brandID);
@interface MHProductDetailCellHeadTwo : UIView
@property (nonatomic, copy)MHProductDetailCellHeadTapAct selectact;
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel * RightitleLabel;
-(instancetype)initWithFrame:(CGRect)frame  title:(NSString *)title rightTitle:(NSString *)rightTitle isShowRight:(BOOL)isShow;
@end
