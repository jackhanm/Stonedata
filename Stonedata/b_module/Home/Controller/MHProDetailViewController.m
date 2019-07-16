//
//  MHProDetailViewController.m
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProDetailViewController.h"
#import "SGPagingView.h"
#import "MHProductDetailViewController.h"
#import "MHHeadNavView.h"
#import "MHProductDetailBottomView.h"
#import "MHProductDetailPicViewController.h"
#import "MHProductDetailCommentViewController.h"
#import "MHProductShareView.h"
#import "MHProductDetailModel.h"
#import "MHLoginViewController.h"
#import "MHProductPicModel.h"
#import "MHSumbitOrderVC.h"
#import "MHShopCarSizeAlert.h"
#import "MHShopCarViewController.h"
#import "ZJAnimationPopView.h"
@interface MHProDetailViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate,MHProductDetailViewControllerDelegate>
@property(nonatomic, strong)MHHeadNavView *headView;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentCollectionView;
@property (nonatomic, strong) NSMutableArray *cateArr;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, assign) BOOL canSkip;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, strong)MHProductShareView *shareView;
@property (nonatomic, strong)NSMutableDictionary *dict;
@property (nonatomic, strong)MHProductDetailBottomView *viewbottom;
@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong)MHShopCarSizeAlert *aler;
@property (nonatomic, strong)NSString *skuId;
@property (nonatomic, strong)NSString *amount;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIImageView *emptyOverlayImageView;

@end

@implementation MHProDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden =YES;
    self.canSkip = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    MHLog(@"%@%@%@",self.beginTime, self.endTime, self.comeform);
    [self getNetwork];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti1:) name:KNotificationbuyNow object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti2) name:KNotificationSeeAllComment object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti3) name:KNotificationRereshDetailview object:nil];
    
    // Do any additional setup after loading the view.
}
-(void)noti3
{
    [self getNetwork];
    
}


-(void)noti2
{
    [self.pageTitleView  setSelectedIndex:2];
    [self.pageContentCollectionView setPageContentScrollViewCurrentIndex:2];
}
-(void)noti1:(NSNotification *)noti
{
    NSDictionary *dic = [noti userInfo];
        MHSumbitOrderVC *vc = [[MHSumbitOrderVC alloc]init];
   
    NSArray *arr = @[@{@"productId":[dic valueForKey:@"productId"],@"skuId":[dic valueForKey:@"skuId"],@"productNum":[dic valueForKey:@"amount"], @"activitySkuId":[dic valueForKey:@"activitySkuId"]}];
        vc.arr = arr;
        [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)getNetwork
{
    self.dict = [NSMutableDictionary dictionary];
    
    if (!klStringisEmpty(self.beginTime)) {
        [MBProgressHUD showActivityMessageInWindow:@"正在加载"];
        [[MHUserService sharedInstance] initwithProductId:self.productId activityId:self.activityId beginTime:self.beginTime endTime:self.endTime completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                MHLog(@"%@",response);
                [self.emptyView  removeAllSubviews];
                self.emptyView  = nil;
                self.dict =(NSMutableDictionary *) [MHProductDetailModel baseModelWithDic:[response valueForKey:@"data"]];
                self.dic = [response valueForKey:@"expand"];
                self.resttime =[[NSString stringWithFormat:@"%@",[[response valueForKey:@"data"] valueForKey:@"restTime"]] integerValue];
                if (self.resttime >0) {
                    self.productdetailTYpe = 1;
                }else{
                    self.productdetailTYpe = 0;
                }
                if ([[[response valueForKey:@"data"] valueForKey:@"status"] isEqualToString:@"PENDING"]) {
                    self.comeform =@"willopen";
                }
                if ([[[response valueForKey:@"data"] valueForKey:@"status"] isEqualToString:@"DELETED"]) {
                    self.comeform =@"hasclose";
                }
                if ([[[response valueForKey:@"data"] valueForKey:@"status"] isEqualToString:@"ACTIVE"]) {
                    self.comeform =@"limettime";
                }
                [self createview];
            }
            
            [MBProgressHUD hideHUD];
            if (error) {
                [self creatError];
            }

        }];
    }else{
        [MBProgressHUD showActivityMessageInWindow:@"正在加载"];
        [[MHUserService sharedInstance] initwithProductId:self.productId completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                MHLog(@"%@",response);
                [self.emptyView  removeAllSubviews];
                self.emptyView  = nil;
                self.dict =(NSMutableDictionary *) [MHProductDetailModel baseModelWithDic:[response valueForKey:@"data"]];
                self.dic = [response valueForKey:@"expand"];
                self.resttime =[[NSString stringWithFormat:@"%@",[[response valueForKey:@"data"] valueForKey:@"restTime"]] integerValue];
                if (self.resttime >0) {
                    self.productdetailTYpe = 1;
                }else{
                    self.productdetailTYpe = 0;
                }
                [self createview];
            }
            [MBProgressHUD hideHUD];
            if (error) {
                [self creatError];
            }
        }];
    }
    
    
}


