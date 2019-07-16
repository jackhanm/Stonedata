//
//  MHShopLevelViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopLevelViewController.h"
#import "UIImage+Common.h"
#pragma mark  切换view
#import "MHShopViewController.h"
#import "MHLevelViewController.h"
#import "MHStoreVC.h"

@interface MHShopLevelViewController (){
    MHShopViewController *shopVC;
    MHLevelViewController *levelVC;
}


@end

@implementation MHShopLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
    
//升级会员
-(void)changeTabbarLevel{
    self.fd_prefersNavigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES];
    if (!levelVC) {
        levelVC = [[MHLevelViewController alloc] init];
    }
    [self addChildViewController:levelVC];
     levelVC.view.frame = self.view.bounds;
    [self.view addSubview:levelVC.view];
    [levelVC didMoveToParentViewController:self];
    UITabBarItem * tabbarItem =  [self.tabBarController.tabBar.items objectAtIndex:2];
   tabbarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   tabbarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.title = @"升级店主";
    tabbarItem.title = @"升级店主";
    self.navigationItem.rightBarButtonItem= nil;
}

//店家
-(void)changeTabbarShop{
    self.fd_prefersNavigationBarHidden = NO;
   [self.navigationController setNavigationBarHidden:NO];
    if (!shopVC) {
        shopVC = [[MHShopViewController alloc] init];
    }
    [self addChildViewController:shopVC];
    shopVC.view.frame = self.view.bounds;
    [self.view addSubview:shopVC.view];
    [shopVC didMoveToParentViewController:self];
    self.fd_prefersNavigationBarHidden = NO;
    self.navigationItem.title = @"店主";
    UITabBarItem * tabbarItem =  [self.tabBarController.tabBar.items objectAtIndex:2];
    tabbarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarItem.title = @"店主";
    
    UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setFrame:CGRectMake(5,0,kRealValue(70),kRealValue(30))];
    [moreBtn setTitle:@"管理店铺" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [moreBtn addTarget:self action:@selector(listClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
}


- (void)listClick{
    MHStoreVC *vc = [[MHStoreVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [[MHUserService sharedInstance]initwithUserStateCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)){
                [GVUserDefaults standardUserDefaults].userRole =  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                [GVUserDefaults standardUserDefaults].phone =  [NSString stringWithFormat:@"%@",response[@"data"][@"userPhone"]];
            }
            if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
                [self changeTabbarLevel];
            }else{
                [self changeTabbarShop];
            }
        }];
    }else{
         [self changeTabbarLevel];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
