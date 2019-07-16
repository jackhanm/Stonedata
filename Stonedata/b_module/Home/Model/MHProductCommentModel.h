//
//  MHProductCommentModel.h
//  mohu
//
//  Created by yuhao on 2018/9/27.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHProductCommentModel : MHBaseModel
//用户id
@property (nonatomic, strong)NSString *userId;
//用户昵称
@property (nonatomic, strong)NSString *userNickname;
//评价
@property (nonatomic, strong)NSString *evaluateContent;
//图片
@property (nonatomic, strong)NSString *evaluateImages;
//评价时间
@property (nonatomic, strong)NSString *evaluateTime;
//评分
@property (nonatomic, strong)NSString *evaluateScore1;
//规格属性
@property (nonatomic, strong)NSString *productStandard;
//用户头像
@property (nonatomic, strong)NSString *userImage;


@end
