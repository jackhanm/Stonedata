//
//  MHUserService.m
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHUserService.h"
#import "MHLoginApi.h"
#import "MHConfirmApi.h"
#import "MHSumbitOrderApi.h"
#import "MHAddCommentApi.h"
#import "MHCommitServiceApi.h"

@implementation MHUserService

+ (MHUserService *)sharedInstance{
    static MHUserService *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}


-(void)initWithLogin:(NSString *)username sms:(NSString *)smsCode completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kLoginUrl baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"account": username,@"smsCode": smsCode}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initWithSendCode:(NSString *)phone scene:(NSString *)scene completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kgetSendCode baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"phone": phone,@"scene": scene}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


-(void)initWitAllTypesCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kAllTypesUrl baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//展示最新会员信息
-(void)initWithShowUpgradeInfocompletionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kGradeInfo baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//产品分类&子分类
-(void)initWithProductTypes:(NSString *)parentId  scene:(NSString *)scene completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kproductType baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"parentId": parentId ,@"scene":scene}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
     
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}

//获取APP首页页面模块
-(void)initWithPageComponent:(NSString *)scene  completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kpagecomponent baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"scene":scene}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}
//获取首页分类页面模块
-(void)initWithFirstPageComponent:(NSString *)scene parentTypeId:(NSString *)parentTypeId completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kpagecomponent baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"scene":scene, @"parentTypeId":parentTypeId}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}




-(void)initWithActive:(NSString *)accessToken userYQCode:(NSString *)userYQCode completionBlock:(returnBlock)block{
    
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    if (ValidStr(userYQCode)) {
        [paraDict setValue:userYQCode forKey:@"userYQCode"];
    }
    
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",kActive,accessToken] baseRequest:YTKRequestMethodPOST isCache:NO   withParam:paraDict];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


- (void)initWithThirdLogin:(NSString *)thirdparty uid:(NSString *)uid unionid:(NSString *)unionid nickName:(NSString *)nickName avatar:(NSString *)avatar completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kThirdPartUrl baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"thirdparty":thirdparty,@"uid":uid,@"unionid":unionid,@"nickName":nickName,@"avatar":avatar}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        block(nil,request.error);
    }];
}

-(void)initWithThirdBindPhone:(NSString *)phone smsCode:(NSString *)smsCode userYQCode:(NSString *)userYQCode uid:(NSString *)uid  unionid:(NSString *)unionid completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kThirdPartBindUrl baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"phone":phone,@"smsCode":smsCode,@"userYQCode":userYQCode,@"uid":uid,@"thirdparty":@"WX",@"unionid":unionid}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}


-(void)initWithThirdPreBindPhone:(NSString *)phone smsCode:(NSString *)smsCode  uid:(NSString *)uid  unionid:(NSString *)unionid completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kThirdPartPrebBindUrl baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"phone":phone,@"smsCode":smsCode,@"uid":uid,@"thirdparty":@"WX",@"unionid":unionid}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}
//商品详情
-( void)initwithProductId:(NSString *)productId completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",kProductId,productId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}
//活动商品详情
-( void)initwithProductId:(NSString *)productId activityId:(NSString *)activityId beginTime:(NSString *)beginTime endTime:(NSString *)endTime completionBlock:(returnBlock)block
{
    NSString *str =[NSString stringWithFormat:@"%@/%@?activityId=%@&beginTime=%@&endTime=%@",klimetproduct,productId,activityId,beginTime,endTime];
//        NSString *str =[NSString stringWithFormat:@"%@/%@?activityId=%@",klimetproduct,productId,activityId];
     NSString *urlString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:urlString baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}
//热搜
-( void)initwithHotSearchCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kHotSearch baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


