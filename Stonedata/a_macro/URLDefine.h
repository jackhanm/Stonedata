//
//  URLDefine.h
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#ifndef URLDefine_h
#define URLDefine_h

/**开发环境*/
#define DevelopSever    1
/**生产环境*/
#define ProductSever    0

#if DevelopSever

#define kMHHost @"http://192.168.88.116:8085"
//#define kMHHost @"http://192.168.1.107:8085"
#define kMHHostWAP @"http://192.168.1.107:8085"
#elif ProductSever
#define kMHHost @"https://api.mohuyoupin.com"
#define kMHHostWAP @"https://wap.mohuyoupin.com"
#endif


//商品分类
#define productcategory_v_1 @"/rest/product/category"
//首页商品分类home_
#define home_productcategory_v_1 @"/rest/product/category/index"










//error code h定义

//accessToken不存在或过期，需要进行调用刷新令牌接口
#define kRefreshTokenCode    @"10000"
//refreshToken不存在，需重新授权登录
#define kNoneCode            @"10001"
//refreshToken失效，需重新授权登录
#define kTimeOutCode         @"10002"
//已被踢下线，需重新授权登录
#define kLoginOutCode        @"10005"
//登录接口
#define kLoginUrl  @"/rest/user/login"
//刷新token
#define krefreshUrl  @"/rest/user/token"
//获取短信验证码
#define kgetSendCode  @"/rest/msg/sms/sendCode"
//产品分类
#define kproductType   @"/rest/product/category"
//获取APP页面模块/导航栏
#define kpagecomponent   @"/rest/component/comps"
//全部分类
#define kAllTypesUrl   @"/rest/product/category"
//注册激活
#define kActive     @"/rest/user/active"
#define kThirdPartUrl  @"/rest/user/thirdparty/login"
#define kThirdPartBindUrl  @"/rest/user/thirdparty/bind"
//回调服务器支付结果
#define kWGCallbackHostPayResult @"/rest/trade/notify"
//pre
#define kThirdPartPrebBindUrl  @"/rest/user/thirdparty/pre-bind"
//商品详情
#define kProductId @"/rest/product"
//活动商品详情
#define klimetproduct @"/rest/activity/product"
//热搜
#define kHotSearch @"/rest/product/hot"
//搜索
#define kUserListUrl    @"/rest/user/shop"
//展示最新会员信息
#define kGradeInfo @"/rest/msg/upgrade"
// 商品列表
#define kProductList @"/rest/product/list"
// 优品推荐
#define kgoodRecommend @"/rest/product/type/recommend"
// 商品品牌列表
#define kProductBrandList @"/rest/product/brand"
// 商品评论
#define kCommentList @"/rest/evaluate"
//添加评论
#define kAddComment @"/rest/evaluate/add"
// 收藏/取消收藏商品
#define kProductcollect @"/rest/product/collect"
// 上下架商品
#define kProductupdown @"/rest/product/updown"
//vip商品
#define kVipProd     @"/rest/product/list/vip"
//我的订单
#define kMakeorder @"/rest/order"
//添加商品到购物车
#define kAddshopCar @"/rest/cart"
//修改购物车商品数量
#define kshopCarChange @"/rest/cart/"
//删除购物车商品
#define kshopCarDelete @"/rest/cart/del"
// 购物车商品列表
#define kshopCarList @"/rest/cart"
//获取个人信息列表
#define kUserInfo @"/rest/user/info"
//修改个人信息
#define kChangeUserInfo @"/rest/user/update"
//获取用户收货地址列表
#define kGetUserInfoAdress @"/rest/user/address"
//删除收货地址
#define kdeleteUserInfoAdress @"/rest/user/deladdr"
//设置某个地址为默认收货
#define kdefaultUserInfoAdress @"/rest/user/defaultaddr"
//新增&修改用户收货地址
#define kchangeUserInfoAdress @"/rest/user/address"
//分类推荐模块banner图模块
#define kRecommendbanner @"/rest/product/type/recommend/banner"
//收藏列表
#define kuserColloctList @"/rest/product/list/collect"
// 批量删除我的收藏商品
#define kuserColloctListDelete @"/rest/product/collect/del"
//获取用户提现方式列表
#define kgetUsertxWay @"/rest/user/withdraw"
//删除用户提现方式
#define kdeleteUsertxWay @"/rest/user/delwithdraw"
//添加用户提现方式
#define kAddUsertxWay @"/rest/user/withdraw"
//用户提现
#define kUsertx @"/rest/user/apply"
//活动列表
#define klimitBuyActivityType @"/rest/activity"
//活动商品列表
#define klimitBuyActivityTypeList @"/rest/activity/product"
//奖多多商品列表
#define kPriceMoreActivity @"/rest/draw/prize/product"
//奖多多商品详情
#define kPrizeMoreDetail @"/rest/draw"
//发起奖多多,胡猜订单
#define kStartHucaiOrPrizeMore @"/rest/draw/share/list"
//订单商品详情
#define koderlistdetail @"/rest/draw/share/"
//发起活动
#define kStartActHucaiOrPrizeMore @"/rest/draw/share"
//参与活动
#define kJoinActHucaiOrPrizeMore @"/rest/draw/partake"
//狐猜商品列表
#define kHucaiproductList @"/rest/draw/guess/product"
//参加的订单列表
#define kJoinedproductList @"/rest/draw/partake/list"
//奖品列表
#define kproductList @"/rest/draw/award"
//领取奖品 地址
#define kgetprizewithAress @"/rest/draw/award-info"
//领取奖品 按钮
#define kgetprizehucaiOrPrizeMore @"/rest/draw/draw-award"
//领取奖品 内容
#define kgetprizehucaiOrPrizeMoresure @"/rest/draw/pre-draw"
//领取奖品 确认收货
#define kgetPrizemakesureget @"/rest/draw/confirm-receipt"
//订单默认评价列表
#define kcommentorderList @"/rest/order/comment"
//参加的订单列表
#define kjoinedhucaiorprizemoreList @"/rest/partake/list"
//首页最新购买店主信息
#define kUpgrade  @"/rest/msg/upgrade"
//奖多多开奖
#define kprizeMoreopen  @"/rest/draw/prize"
//App 版本升级
#define KupdateVersion @"/rest/app/version"
//获取消息
#define kGetmessage @"/rest/message/list"
//未读消息数量
#define kGetmessageunread @"/rest/message/unread"
//清除未读消息
#define kcleanmessageunread @"/rest/message/clear-unread"