- (void)creatError{
    if (!self.emptyView) {
        self.emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view addSubview:self.emptyView];
        
        self.emptyOverlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 180)];
        self.emptyOverlayImageView.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2 - 100);
        self.emptyOverlayImageView.image = [UIImage imageNamed:@"WebView_LoadFail_Refresh_Icon"];
        [self.emptyView addSubview:self.emptyOverlayImageView];
        
        CGRect emptyOverlayViewFrame = CGRectMake(0, 0, CGRectGetWidth(self.emptyView.frame), 20);
        UILabel *emptyOverlayLabel = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
        emptyOverlayLabel.textAlignment = NSTextAlignmentCenter;
        emptyOverlayLabel.numberOfLines = 0;
        emptyOverlayLabel.backgroundColor = [UIColor clearColor];
        emptyOverlayLabel.text = @"网络异常";
        emptyOverlayLabel.font = [UIFont boldSystemFontOfSize:14];
        emptyOverlayLabel.frame = ({
            CGRect frame = emptyOverlayLabel.frame;
            frame.origin.y = CGRectGetMaxY(self.emptyOverlayImageView.frame) + 10;
            frame;
        });
        emptyOverlayLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        emptyOverlayLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        [self.emptyView addSubview:emptyOverlayLabel];
        
        
        UILabel *emptyOverlayLabel1 = [[UILabel alloc] initWithFrame:emptyOverlayViewFrame];
        emptyOverlayLabel1.textAlignment = NSTextAlignmentCenter;
        emptyOverlayLabel1.numberOfLines = 0;
        emptyOverlayLabel1.backgroundColor = [UIColor clearColor];
        emptyOverlayLabel1.text = @"点击屏幕，重新加载";
        emptyOverlayLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        emptyOverlayLabel1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        emptyOverlayLabel1.font = [UIFont boldSystemFontOfSize:12];
        emptyOverlayLabel1.frame = ({
            CGRect frame = emptyOverlayLabel1.frame;
            frame.origin.y = CGRectGetMaxY(emptyOverlayLabel.frame) + 20;
            frame;
        });
        [self.view addSubview:emptyOverlayLabel1];
        
        //        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPressUIemptyOverlay = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressUIemptyOverlay:)];
        [longPressUIemptyOverlay setMinimumPressDuration:0.001];
        [self.emptyView addGestureRecognizer:longPressUIemptyOverlay];
        self.emptyView.userInteractionEnabled = YES;
    }
    
}


- (void)longPressUIemptyOverlay:(UILongPressGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.emptyOverlayImageView.alpha = 0.4;
    }
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        self.emptyOverlayImageView.alpha = 1;
        [self getNetwork];
    }
}