-( void)initwithUserListName:(NSString *)name pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kUserListUrl baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"name":name,@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//商品列表
-( void)initwithTypeIdList:(NSString *)TypeId name:(NSString *)name brandId:(NSString *)brandId minPrice:(NSString*)minPrice maxPrice:(NSString *)maxPrice order:(NSString *)order sort:(NSString *)sort pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block
{
    NSString *str= [NSString stringWithFormat:@"%@?typeId=%@&name=%@&brandId=%@&minPrice=%@&maxPrice=%@&order=%@&sort=%@&pageIndex=%@&pageSize=%@",kProductList,TypeId,name,brandId,minPrice,maxPrice ,order,sort,pageIndex,pageSize];
     NSString *str1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str1 baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


-( void)initwithTypeIdList:(NSString *)recommend pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block
{
    NSString *str= [NSString stringWithFormat:@"%@?recommend=%@&pageIndex=%@&pageSize=%@",kProductList,recommend,pageIndex,pageSize];
    NSString *str1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str1 baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


//优品推荐
-( void)initwithHomeCommand:(NSString *)typeId recommend:(NSString *)recommend pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block{
    NSString *str= [NSString stringWithFormat:@"%@?typeId=%@&recommend=%@&pageIndex=%@&pageSize=%@",kgoodRecommend,typeId,recommend,pageIndex,pageSize];
    NSString *str1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str1 baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//获取消息
-(void)initWithGetMessage:(NSString *)messageCode pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize completionBlock:(returnBlock)block;
{
    NSString *str =[NSString stringWithFormat:@"%@?typeCode=%@&pageIndex=%@&pageSize=%@",kGetmessage,messageCode,pageIndex,pageSize];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//未读消息数量
-(void)initWithGetMessageUnreadtypeCodeList:(NSString *)typeCodeList CompletionBlock:(returnBlock)block
{
    NSString *str =[NSString stringWithFormat:@"%@?typeCodes=%@",kGetmessageunread,typeCodeList];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//清除未读消息
-(void)initWithCleanMessageUnreadtypeCodeList:(NSString *)typeCodeList CompletionBlock:(returnBlock)block
{
    NSString *str =[NSString stringWithFormat:@"%@",kcleanmessageunread];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{@"typeCodes":typeCodeList}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            block(nil,request.error);
    }];
}

//商品品牌列表
-(void)initWithproductbrandList:(NSString *)typeId completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@?typeId=%@",kProductBrandList,typeId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//我的收藏
-(void)initWithCollectListCompletionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kuserColloctList baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//批量删除我的收藏商品
-(void)initWithDeleteCollects:(NSString *)Collects completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kuserColloctListDelete baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"productIds":Collects}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}
//商品列表
//商品评论列表
-( void)initwithCommentProductId:(NSString *)productId pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block;

{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@?pageSize=%@&pageIndex=%@",kCommentList,productId,pageSize,pageIndex] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//收藏/取消收藏商品
-( void)initwithCommentProductId:(NSString *)productId collected:(NSString *)collected  completionBlock:(returnBlock)block
{
    NSNumber * Membership_Id =  [NSNumber numberWithInt:[collected intValue]];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kProductcollect baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"productId":productId,@"collected":Membership_Id}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}
//上下架商品
-( void)initwithCommentProductId:(NSString *)productId updown:(NSString *)updown  completionBlock:(returnBlock)block
{
    NSNumber * Membership_Id =  [NSNumber numberWithInt:[updown intValue]];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kProductupdown baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"productId":productId,@"updown":Membership_Id  }];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
             block(nil,request.error);
    }];
}
//添加商品到购物车
-(void)initWithAddShopCartProductId:(NSString *)productId skuId:(NSString *)skuId amount:(NSString *)amount completionBlock:(returnBlock)block;
{
    NSNumber * product_id =  [NSNumber numberWithInt:[productId intValue]];
    NSNumber * sku_id =  [NSNumber numberWithInt:[skuId intValue]];
    NSNumber * amount_id =  [NSNumber numberWithInt:[amount intValue]];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kAddshopCar baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"productId":product_id,@"skuId":sku_id ,@"amount":amount_id  }];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}

//购物车商品列表
-(void)initWithShopCartListcompletionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kshopCarList baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}
//修改购物车商品数量
-(void)initWithShopCartListProductId:(NSString *)productId amount:(NSString *)amount completionBlock:(returnBlock)block
{
    NSNumber * product_id =  [NSNumber numberWithInt:[productId intValue]];
    NSNumber * amount_id =  [NSNumber numberWithInt:[amount intValue]];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@%@",kshopCarChange,productId] baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"productId":product_id,@"amount":amount_id  }];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}
//删除购物车商品
-(void)initWithDeleteSHopProductId:(NSString *)productIds completionBlock:(returnBlock)block
{

    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kshopCarDelete baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"ids":productIds}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}
