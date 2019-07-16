//
//  MHAppDelegate+AppService.m
//  mohu
//
//  Created by AllenQin on 2018/8/14.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHAppDelegate+AppService.h"
#import "MHHomeViewController.h"
#import "YTKNetworkConfig.h"
#import "AvoidCrash.h"
#import <Bugly/Bugly.h>
#import "CTUUID.h"
#import "MHTabbarManager.h"
#import "STloginViewController.h"

#import "MHUrlArgumentsFilter.h"
#import <UMCommonLog/UMCommonLogHeaders.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMShare/UMShare.h>
#import "UIImage+Common.h"
#import "AFNetworking.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JPFPSStatus.h"
#import "MHPayClass.h"
#import "MHLauchImageModel.h"
#import "MHWebviewViewController.h"
#import "MHProDetailViewController.h"
#import "MHPriceMoreViewController.h"
#import "MHHuGuessViewController.h"
#import "MHScrollViewController.h"

@implementation MHAppDelegate (AppService)

-(void)initService{
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange
                                               object:nil];
    [self monitorNetworkStatus];
}

-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    //去除nav下面线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//    [[UIButton appearance] setExclusiveTouch:YES];
    
}


-(void)initThridPartConfig{
    
    [GVUserDefaults standardUserDefaults].ShowAppUpdateAlert =@"Yes";
    [GVUserDefaults standardUserDefaults].ShowAppUpdateWithCode = @"Yes";
    [GVUserDefaults standardUserDefaults].ShowBreakStatuWithCode = @"Yes";
    [Bugly startWithAppId:MHConfigBuglyAPPKey];
    [UMConfigure initWithAppkey:MHConfigUmengAPPKey channel:@"App Store"];
    [UMConfigure setLogEnabled:YES];
    [MobClick setScenarioType:E_UM_NORMAL];
    //网络初始化
    YTKNetworkConfig *networkConfig = [YTKNetworkConfig sharedConfig];
    
    networkConfig.baseUrl = kMHHost;
    MHUrlArgumentsFilter *urlFilter = [MHUrlArgumentsFilter filterWithArguments:@{@"appId": @"a2",@"appVer":[CTUUID getAppVersion],@"deviceId":[CTUUID getIDFA],@"phoneBrand":@"iPhone",@"osChannel":@"Appstore"}];
    [networkConfig addUrlFilter:urlFilter];
    [AvoidCrash becomeEffective];
    
    
   
}


+ (MHAppDelegate *)shareAppDelegate{
    return (MHAppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)setupLauchAD{
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    [XHLaunchAd setWaitDataDuration:2];
    [[MHUserService sharedInstance]initLaunchADWithCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (ValidDict(response[@"data"])) {
                MHLauchImageModel *model = [MHLauchImageModel baseModelWithDic:response[@"data"]];
                XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
                imageAdconfiguration.duration = 5;
                imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.window.bounds.size.height);
                if (isiPhoneX) {
                    imageAdconfiguration.imageNameOrURLString = model.bigImg;
                }else{
                     imageAdconfiguration.imageNameOrURLString = model.normalImg;
                }
                imageAdconfiguration.GIFImageCycleOnce = NO;
                imageAdconfiguration.openModel = model;
                imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
                imageAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
                imageAdconfiguration.showFinishAnimateTime = 0.8;
                imageAdconfiguration.skipButtonType = SkipTypeTimeText;
                imageAdconfiguration.showEnterForeground = NO;
                [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
            }
        }
    }];
}


- (void)createRootSrollViewController{
    
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:[NSString stringWithFormat:@"%@guide",[CTUUID getAppVersion]]];
    __block  MHScrollViewController *scrollVC  = [[MHScrollViewController alloc]init];
    scrollVC.goHomeBlock  =^(){
        scrollVC = nil;
        [self initNoHavenLauchAdRoot];
        if ([GVUserDefaults standardUserDefaults].accessToken == nil) {
            if ([GVUserDefaults standardUserDefaults].isPrivacy) {
                STloginViewController *login = [[STloginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                UITabBarController *tabBarController = (UITabBarController *)kRootViewController;
                [tabBarController.selectedViewController presentViewController:userNav animated:YES completion:nil];
                
            }
        }
    };
    [self.window setRootViewController:scrollVC];
    [self.window makeKeyAndVisible];
}



-(void)initNoHavenLauchAdRoot{
    //根视图
    MHTabbarManager *tabBarControllerConfig = [[MHTabbarManager alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    [self.window setRootViewController:tabBarController];
    tabBarController.delegate = self;
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
            tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarController.viewControllers[2].tabBarItem.title = @"升级店主";
        }else{
            tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarController.viewControllers[2].tabBarItem.title = @"店主";
        }
        [[MHUserService sharedInstance]initwithUserStateCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [GVUserDefaults standardUserDefaults].phone =  [NSString stringWithFormat:@"%@",response[@"data"][@"userPhone"]];
                if ( [GVUserDefaults standardUserDefaults].userRole !=  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]]) {
                    [GVUserDefaults standardUserDefaults].userRole =  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
                        tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                        tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                        tabBarController.viewControllers[2].tabBarItem.title = @"升级店主";
                    }else{
                        tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                        tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                        tabBarController.viewControllers[2].tabBarItem.title = @"店主";
                    }
                }
                
            }
        }];
    }else{
        [[MHBaseClass sharedInstance]loginOut];
        tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarController.viewControllers[2].tabBarItem.title = @"升级店主";
    }
    

    
}