-(void)createview
{
    NSArray *titleArr = @[@"产品", @"详情", @"评价"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    configure.titleAdditionalWidth = 35;
    configure.showBottomSeparator = NO;
    configure.indicatorCornerRadius = 2.5;
    configure.titleColor = [UIColor colorWithHexString:@"666666"];
    configure.titleSelectedColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorHeight = kRealValue(3);
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, kStatusBarHeight, kRealValue(270), 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.centerX =  self.view.centerX;
    self.pageTitleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    self.pageTitleView.alpha = 0;
    MHProductDetailViewController *oneVC = [[MHProductDetailViewController alloc] initWithNsmudic:self.dict explandDic: self.dic productDetailtype:self.productdetailTYpe];
    oneVC.comeform = self.comeform;
    oneVC.ProDetailViewDelegate  = self;
    
    MHProductDetailPicViewController *twoVC = [[MHProductDetailPicViewController alloc] initWithDic:self.dict];
    MHProductDetailCommentViewController *threeVC = [[MHProductDetailCommentViewController alloc]initWithDic:self.dict];
    NSArray *childArr = @[oneVC, twoVC, threeVC];
    CGFloat ContentCollectionViewHeight = 0.0;
    if (self.productdetailTYpe == 0 ||self.productdetailTYpe ==1) {
       ContentCollectionViewHeight = kScreenHeight-kRealValue(44);
      
    }
    if (self.productdetailTYpe == 2) {
        ContentCollectionViewHeight = kScreenHeight;
        
    }
    self.pageContentCollectionView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];

      _pageContentCollectionView.delegatePageContentScrollView = self;
   
    [self.view addSubview:self.pageContentCollectionView];
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.pageTitleView ];
    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,kTopHeight , kRealValue(100), 44)];
    self.titlelabel.textAlignment = NSTextAlignmentCenter;
    self.titlelabel.text =@"图文详情";
    self.titlelabel.centerX =  self.view.centerX;
    self.titlelabel.hidden =YES;
    [self.headView addSubview:self.titlelabel];
    
    [[[UIApplication sharedApplication].keyWindow viewWithTag:43210] removeFromSuperview];
    self.aler = [[MHShopCarSizeAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) height:kRealValue(400) data:self.dict];
    self.aler.tag = 43210;
    
    self.aler.changeName = ^(NSString *str) {
        if (!klStringisEmpty(str)) {
            NSString *str1 = [str substringFromIndex:1];
            NSDictionary *dataDic = [NSDictionary dictionaryWithObject:str1 forKey:@"info"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"infoNotification" object:nil userInfo:dataDic];
        }
        
        
    };
    kWeakSelf(self);
    self.aler.makesureAct = ^(NSString *productId, NSString *skuId, NSString *amount) {
        MHLog(@"shopcar productId = %@ \n skuId = %@ \n amount = %@ \n",productId, skuId,amount);
        weakself.productId = productId;
        weakself.skuId = skuId;
        weakself.amount = amount;
        
    };


    [[UIApplication sharedApplication].keyWindow addSubview:self.aler];
    
    //lineview
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight - kRealValue(51)- kBottomHeight , kScreenWidth, 1/kScreenScale)];
    lineview.backgroundColor = KColorFromRGB(0xF1F2F1);
    [self.view addSubview:lineview];
    