//获取个人资料
-(void)initWithUserInfoCompletionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kUserInfo baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//修改个人资料
-(void)initWithChangeUserInfoupdateType:(NSString *)updateType userNickname:(NSString*)userNickname userImage:(NSString*)userImage openId:(NSString*)openId unionId:(NSString*)unionId originUserPhone:(NSString*)originUserPhone originUserPhoneCode:(NSString*)originUserPhoneCode newUserPhone:(NSString*)newUserPhone newUserPhoneCode:(NSString*)newUserPhoneCode newPayPassword:(NSString*)newPayPassword  newConfirmPassword:(NSString*)newConfirmPassword newPayPasswordCode:(NSString*)newPayPasswordCode isOldPhone:(BOOL)isold CompletionBlock:(returnBlock)block
{
      MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kChangeUserInfo baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"updateType":updateType ,@"userNickname":userNickname, @"userImage":userImage,@"openId":openId, @"unionId":unionId,@"originUserPhone":originUserPhone,@"originUserPhoneCode":originUserPhoneCode,@"newUserPhone":newUserPhone,
        @"newUserPhoneCode":newUserPhoneCode,@"newPayPassword":newPayPassword,@"newConfirmPassword":newConfirmPassword,@"newPayPasswordCode":newPayPasswordCode}];

    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}
// 获取用户收货地址列表
-(void)initWithGetUserAdressInfoCompletionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kGetUserInfoAdress baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//删除收货地址
-(void)initWithdeleteAdressInfoWithaddressId:(NSString *)addressId CompletionBlock:(returnBlock)block
{
    NSNumber * address_id =  [NSNumber numberWithInt:[addressId intValue]];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@?addressId=%@",kdeleteUserInfoAdress,address_id] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//设置某个地址为默认收货
-(void)initWithSetDefaultAdressInfoWithaddressId:(NSString *)addressId CompletionBlock:(returnBlock)block
{
    NSNumber * addressId_Id =  [NSNumber numberWithInt:[addressId intValue]];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kdefaultUserInfoAdress baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"addressId":addressId_Id  }];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}
// 新增&修改用户收货地址
-(void)initWithChangeAdressInfoWithaddressId:(NSString *)addressId userName:(NSString *)userName userPhone:(NSString *)userPhone province:(NSString *)province city:(NSString *)city area:(NSString *)area details:(NSString *)details  addressState:(NSString *)addressState CompletionBlock:(returnBlock)block
{
    if (!klStringisEmpty(addressId) && ![addressId isEqualToString:@"(null)"]) {
        NSNumber * addressId_Id =  [NSNumber numberWithInt:[addressId intValue]];
        MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kchangeUserInfoAdress baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"addressId":addressId_Id ,@"userName":userName, @"userPhone":userPhone,@"province":province, @"city":city,@"area":area,@"details":details,@"addressState":addressState}];
        [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            block([request responseJSONObject],nil);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    block(nil,request.error);
        }];
    }else{
       
        MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kchangeUserInfoAdress baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"addressId":@"" ,@"userName":userName, @"userPhone":userPhone,@"province":province, @"city":city,@"area":area,@"details":details,@"addressState":addressState}];
        [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            block([request responseJSONObject],nil);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    block(nil,request.error);
        }];
    }
    
}


//限时抢购活动列表
-(void)initWithLitmitBuyactivityType:(NSString *)activityType completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@?activityType=%@",klimitBuyActivityType,activityType] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//活动商品列表
-(void)initWithLitmitBuyactivityId:(NSString *)activityId beginTime:(NSString *)beginTime endTime:(NSString *)endTime pageSize:(NSInteger)pageSize pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block
{
    NSString *str = [NSString stringWithFormat:@"%@?activityId=%@&beginTime=%@&endTime=%@&pageSize=%ld&pageIndex=%ld",klimitBuyActivityTypeList,activityId,beginTime,endTime,pageSize,pageIndex];
    NSString *str1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str1 baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//奖多多商品列表
-(void)initWithPriceMorepageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kPriceMoreActivity baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}
//狐猜商品列表
-(void)initWithHucaipageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kHucaiproductList baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


