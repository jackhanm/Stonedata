//
//  MHCommentDetailCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/19.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHProductCommentModel.h"
@interface MHCommentDetailCell : UITableViewCell
@property(nonatomic, strong)MHProductCommentModel *model;
@property(nonatomic, strong)UIImageView *head;
@property(nonatomic, strong)UILabel *timelabel;
@property(nonatomic, strong)UILabel *namelabel;
@property(nonatomic, strong)UIImageView *starImageview;
@property(nonatomic, strong)UILabel *commetlabel;
@property(nonatomic, strong)UIImageView *commetPic;
@property(nonatomic, strong)UILabel *productSize;
@end
