//
//  MHUserService.h
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^returnBlock)(NSDictionary *response,NSError *error);

@interface MHUserService : NSObject

+ (MHUserService*)sharedInstance;







//登录接口
- (void)initWithLogin:(NSString *)username
                  sms:(NSString *)smsCode
      completionBlock:(returnBlock)block;
//获取短信验证码
-(void)initWithSendCode:(NSString *)phone scene:(NSString *)scene completionBlock:(returnBlock)block;
//产品分类&字分类
-(void)initWithProductTypes:(NSString *)parentId  scene:(NSString *)scene completionBlock:(returnBlock)block;

//获取APP首页页面模块
-(void)initWithPageComponent:(NSString *)scene  completionBlock:(returnBlock)block;
//获取首页分类页面模块
-(void)initWithFirstPageComponent:(NSString *)scene parentTypeId:(NSString *)parentTypeId completionBlock:(returnBlock)block;
//分类推荐模块banner图模块kRecommendbanner
-(void)initWithRecommend:(NSString *)typeId completionBlock:(returnBlock)block;
//展示最新会员信息
-(void)initWithShowUpgradeInfocompletionBlock:(returnBlock)block;
//注册填写邀请码
-(void)initWithActive:(NSString *)accessToken  userYQCode:(NSString *)userYQCode completionBlock:(returnBlock)block;
//全部分类模块
- (void)initWitAllTypesCompletionBlock:(returnBlock)block;
//第三方登录
-(void)initWithThirdLogin:(NSString *)thirdparty
                      uid:(NSString *)uid
                  unionid:(NSString *)unionid
                 nickName:(NSString *)nickName
                   avatar:(NSString *)avatar
          completionBlock:(returnBlock)block;

//第三方绑定手机号
-(void)initWithThirdBindPhone:(NSString *)phone
                      smsCode:(NSString *)smsCode
                   userYQCode:(NSString *)userYQCode
                          uid:(NSString *)uid
                      unionid:(NSString *)unionid
              completionBlock:(returnBlock)block;
//商品详情
-( void)initwithProductId:(NSString *)productId completionBlock:(returnBlock)block;
//活动商品详情
-( void)initwithProductId:(NSString *)productId activityId:(NSString *)activityId beginTime:(NSString *)beginTime endTime:(NSString *)endTime completionBlock:(returnBlock)block;
-( void)initwithHotSearchCompletionBlock:(returnBlock)block;


-( void)initwithUserListName:(NSString *)name pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;
//商品列表
-( void)initwithTypeIdList:(NSString *)TypeId name:(NSString *)name brandId:(NSString *)brandId minPrice:(NSString*)minPrice maxPrice:(NSString *)maxPrice order:(NSString *)order sort:(NSString *)sort pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;
//商品品牌列表
-(void)initWithproductbrandList:(NSString *)typeId completionBlock:(returnBlock)block;

//商品评论列表
-( void)initwithCommentProductId:(NSString *)productId pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;
//收藏/取消收藏商品
-( void)initwithCommentProductId:(NSString *)productId collected:(NSString *)collected  completionBlock:(returnBlock)block;
//上下架商品
-( void)initwithCommentProductId:(NSString *)productId updown:(NSString *)updown  completionBlock:(returnBlock)block;
//添加商品到购物车
-(void)initWithAddShopCartProductId:(NSString *)productId skuId:(NSString *)skuId amount:(NSString *)amount completionBlock:(returnBlock)block;
//购物车商品列表
-(void)initWithShopCartListcompletionBlock:(returnBlock)block;
//删除购物车商品
-(void)initWithDeleteSHopProductId:(NSString *)productIds completionBlock:(returnBlock)block;
//修改购物车商品数量
-(void)initWithShopCartListProductId:(NSMutableArray *)productId amount:(NSString *)amount completionBlock:(returnBlock)block;
//获取个人资料
-(void)initWithUserInfoCompletionBlock:(returnBlock)block;
//我的收藏
-(void)initWithCollectListCompletionBlock:(returnBlock)block;
//批量删除我的收藏商品
-(void)initWithDeleteCollects:(NSString *)Collects completionBlock:(returnBlock)block;