//奖多多详情
-( void)initwithDrawId:(NSString *)DrawId completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",kPrizeMoreDetail,DrawId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
// 订单商品详情
-( void)initwithlistshareId:(NSString *)shareId completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",koderlistdetail,shareId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//发起奖多多,胡猜
-( void)initwithStartPrizewithDrawId:(NSString *)DrawId morecompletionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",kStartActHucaiOrPrizeMore,DrawId] baseRequest:YTKRequestMethodPOST isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}
//奖品列表
-( void)initwithStartPrizewithdrawAllType:(NSString *)drawAllType pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex morecompletionBlock:(returnBlock)block
{
    
    NSString *Str = [NSString stringWithFormat:@"%@?drawAllType=%@&pageSize=%@&pageIndex=%@",kproductList,drawAllType,pageSize,pageIndex];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:Str baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//领取奖品内容
-(void)initorderCommentListwinningId:(NSString *)winningId completionBlock:(returnBlock)block
{
    NSString *Str = [NSString stringWithFormat:@"%@/%@",kgetprizehucaiOrPrizeMoresure,winningId];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:Str baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//领取奖品内容已填地址
-(void)initorderCommentAddressListwinningId:(NSString *)winningId completionBlock:(returnBlock)block
{
    NSString *Str = [NSString stringWithFormat:@"%@/%@",kgetprizewithAress,winningId];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:Str baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//领取奖品按钮
-(void)initorderCommentListwinningId:(NSString *)winningId addressId:(NSString *)addressId completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kgetprizehucaiOrPrizeMore baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"winningId":winningId,@"addressId":addressId}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//领取奖品-确认收货
-(void)initgetorderorderCommentListwinningId:(NSString *)winningId completionBlock:(returnBlock)block;
{
    NSString *str = [NSString stringWithFormat:@"%@/%@",kgetPrizemakesureget,winningId];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"winningId":winningId}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//奖多多开奖
-(void)initwithopenprizeshareId:(NSString *)shareId completionBlock:(returnBlock)block
{
    NSString *str = [NSString stringWithFormat:@"%@/%@",kprizeMoreopen,shareId];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"shareId":shareId}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//发起的奖多多,胡猜订单列表
-( void)initwithStartOrderListPrizewithdrawAllType:(NSString *)drawAllType pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex morecompletionBlock:(returnBlock)block
{
    NSString *Str = [NSString stringWithFormat:@"%@?drawAllType=%@&pageSize=%@&pageIndex=%@",kStartHucaiOrPrizeMore,drawAllType,pageSize,pageIndex];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:Str baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//参加的订单列表
-( void)initwithtackpartInwithdrawAllType:(NSString *)drawAllType pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex morecompletionBlock:(returnBlock)block
{
    NSString *Str = [NSString stringWithFormat:@"%@?drawAllType=%@&pageSize=%@&pageIndex=%@",kJoinedproductList,drawAllType,pageSize,pageIndex];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:Str baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


//添加评论
-(void)initAddComment:(NSMutableArray *)evaluateList orderId:(NSString *)orderId completionBlock:(returnBlock)block
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:evaluateList forKey:@"evaluateList"];
    [dic setObject:orderId forKey:@"orderId"];
    MHAddCommentApi *api = [[MHAddCommentApi alloc]initWithDict:dic];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            block(nil,request.error);
    }];
    
   
}
//订单默认评价列表
-(void)initorderCommentListorderId:(NSString *)orderId completionBlock:(returnBlock)block
{
    NSString *Str = [NSString stringWithFormat:@"%@/%@",kcommentorderList,orderId];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:Str baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}





-(void)initwithVipProductCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kVipProd baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}

-(void)initwithUpgradeCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kUpgrade baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}

-(void)initwithConfirmProduct:(NSArray *)products completionBlock:(returnBlock)block{

    MHConfirmApi *api = [[MHConfirmApi alloc]initWithArr:products];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
         block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        block(nil,request.error);
    }];
}

-(void)initwithUserStateCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kUserState baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initwithShopkeeperCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kShopkeeper baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initwithShopTaskCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kShoptask baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


-(void)initwithShopAssets:(NSString *)flowType  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block{
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    if (ValidStr(flowType)) {
        [paraDict setValue:flowType forKey:@"flowType"];
    }
    [paraDict setValue:@(pageIndex) forKey:@"pageIndex"];
    [paraDict setValue:@(pageSize) forKey:@"pageSize"];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kShopAsset baseRequest:YTKRequestMethodGET isCache:NO   withParam:paraDict];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initWithFansSummary:(NSInteger )userId relationLevel:(NSInteger )relationLevel CompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kShopfansSum baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"userId":@(userId),@"relationLevel":@(relationLevel)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