#pragma mark 普通的商品详情页
    if (self.productdetailTYpe == 0|| self.productdetailTYpe==1) {
        
    
        if ([self.comeform isEqualToString:@"vip"]) {
            self.viewbottom = [[MHProductDetailBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight- kRealValue(50) - kBottomHeight , kScreenWidth, kRealValue(50)) comeform:@"vip"];
        }else if ([self.comeform isEqualToString:@"hasclose"]){
            self.viewbottom = [[MHProductDetailBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight- kRealValue(50) - kBottomHeight , kScreenWidth, kRealValue(50)) comeform:@"hasclose"];
        }else if ([self.comeform isEqualToString:@"willopen"]){
             self.viewbottom = [[MHProductDetailBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight- kRealValue(50) - kBottomHeight , kScreenWidth, kRealValue(50)) comeform:@"willopen"];
        }else{
            self.viewbottom = [[MHProductDetailBottomView alloc]initWithFrame:CGRectMake(0, kScreenHeight- kRealValue(50) - kBottomHeight , kScreenWidth, kRealValue(50))];
        }
    
        
        
    if ([[NSString stringWithFormat:@"%@",[self.dict valueForKey:@"collected"]]  isEqualToString:@"0"]) {
        self.viewbottom.Collectbtn.selected = NO;
    }else{
         self.viewbottom.Collectbtn.selected = YES;
    }
    kWeakSelf(self);
    //联系客服
    self.viewbottom.productDetailBottomViewContact = ^(NSString *productID) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-051-8180"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    //收藏
    self.viewbottom.productDetailBottomViewCollect = ^(BOOL select) {
     
        if ([GVUserDefaults standardUserDefaults].accessToken) {
            [[MHUserService sharedInstance]initwithCommentProductId:[weakself.dict valueForKey:@"productId"] collected:[NSString stringWithFormat:@"%d",!select]  completionBlock:^(NSDictionary *response, NSError *error) {
                weakself.viewbottom.Collectbtn.selected = !select;
                if (select == NO) {
                    KLToast(@"收藏成功");
                }else{
                     KLToast(@"取消收藏成功");
                }
            }];
        }else{
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [weakself presentViewController:userNav animated:YES completion:nil];
        }
       
    };
    // 去购物车界面
    self.viewbottom.productDetailBottomViewGoshopCar = ^(NSString *productID) {
        if ([GVUserDefaults standardUserDefaults].accessToken) {
            MHShopCarViewController *vc = [[MHShopCarViewController alloc]init];
            vc.IsComeFromdetail = YES;
            [weakself.navigationController pushViewController:vc animated:YES];
        }else{
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [weakself presentViewController:userNav animated:YES completion:nil];
        }
       
    };
   
  
    //添加购物车
    self.viewbottom.productDetailBottomVieAddShopCar = ^(NSString *productID, NSString *brandID) {
        //
        
        if ([GVUserDefaults standardUserDefaults].accessToken) {
            NSMutableArray *arr1 = [NSMutableArray arrayWithArray:[weakself.dict valueForKey:@"skuList"]];
            if (arr1.count >1) {
                //当规格有多种的时候让选择
                [weakself.aler showAlertwithShopCar:1];
            }else{
                //只有一种直接加入购物车
                if (arr1.count >0) {
                     [weakself.aler showAlertwithShopCar:1];
                    
                }else{
                    KLToast(@"暂无商品规格")
                }
                
            }
        }else{
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [weakself presentViewController:userNav animated:YES completion:nil];
        }
       

    };
    
    
    
    [self.view addSubview:self.viewbottom];
         //立即购买
    self.viewbottom.productDetailBottomVieBuynow = ^(NSString *productID, NSString *brandID) {
        
       
            if ( [weakself.viewbottom.Buybtn.titleLabel.text isEqualToString:@"立即分享"]) {
                [weakself showShareAlert];
                  return ;
            }

        if ([GVUserDefaults standardUserDefaults].accessToken) {
            NSMutableArray *arr1 = [NSMutableArray arrayWithArray:[weakself.dict valueForKey:@"skuList"]];
            if (arr1.count >1) {
                //当规格有多种的时候让选择
                [weakself.aler showAlertwithShopCar:2];
            }else{
                //只有一种直接买
                if (arr1.count >0) {
                    [weakself.aler showAlertwithShopCar:2];
                }else{
                    KLToast(@"暂无商品规格")
                };
                
            }
        }else{
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [weakself presentViewController:userNav animated:YES completion:nil];
        }

    };
    }
    
    if (self.productdetailTYpe == 2) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"发起胡猜" forState:UIControlStateNormal];
        [btn setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
         [btn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = kRealValue(22);
        btn.frame = CGRectMake(kRealValue(16), kScreenHeight- kRealValue(54) - kBottomHeight,  kScreenWidth-kRealValue(32), kRealValue(40) + kBottomHeight);
        [self.view addSubview:btn];
    }
    
}


- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex == 0) {
        self.pageTitleView.alpha  = self.alpha;
        self.headView.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:self.alpha];
    }else{
         self.pageTitleView.alpha  = 1;
        self.headView.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:1];
    }
   [self.pageContentCollectionView setPageContentScrollViewCurrentIndex:selectedIndex];
}



- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    if (targetIndex == 0) {
        self.pageTitleView.alpha  = self.alpha;
        self.headView.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:self.alpha];
    }else{
        if ( self.pageTitleView.alpha  >0.8) {
            self.headView.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:1];
        }else{
            self.pageTitleView.alpha  = 1 *progress;
            self.headView.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:1*progress];
        }
        
    }
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
    
}



-(void)showNavAddtitle:(CGFloat)offset
{
    self.alpha  = 0;
    if (offset<=0) {
         self.alpha = 0;
        self.pageTitleView.alpha = 0;
    } else if(offset < (kTopHeight+50)){
        self.alpha = offset/(kTopHeight+50);
        self.pageTitleView.alpha  = offset/(kTopHeight+50);
    }else if(offset >= (kTopHeight+50)){
        self.alpha = 1;
        self.pageTitleView.alpha  = 1;
    }else{
         self.alpha = 0;
        self.pageTitleView.alpha  = 0;
    }
     self.headView.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:self.alpha];
}
-(void)changeNavTitle:(BOOL)isShow
{
    if (isShow) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.pageTitleView.frame = CGRectMake(0, kStatusBarHeight, kRealValue(270), 44);
            self.pageTitleView.centerX =  self.view.centerX;
            self.titlelabel.frame = CGRectMake(0,kTopHeight , kRealValue(100), 44);
            self.titlelabel.centerX =  self.view.centerX;
            self.titlelabel.hidden =YES;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.pageTitleView.frame = CGRectMake(0, -44, kRealValue(270), 44);
            self.pageTitleView.centerX =  self.view.centerX;
              self.titlelabel.hidden =NO;
            self.titlelabel.frame = CGRectMake(0,kStatusBarHeight , kRealValue(100), 44);
            self.titlelabel.centerX =  self.view.centerX;
        } completion:^(BOOL finished) {
            
        }];
    }
    
}
-(void)ShowAlert
{
      [self.aler showAlert];
}
-(void)showShareAlert
{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:self.shareView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
        // 3.1 显示时点击背景是否移除弹框
        popView.isClickBGDismiss = YES;
        // 3.2 显示时背景的透明度
        popView.popBGAlpha = 0.5f;
        // 3.3 显示时是否监听屏幕旋转
        popView.isObserverOrientationChange = YES;
        // 3.4 显示时动画时长
        popView.popAnimationDuration = 0.3f;
        // 3.5 移除时动画时长
        popView.dismissAnimationDuration = 0.3f;
        
        self.shareView.hidenClick = ^{
            [popView dismiss];
        };
        
        // 3.6 显示完成回调
        popView.popComplete = ^{
            MHLog(@"显示完成");
        };
        // 3.7 移除完成回调
        popView.dismissComplete = ^{
            MHLog(@"移除完成");
        };
        [popView pop];
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
    
   
}
-(MHHeadNavView *)headView
{
    if (!_headView) {
         __weak __typeof(self) weakSelf = self;
       
        _headView = [[MHHeadNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopHeight) height:kTopHeight title:@""];
        _headView.backblock = ^(NSString *productID) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _headView.goshareblock = ^(NSString *productID) {
          
          
        };
    }
    return _headView;
}

-(MHProductShareView *)shareView{
    if (!_shareView) {
        _shareView = [[MHProductShareView alloc]initWithFrame:CGRectMake(kRealValue(15), kRealValue(28), kScreenWidth - kRealValue(30), kRealValue(550)) dict:self.dict dic:self.dic comefrom:@"" shareId:@""];

        _shareView.superVC = self;
    }
    return _shareView;
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    if (index == 0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)changeskipable:(BOOL)isable
{
    self.canSkip = isable;
     self.pageContentCollectionView.isScrollEnabled = isable;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
