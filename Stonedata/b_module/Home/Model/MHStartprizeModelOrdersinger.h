//
//  MHStartprizeModelOrdersinger.h
//  mohu
//
//  Created by yuhao on 2018/10/15.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHStartprizeModelOrdersinger : MHBaseModel
//用户参与时间
@property (nonatomic, strong)NSString *winnerTime;
//中奖用户id
@property (nonatomic, strong)NSString *winnerUserId;
//中奖用户头像
@property (nonatomic, strong)NSString *winnerUserImage;
//中奖用户昵称
@property (nonatomic, strong)NSString *winnerUserNickName;
//分享id
@property (nonatomic, strong)NSString *shareId;
//发起的时间
@property (nonatomic, strong)NSString *shareDateTime;
//商品名称
@property (nonatomic, strong)NSString *productName;
//商品价格
@property (nonatomic, strong)NSString *productPrice;
//活动编号
@property (nonatomic, strong)NSString *shareCode;
//ACTIVE：进行中，UNOPENED：满员未开奖，OPENED：已开奖，INVALID：已过期
//1:待开奖，2：未中奖，3：未领取，4：确认收货，5：已完成，6：已失效
@property (nonatomic, strong)NSString *status;
//开奖人数
@property (nonatomic, strong)NSString *drawNumber;
//参与人数
@property (nonatomic, strong)NSString *userCount;
//商品小图
@property (nonatomic, strong)NSString *productSmallImage;
//商品小图
@property (nonatomic, strong)NSString *drawId;
//中奖记录id
@property (nonatomic, strong)NSString *winningId;
//商品小图
@property (nonatomic, strong)NSString *shareUserId;
//物流状态
@property (nonatomic, strong)NSString *expressStatus;
//订单编号
@property (nonatomic, strong)NSString *drawOrderCode;

@end
