//
//  MHHuGuessOrderMyCell.h
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^gotoDetail)(void);
typedef void(^OneSteptakeNow)(NSInteger type);

@interface MHHuGuessOrderMyCell : UITableViewCell

@property (nonatomic, copy)gotoDetail PriceMoregotodetal;
@property (nonatomic, copy)OneSteptakeNow TakeNow;
@property (nonatomic, strong)UIImageView *bgViewImage;
@property (nonatomic, strong)UIView *bgview;
@property (nonatomic, strong)UIImageView *productImage;
@property (nonatomic, strong)UILabel *productname;
@property (nonatomic, strong)UILabel *productsize;
@property (nonatomic, strong)UILabel *productPrice;
@property (nonatomic, strong)UILabel *productCommentTitle;
@property (nonatomic, strong)UILabel *orderNum;
@property (nonatomic, strong)UILabel *orderStatus;
@property (nonatomic, strong)UILabel *ordertimer;
@property (nonatomic, strong)UIButton *NowBuy;
@property (nonatomic, strong)UIButton *takebtn;
-(void)changeview ;

@end