-(void)initwithShopFans:(NSInteger )relationLevel  userId:(NSInteger )userId  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block{
    
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kShopfans baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"userId":@(userId),@"relationLevel":@(relationLevel),@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}



-(void)initwithShopWithDrawListCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kShopWithdrawList baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


//提现
-(void)initwithWithdraw:(NSString  *)money  cardId:(NSString  * )cardId  payPassword:(NSString  * )payPassword completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kUsertx baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"money":money,@"cardId":cardId,@"payPassword":payPassword}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//删除提现方式
-(void)initwithDeleWithdraw:(NSString  *)cardId completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kdeleteUsertxWay baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"cardId":cardId}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


//新增提现方式
-(void)initwithAddWithdraw:(NSString  *)bankName  cardCode:(NSString  * )cardCode  verifyCode:(NSString  * )verifyCode withdrawType:(NSString  * )withdrawType completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kAddUsertxWay baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"bankName":bankName,@"cardCode":cardCode,@"verifyCode":verifyCode,@"withdrawType":withdrawType}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


-(void)initwithMyorder:(NSString  *)orderState pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kMakeorder baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"orderState":orderState,@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initwithShoporderList:(NSString  *)orderTradeStatus pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kShoporderList baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"orderTradeStatus":orderTradeStatus,@"pageIndex":@(pageIndex)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//订单详情
-(void)initwithorderDetail:(NSInteger )orderId completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%ld",kMakeorder,(long)orderId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//

-(void)initwithHomeNewbee:(NSString  *)activityId pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kHomeNewpeople baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"activityId":activityId,@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}



-(void)initwithfansorder:(NSInteger )fansUserId completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%ld",kfansOrderSum,(long)fansUserId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initwithCancleorder:(NSInteger )orderId completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%ld/cancel",kMakeorder,(long)orderId] baseRequest:YTKRequestMethodPOST isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//

-(void)initwithShopdingdan:(NSInteger )fansUserId pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%ld/order",kShopfans,(long)fansUserId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{@"pageIndex":@(pageIndex)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


-(void)initwithSumitOrder:(NSDictionary *)order completionBlock:(returnBlock)block{
    
    MHSumbitOrderApi *api = [[MHSumbitOrderApi alloc]initWithDict:order];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}
// 分类推荐模块banner图模块
-(void)initWithRecommend:(NSString *)typeId completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@?typeId=%@",kRecommendbanner,typeId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initwithOkorder:(NSInteger )orderId completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%ld/confirm-receipt",kMakeorder,(long)orderId] baseRequest:YTKRequestMethodPOST isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initwithContinuePay:(NSInteger)orderId payType:(NSString *)payType payPassword:(NSString *)payPassword completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kContiPay baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{@"orderId":@(orderId),@"payType":payType,@"payPassword":payPassword}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}



-(void)initwithNewbeeDesc:(NSInteger)pid completionBlock:(returnBlock)block{
    
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kNewDesc baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{@"pId":@(pid)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//我的店铺列表
-(void)initwithStoreHome:(NSString *)userId  pageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block{
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    if (ValidStr(userId)) {
        [paraDict setValue:userId forKey:@"shopId"];
    }
    [paraDict setValue:@(pageIndex) forKey:@"pageIndex"];
    [paraDict setValue:@(pageSize) forKey:@"pageSize"];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kstoreHome baseRequest:YTKRequestMethodGET isCache:NO   withParam:paraDict];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}



-(void)initwithStoreInfo:(NSString *)shopId completionBlock:(returnBlock)block{
        NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    if (ValidStr(shopId)) {
        [paraDict setValue:shopId forKey:@"shopId"];
    }
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kStoreInfo baseRequest:YTKRequestMethodGET isCache:NO   withParam:paraDict];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//售后信息
-(void)initwithServiceInfo:(NSInteger)orderId  completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%ld",kServiceInfo,orderId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//售后列表
-(void)initwithServiceList:(NSInteger)orderId  completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:[NSString stringWithFormat:@"%@/%ld",kServiceList,orderId] baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//版本升级
-(void)initWithOS:(NSString *)OS channel:(NSString *)channel version:(NSString *)version completionBlock:(returnBlock)block
{
    NSString *str = [NSString stringWithFormat:@"%@?os=%@&channel=%@&version=%@",KupdateVersion,OS,channel,version];
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:str baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initwithCommitService:(NSInteger)orderId  reason:(NSString * )reason serviceType:(NSString *  )serviceType description:(NSString *  )description images:(NSString *  )images orderCode:(NSString *  )orderCode completionBlock:(returnBlock)block{
    
    MHCommitServiceApi *api = [[MHCommitServiceApi alloc]initWithDict:@{@"orderId":@(orderId),@"reason":reason,@"serviceType":serviceType,@"description":description,@"images":images,@"orderCode":orderCode}];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                block(nil,request.error);
    }];
}




