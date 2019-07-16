//
//  MHMineUserCommentCell.h
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHOrderCommentList.h"

typedef void(^choosetext)(NSInteger index);
typedef void(^choosescrollnum)(NSInteger count);
@interface MHMineUserCommentCell : UITableViewCell

@property (nonatomic, strong)choosetext Choosetext;
@property (nonatomic, strong)choosescrollnum Choosescrollnum;
@property (nonatomic, strong)UIImageView *bgViewImage;
@property (nonatomic, strong)UIView *bgview;
@property (nonatomic, strong)UIImageView *productImage;
@property (nonatomic, strong)UILabel *productname;
@property (nonatomic, strong)UILabel *productsize;
@property (nonatomic, strong)UILabel *productPrice;
@property (nonatomic, strong)UILabel *productCommentTitle;
@property (nonatomic, strong)MHOrderCommentList *model;

@end