//修改个人资料
-(void)initWithChangeUserInfoupdateType:(NSString *)updateType userNickname:(NSString*)userNickname userImage:(NSString*)userImage openId:(NSString*)openId unionId:(NSString*)unionId originUserPhone:(NSString*)originUserPhone originUserPhoneCode:(NSString*)originUserPhoneCode newUserPhone:(NSString*)newUserPhone newUserPhoneCode:(NSString*)newUserPhoneCode newPayPassword:(NSString*)newPayPassword  newConfirmPassword:(NSString*)newConfirmPassword newPayPasswordCode:(NSString*)newPayPasswordCode isOldPhone:(BOOL)isold CompletionBlock:(returnBlock)block;
// 获取用户收货地址列表
-(void)initWithGetUserAdressInfoCompletionBlock:(returnBlock)block;
//删除收货地址
-(void)initWithdeleteAdressInfoWithaddressId:(NSString *)addressId CompletionBlock:(returnBlock)block;
//设置某个地址为默认收货
-(void)initWithSetDefaultAdressInfoWithaddressId:(NSString *)addressId CompletionBlock:(returnBlock)block;
// 新增&修改用户收货地址
-(void)initWithChangeAdressInfoWithaddressId:(NSString *)addressId userName:(NSString *)userName userPhone:(NSString *)userPhone province:(NSString *)province city:(NSString *)city area:(NSString *)area details:(NSString *)details  addressState:(NSString *)addressState CompletionBlock:(returnBlock)block;

//限时抢购活动title列表
-(void)initWithLitmitBuyactivityType:(NSString *)activityType completionBlock:(returnBlock)block;
//活动商品列表
-(void)initWithLitmitBuyactivityId:(NSString *)activityId beginTime:(NSString *)beginTime endTime:(NSString *)endTime pageSize:( NSInteger )pageSize pageIndex:(NSInteger)pageIndex completionBlock:(returnBlock)block;
//奖多多商品列表
-(void)initWithPriceMorepageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;
//狐猜商品列表
-(void)initWithHucaipageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;

//奖多多详情
-( void)initwithDrawId:(NSString *)DrawId completionBlock:(returnBlock)block;
// 订单商品详情
-( void)initwithlistshareId:(NSString *)shareId completionBlock:(returnBlock)block;
//发起奖多多,胡猜
-( void)initwithStartPrizewithDrawId:(NSString *)DrawId morecompletionBlock:(returnBlock)block;
//奖品列表
-( void)initwithStartPrizewithdrawAllType:(NSString *)drawAllType pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex morecompletionBlock:(returnBlock)block;
//发起的奖多多,胡猜订单列表
-( void)initwithStartOrderListPrizewithdrawAllType:(NSString *)drawAllType pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex morecompletionBlock:(returnBlock)block;
//参加的订单列表
-( void)initwithtackpartInwithdrawAllType:(NSString *)drawAllType pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex morecompletionBlock:(returnBlock)block;
//添加评论
-(void)initAddComment:(NSMutableArray *)evaluateList orderId:(NSString *)orderId completionBlock:(returnBlock)block;
//订单默认评价列表
-(void)initorderCommentListorderId:(NSString *)orderId completionBlock:(returnBlock)block;
//领取奖品内容不带地址
-(void)initorderCommentListwinningId:(NSString *)winningId completionBlock:(returnBlock)block;
//领取奖品内容已填地址
-(void)initorderCommentAddressListwinningId:(NSString *)winningId completionBlock:(returnBlock)block;

//领取奖品按钮
-(void)initorderCommentListwinningId:(NSString *)winningId addressId:(NSString *)addressId completionBlock:(returnBlock)block;
//领取奖品-确认收货
-(void)initgetorderorderCommentListwinningId:(NSString *)winningId completionBlock:(returnBlock)block;
//奖多多开奖
-(void)initwithopenprizeshareId:(NSString *)shareId completionBlock:(returnBlock)block;
//版本升级
-(void)initWithOS:(NSString *)OS channel:(NSString *)channel version:(NSString *)version completionBlock:(returnBlock)block;
//获取消息
-(void)initWithGetMessage:(NSString *)messageCode pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize completionBlock:(returnBlock)block;
//未读消息数量
-(void)initWithGetMessageUnreadtypeCodeList:(NSString *)typeCodeList CompletionBlock:(returnBlock)block;
//清除未读消息
-(void)initWithCleanMessageUnreadtypeCodeList:(NSString *)typeCodeList CompletionBlock:(returnBlock)block;

-( void)initwithVipProductCompletionBlock:(returnBlock)block;

-( void)initwithUpgradeCompletionBlock:(returnBlock)block;

-( void)initwithUserStateCompletionBlock:(returnBlock)block;

-( void)initwithConfirmProduct:(NSArray *)products completionBlock:(returnBlock)block;

-(void)initwithShopkeeperCompletionBlock:(returnBlock)block;

-(void)initwithShopTaskCompletionBlock:(returnBlock)block;

-(void)initwithShopAssets:(NSString *)flowType  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