-(void)initTabbarRootViewController{
    
    //开屏广告
    [self setupLauchAD];
    //根视图
    MHTabbarManager *tabBarControllerConfig = [[MHTabbarManager alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    [self.window setRootViewController:tabBarController];
    tabBarController.delegate = self;
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
            tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarController.viewControllers[2].tabBarItem.title = @"升级店主";
        }else{
            tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarController.viewControllers[2].tabBarItem.title = @"店主";
        }
        [[MHUserService sharedInstance]initwithUserStateCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [GVUserDefaults standardUserDefaults].phone =  [NSString stringWithFormat:@"%@",response[@"data"][@"userPhone"]];
                if ( [GVUserDefaults standardUserDefaults].userRole !=  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]]) {
                    [GVUserDefaults standardUserDefaults].userRole =  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
                        tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                        tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                        tabBarController.viewControllers[2].tabBarItem.title = @"升级店主";
                    }else{
                        tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                        tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                        tabBarController.viewControllers[2].tabBarItem.title = @"店主";
                    }
                }
                
            }
        }];
    }else{
        [[MHBaseClass sharedInstance]loginOut];
        tabBarController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarController.viewControllers[2].tabBarItem.title = @"升级店主";
    }
    

}


- (void)initLoginRootViewController{
    STloginViewController *logoVC = [[STloginViewController alloc]init];
    UINavigationController *logoNav = [[UINavigationController alloc]initWithRootViewController:logoVC];
    [self.window setRootViewController:logoNav];
}
-(void)initWeChatConfig{

#pragma mark  umeng share
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:MHConfigWeChatAPPID appSecret:MHConfigWeChatAPPSecret redirectURL:@"http://china-mohu.com"];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
         [[MHPayClass sharedApi]handleOpenURL:url];
    }
    return result;
}

#pragma  mark -- UITabBarDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ((tabBarController.viewControllers[2] == viewController)||(tabBarController.viewControllers[2] == viewController)) {
        if ([GVUserDefaults standardUserDefaults].accessToken) {
            return YES;
        }else{
            STloginViewController *login = [[STloginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [tabBarController.selectedViewController presentViewController:userNav animated:YES completion:nil];
            return NO;
        }
    }else
        return YES;
    
}

- (void)monitorNetworkStatus{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                KPostNotification(KNotificationNetWorkStateChange, @NO);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
        }
    }];
     [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification{
    
    BOOL isNetWork = [notification.object boolValue];
    if (!isNetWork) {
        KLToast(@"网络状态不佳");
    }
}


-(void)initHotSearch{
    //search
    [[MHUserService sharedInstance]initwithHotSearchCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [GVUserDefaults standardUserDefaults].hotSearchArr = response[@"data"];
        }
    }];
    
}

-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint{
    
    MHLog(@"广告点击事件");
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if(openModel == nil)  return;
        MHLauchImageModel *model  = openModel;
    
        UITabBarController *tabBarController = (UITabBarController *)kRootViewController;
        UINavigationController *rootVC = tabBarController.selectedViewController;
        if (model.actionUrlType == 0) {
            //web
            MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:model.actionUrl comefrom:@"LauchImage"];
            [rootVC pushViewController:vc animated:YES];
        }else{
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[model.actionUrl dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            
                if ([dict[@"code"] integerValue] == 5) {
                    //产品详情
                    MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
                    vc.productId = [NSString stringWithFormat:@"%@",dict[@"param"]];
                    [rootVC pushViewController:vc animated:YES];;
                }
                if ([dict[@"code"] integerValue] == 7) {
                    //奖多多
                    MHPriceMoreViewController *vc = [[MHPriceMoreViewController alloc]init];
                    [rootVC pushViewController:vc animated:YES];;
                }
                if ([dict[@"code"] integerValue] == 8) {
                    //胡猜
                    MHHuGuessViewController *vc = [[MHHuGuessViewController alloc]init];
                    [rootVC pushViewController:vc animated:YES];;
                }
        }
}

@end
