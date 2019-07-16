//
//  MHProductDetailDesCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHProductDescbottomView;
@interface MHProductDetailDesCell : UITableViewCell
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel *labeldetail1;
@property (nonatomic, strong)MHProductDescbottomView *bottomView ;
@end