//粉丝统计
-(void)initWithFansSummary:(NSInteger )userId  relationLevel:(NSInteger )relationLevel CompletionBlock:(returnBlock)block;
//粉丝分页
-(void)initwithShopFans:(NSInteger )relationLevel  userId:(NSInteger )userId  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;
//提现列表
-(void)initwithShopWithDrawListCompletionBlock:(returnBlock)block;
//新增提现
-(void)initwithAddWithdraw:(NSString  *)bankName  cardCode:(NSString  * )cardCode  verifyCode:(NSString  * )verifyCode withdrawType:(NSString  * )withdrawType completionBlock:(returnBlock)block;

-(void)initwithDeleWithdraw:(NSString  *)cardId completionBlock:(returnBlock)block;

-(void)initwithWithdraw:(NSString  *)money  cardId:(NSString  * )cardId  payPassword:(NSString  * )payPassword completionBlock:(returnBlock)block;
//我的订单
-(void)initwithMyorder:(NSString  *)orderState pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;
//经营数据 kShoporderList

-(void)initwithShoporderList:(NSString  *)orderTradeStatus pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block;

-(void)initwithorderDetail:(NSInteger )orderId completionBlock:(returnBlock)block;
-(void)initwithHomeNewbee:(NSString  *)activityId pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

-(void)initwithfansorder:(NSInteger )fansUserId completionBlock:(returnBlock)block;

-(void)initwithCancleorder:(NSInteger )orderId completionBlock:(returnBlock)block;

-(void)initwithShopdingdan:(NSInteger )fansUserId pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block;

-(void)initwithSumitOrder:(NSDictionary *)order completionBlock:(returnBlock)block;

-(void)initwithOkorder:(NSInteger )orderId completionBlock:(returnBlock)block;

-(void)initwithContinuePay:(NSInteger )orderId  payType:(NSString *)payType payPassword:(NSString * )payPassword completionBlock:(returnBlock)block;

-(void)initwithNewbeeDesc:(NSInteger)pid completionBlock:(returnBlock)block;

//我的店铺列表
-(void)initwithStoreHome:(NSString *)userId  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

-(void)initwithStoreInfo:(NSString *)shopId completionBlock:(returnBlock)block;

-(void)initwithHomeCommand:(NSString *)typeId recommend:(NSString *)recommend pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;

-(void)initwithServiceInfo:(NSInteger)orderId  completionBlock:(returnBlock)block;

-(void)initwithServiceList:(NSInteger)orderId  completionBlock:(returnBlock)block;

//售后
-(void)initwithCommitService:(NSInteger)orderId  reason:(NSString * )reason serviceType:(NSString *  )serviceType description:(NSString *  )description images:(NSString *  )images orderCode:(NSString *  )orderCode completionBlock:(returnBlock)block;
//提现记录
-(void)initwithWithDrawDataPageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

//邀请记录
-(void)initwithYaoqingrecordCompletionBlock:(returnBlock)block;

//榜单
-(void)initwithBangdanCompletionBlock:(returnBlock)block;

//开屏广告
-(void)initLaunchADWithCompletionBlock:(returnBlock)block;

//修改店铺信息
-(void)initWithFixShop:(NSString *)shopName shopImage:(NSString *)shopImage shopDesc:(NSString *)shopDesc completionBlock:(returnBlock)block;

-(void)initwithShopManagetCompletionBlock:(returnBlock)block;

//第三方
-(void)initWithThirdPreBindPhone:(NSString *)phone smsCode:(NSString *)smsCode  uid:(NSString *)uid  unionid:(NSString *)unionid completionBlock:(returnBlock)block;

-( void)initwithTypeIdList:(NSString *)recommend pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;
//回收商品列表
-(void)initWithRecoredListpageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;
//一键转卖
-(void)initWithRecoredByIdWithrecoverId:(NSString * )recoverId productCount:(NSString * )productCount completionBlock:(returnBlock)block;
//当前拥有列表
-(void)initWithMYRecoredListpageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;
//转卖记录
-(void)initWithMYRecoredBusNiessListpageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;

//签到
-(void)initGetSignCompletionBlock:(returnBlock)block;

//签到
-(void)initPostSignCompletionBlock:(returnBlock)block;

//积分规则
-(void)initIntegralsCompletionBlock:(returnBlock)block;

-(void)initwithSignRcordList:(NSString  *)recordType pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block;



-(void)initwithJihuoListPageIndex:(NSInteger )pageIndex  pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block;


-(void)initwithJihuoIntegralId:(NSString * )integralId  userId:(NSString * )userId completionBlock:(returnBlock)block;


-(void)initwithJifenActive:(NSString  *)integralMoney  completionBlock:(returnBlock)block;

//回调后台支付结果
-(void)initwithCallBackHostPayResult:(NSString *)orderCode payType:(NSString *)payType CompletionBlock:(returnBlock)block;


-(void)initwithFeedBack:(NSString *)adviceUserPhone adviceContent:(NSString *)adviceContent CompletionBlock:(returnBlock)block;

@end
