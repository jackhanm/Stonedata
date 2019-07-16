//
//  MHHuGuessOrderListCell.h
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHStartprizeModelOrdersinger;
@interface MHHuGuessOrderListCell : UITableViewCell
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
@property (nonatomic, strong)UILabel *orderpross;
@property (nonatomic, strong)UIImageView *userImagel;
@property (nonatomic, strong)UIButton *NowBuy;
@property (nonatomic, strong)UILabel *drawnum;
@property (nonatomic, strong)MHStartprizeModelOrdersinger *prizemoreModel;
@property (nonatomic, strong)NSString *comeform;
//1. 参与 0 发起
@property (nonatomic, assign)NSInteger userInfo;

@end