#define kConfirm  @"/rest/order/confirm"

#define kUserState  @"/rest/user/info"

#define kShopkeeper  @"/rest/shopkeeper"

//任务列表
#define kShoptask    @"/rest/shopkeeper/task"

//资产明细
#define kShopAsset   @"/rest/shopkeeper/asset"
//粉丝统计
#define kShopfansSum   @"/rest/shopkeeper/fans/summary"
//粉丝分页
#define kShopfans     @"/rest/shopkeeper/fans"

#define kShopWithdrawList  @"/rest/user/withdraw"

//经营数据
#define kShoporderList  @"/rest/shopkeeper/fans/order"


//新手专享
#define kHomeNewpeople  @"/rest/activity/index/product"

//新手专享
#define kfansOrderSum  @"/rest/shopkeeper/fans/order/summary"

//提交订单
#define ksumbit  @"/rest/order"

//继续订单
#define kContiPay  @"/rest/order/pay"

//新人专享上部分
#define kNewDesc  @"/rest/component/index/activity"

//新人专享上部分
#define kstoreHome  @"/rest/product/list/shop"


#define kStoreInfo  @"/rest/user/shop/info"

#define kServiceInfo    @"/rest/order/customer-service/reason"

//售后
#define kServiceList    @"/rest/order/customer-service"


#define kwithdrawData    @"/rest/user/money/record"

#define kyaoqingrecord @"/rest/shopkeeper/record/spread"

#define kbangdan       @"/rest/shopkeeper/record/summary"

//开屏广告
#define kLauchImage       @"/rest/component/advertising"

//修改店铺信息
#define kfixShop         @"/rest/user/usershop"

#define kshopmanage      @"/rest/shopkeeper/parent"

#define kshopmanage      @"/rest/shopkeeper/parent"

//回收商品列表
#define kfleashoplist      @"/rest/recover/product"

//一键转卖
#define kfleashopOneStepSale      @"/rest/recover"

//当前拥有
#define kfleashopOneStepSale      @"/rest/recover"
#define ksign             @"/rest/user/sign-in"

#define ksignrule         @"/rest/user/integral/rule"

#define ksignrecord         @"/rest/user/integral/record"


#define kjihuo           @"/rest/user/integral/shopkeeper"

#define kJFActive          @"/rest/user/integral/active"


//转卖记录
#define kfleashopOneSaleRecord      @"/rest/recover/record"


//意见反馈
#define kfeedback   @"/rest/user/advice"


#endif /* URLDefine_h */
