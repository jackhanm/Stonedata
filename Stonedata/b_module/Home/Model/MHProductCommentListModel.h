//
//  MHProductCommentListModel.h
//  mohu
//
//  Created by yuhao on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHProductCommentListModel : MHBaseModel
//评论总数
@property (nonatomic, strong)NSString *totalCount;
//好评率
@property (nonatomic, strong)NSString *rate;
//评论列表
@property (nonatomic, strong)NSMutableArray *CommentArr;
@end
