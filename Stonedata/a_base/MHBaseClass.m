//
//  MHBaseClass.m
//  mohu
//
//  Created by AllenQin on 2018/9/17.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHBaseClass.h"
#import "SDImageCache.h"
#import "Reachability.h"
#import <WebKit/WebKit.h>
#import <JPUSHService.h>

@implementation MHBaseClass

+ (MHBaseClass *)sharedInstance{
    static MHBaseClass *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}


//退出登录
-(void)loginOut{
    
//    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//        
//    } seq:1];
    [GVUserDefaults standardUserDefaults].accessToken = nil;
    [GVUserDefaults standardUserDefaults].refreshToken = nil;
    [GVUserDefaults standardUserDefaults].userRole = nil;
    [GVUserDefaults standardUserDefaults].phone = nil;
    if (@available(iOS 9.0, *)) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    } else {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]){
            [storage deleteCookie:cookie];
        }
        NSURLCache * cache = [NSURLCache sharedURLCache];
        [cache removeAllCachedResponses];
        [cache setDiskCapacity:0];
        [cache setMemoryCapacity:0];
    }
}


- (void)removeAppCatch{
    //清理图片缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
    
    //    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    //    [cache.memoryCache removeAllObjects];
    //    [cache.diskCache removeAllObjects];
    //清理webview cookie
    if (@available(iOS 9.0, *)) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    } else {
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]){
            [storage deleteCookie:cookie];
        }
        NSURLCache * cache = [NSURLCache sharedURLCache];
        [cache removeAllCachedResponses];
        [cache setDiskCapacity:0];
        [cache setMemoryCapacity:0];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}
-(void)presentAlertWithtitle:(NSString *)title message:(NSString *)message leftbutton:(NSString *)leftbutton rightbutton:(NSString *)rightbutton leftAct:(void(^)(void))leftAction rightAct:(void(^)(void))rightAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:leftbutton style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        leftAction();
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:rightbutton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        rightAction();
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    
    //显示弹出框
    
    [ [UIApplication sharedApplication].windows[0].rootViewController presentViewController:alertController animated:YES completion:nil];
    
    
}

-(NSUInteger)isErrorNetWork{
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSUInteger net = 0;
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = 0;
            break;
        case ReachableViaWWAN:
            net = 0;
            break;
        case NotReachable:
            net = 1;
        default:
            break;
            
    }
    return net;
}


-(NSString *)createParamUrl:(NSString *)url param:(NSDictionary *)dict{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];

    if ([url rangeOfString:@"?"].location !=NSNotFound) {
    //&
          return [NSString stringWithFormat:@"%@&params=%@",url,[data base64EncodedStringWithOptions:0]];
        
    }else{
    //?
        return [NSString stringWithFormat:@"%@?params=%@",url,[data base64EncodedStringWithOptions:0]];
    }
}

@end