-(void)initwithWithDrawDataPageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block{

    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kwithdrawData baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{@"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

//

-(void)initwithYaoqingrecordCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kyaoqingrecord baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}

-(void)initwithBangdanCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kbangdan baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}


-(void)initLaunchADWithCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kLauchImage baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}

//

-(void)initWithFixShop:(NSString *)shopName shopImage:(NSString *)shopImage shopDesc:(NSString *)shopDesc completionBlock:(returnBlock)block{
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
    if (ValidStr(shopName)) {
        [paraDict setValue:shopName forKey:@"shopName"];
    }
    if (ValidStr(shopImage)) {
        [paraDict setValue:shopImage forKey:@"shopImage"];
    }
    if (ValidStr(shopDesc)) {
        [paraDict setValue:shopDesc forKey:@"shopDesc"];
    }
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kfixShop baseRequest:YTKRequestMethodPOST isCache:NO   withParam:paraDict];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}


-(void)initwithShopManagetCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kshopmanage baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}

//回收商品列表
-(void)initWithRecoredListpageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kfleashoplist baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}
//一键转卖
-(void)initWithRecoredByIdWithrecoverId:(NSString * )recoverId productCount:(NSString * )productCount completionBlock:(returnBlock)block
{
      MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kfleashopOneStepSale baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{@"recoverId":recoverId,@"productCount":productCount}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}
//当前拥有列表
-(void)initWithMYRecoredListpageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kfleashopOneStepSale baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                block(nil,request.error);
    }];

}
-(void)initGetSignCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:ksign baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}


-(void)initPostSignCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:ksign baseRequest:YTKRequestMethodPOST isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}

-(void)initIntegralsCompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:ksignrule baseRequest:YTKRequestMethodGET isCache:NO   withParam:nil];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //        block(nil,request.error);
    }];
}

-(void)initwithSignRcordList:(NSString  *)recordType pageIndex:(NSInteger )pageIndex completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:ksignrecord baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"recordType":recordType,@"pageIndex":@(pageIndex)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];

    
}
///转卖记录
-(void)initWithMYRecoredBusNiessListpageIndex:(NSInteger )pageIndex pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block
{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kfleashopOneSaleRecord baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];

}

-(void)initwithJihuoListPageIndex:(NSInteger )pageIndex  pageSize:(NSInteger )pageSize completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kjihuo baseRequest:YTKRequestMethodGET isCache:NO   withParam:@{ @"pageIndex":@(pageIndex),@"pageSize":@(pageSize)}];

    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];

}



-(void)initwithJihuoIntegralId:(NSString * )integralId  userId:(NSString * )userId completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kjihuo baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"integralId":integralId,@"userId":userId}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}
//
-(void)initwithJifenActive:(NSString *)integralMoney completionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kJFActive baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"integralMoney":integralMoney}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        block(nil,request.error);
    }];
}
//回调后台支付结果
-(void)initwithCallBackHostPayResult:(NSString *)orderCode payType:(NSString *)payType CompletionBlock:(returnBlock)block
{
    
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kWGCallbackHostPayResult baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"orderCode":orderCode,@"payType":payType}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
    
}

-(void)initwithFeedBack:(NSString *)adviceUserPhone adviceContent:(NSString *)adviceContent CompletionBlock:(returnBlock)block{
    MHBaseRequest *api = [[MHBaseRequest alloc] initWithUrl:kfeedback baseRequest:YTKRequestMethodPOST isCache:NO   withParam:@{ @"adviceUserPhone":adviceUserPhone,@"adviceContent":adviceContent}];
    [api startWithRefreshCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        block([request responseJSONObject],nil);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        block(nil,request.error);
    }];
}



@end
