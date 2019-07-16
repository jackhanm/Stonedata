//
//  MHPriceMoreDetailViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHPriceMoreDetailViewController.h"
#import "MHProductDetailHeadCell.h"
#import "MHCommentDetailCell.h"
#import "MHCommentDetailCellHeadCell.h"
#import "MHCommentDetailCellBottomCell.h"
#import "MHProductPriceMoredetailHeadCell.h"
#import "MHProductDetailDesCell.h"
#import "MHProductDetailPicView.h"
#import "MHShopCarSizeAlert.h"
#import "MHProductPicModel.h"
#import "MHProductCommentModel.h"
#import "MHProductCommentListModel.h"
#import "MHSumbitOrderVC.h"
#import "MHLoginViewController.h"
#import "MHHucaiPersionList.h"
#import "MHProductDetailModel.h"
#import "MHHeadNavView.h"
#import "MHProductShareView.h"
#import "MHPriceMoreOrderViewController.h"
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"
#import "MHProductDescbottomView.h"
@interface MHPriceMoreDetailViewController ()<UITableViewDelegate,UITableViewDataSource,MHProductDetailPicViewDelegate>
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)MHProductDetailPicView *detailView;

@property (nonatomic, strong)MHProductDetailHeadCell *cell;
@property (nonatomic, strong)MHProductPriceMoredetailHeadCell *hucaiCell;
@property (nonatomic, strong) NSMutableArray *Lunboarr;
@property (nonatomic, strong) NSMutableArray *CommentArr;
@property (nonatomic, strong) NSMutableDictionary *CommentDic;
@property (nonatomic, strong) NSMutableArray *PicArr;
@property (nonatomic, strong) NSMutableDictionary *explandDic;
@property (nonatomic, strong) NSString *codeStr;
@property (nonatomic, assign) NSInteger productdetailTYpe;
@property (nonatomic, strong) MHHucaiPersionList *alert;
@property (nonatomic, strong) NSTimer *timer ;
@property(nonatomic, strong)  MHHeadNavView *headView;
@property (nonatomic, strong) MHProductShareView *shareView;

@property (nonatomic, strong) UIImageView *jiangView;
@property (nonatomic, strong) NSString *shareID;
@property (nonatomic, strong) NSString *sharePath;
//给分享的dic
@property (nonatomic, strong) NSMutableDictionary *sharedic;
@property (nonatomic,strong)MHProductDetailDesCell *DesCellcell;
@end

@implementation MHPriceMoreDetailViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self getdata];
}
- (instancetype)initWithdrawId:(NSString *)drawId comefrom:(NSString *)comeform;
{
    self = [super init];
    if (self) {
        self.drawId = drawId;
        self.comefrom = comeform;
    }
    return self;
}
-(void)dealloc{
    
    self.timer = nil;
}


-(void)timerAction
{
   
    if (self.resttimer == 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self getdata];
        return;
        
    }
     --self.resttimer ;
    NSString *str = [NSString stringWithFormat:@"%ld",self.resttimer];
    NSInteger seconds = [str integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
   self.hucaiCell.secondelabel.text =str_second;
    self.hucaiCell.minutelabel.text =str_minute;
    self.hucaiCell.hourlabel.text =str_hour;
}
-(void)getdata
{
    self.dic = [NSMutableDictionary dictionary];
    if ([self.comefrom isEqualToString:@"order"]) {
        self.dic = [NSMutableDictionary dictionary];
        [MBProgressHUD showActivityMessageInWindow:@"正在加载"];
        [[MHUserService sharedInstance] initwithlistshareId:self.drawId completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.dic = [response valueForKey:@"data"];
                self.Lunboarr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productImages"]];
                self.CommentArr = [MHProductCommentModel baseModelWithArr:[[self.dic valueForKey:@"evaluate"] valueForKey:@"list"]] ;
                self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productBigImage"]];
                self.explandDic = [response valueForKey:@"expand"];
                self.resttimer =[[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"restTime"]] integerValue];
                self.shareID =[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"shareId"]];
                
                if (self.resttimer > 0) {
                    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
                    [[NSRunLoop mainRunLoop] addTimer:self.timer  forMode: NSRunLoopCommonModes];
                }
                
                [self createview];
            }
            [MBProgressHUD hideHUD];
        }];
    }else{
        
        [MBProgressHUD showActivityMessageInWindow:@"正在加载"];
        [[MHUserService sharedInstance] initwithDrawId:self.drawId completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.dic = [response valueForKey:@"data"];
                self.Lunboarr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productImages"]];
                self.CommentArr = [MHProductCommentModel baseModelWithArr:[[self.dic valueForKey:@"evaluate"] valueForKey:@"list"]] ;
                self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productBigImage"]];
                self.explandDic = [response valueForKey:@"expand"];
                self.resttimer =[[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"restTime"]] integerValue];
                self.shareID =[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"shareId"]];
                
                if (self.resttimer > 0) {
                    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
                    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
                }
                [self createview];
            }
            [MBProgressHUD hideHUD];
        }];
    }
    
    
}

-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden =YES;
    self.view.backgroundColor = [UIColor whiteColor];
   
 
}
-(void)customcontact
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-051-8180"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)createview
{
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.detailView];
    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0 , kRealValue(100), 44)];
    self.titlelabel.textAlignment = NSTextAlignmentCenter;
    self.titlelabel.text =@"图文详情";
    self.titlelabel.centerX =  self.view.centerX;
    self.titlelabel.hidden =YES;
    [self.headView addSubview:self.titlelabel];
   
    //lineview
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight - kRealValue(51)- kBottomHeight , kScreenWidth, 1/kScreenScale)];
    lineview.backgroundColor = KColorFromRGB(0xF1F2F1);
    [self.view addSubview:lineview];
    
    UIButton *customContactbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customContactbtn.frame = CGRectMake(kRealValue(0), kScreenHeight - kRealValue(50)- kBottomHeight, kRealValue(50), kRealValue(50));
    [customContactbtn setImage:kGetImage(@"kefu") forState:UIControlStateNormal];
    [customContactbtn setTitle:@"客服" forState:UIControlStateNormal];
    [customContactbtn setTitleColor:KColorFromRGB(0x000000) forState:UIControlStateNormal];
    customContactbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    customContactbtn.titleLabel.textColor = [UIColor blackColor];
    customContactbtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    // button标题的偏移量
    customContactbtn.titleEdgeInsets = UIEdgeInsetsMake(customContactbtn.imageView.frame.size.height, -customContactbtn.imageView.bounds.size.width, 0,0);
    // button图片的偏移量
    customContactbtn.imageEdgeInsets = UIEdgeInsetsMake(0, customContactbtn.titleLabel.frame.size.width/2, customContactbtn.titleLabel.frame.size.height, -customContactbtn.titleLabel.frame.size.width/2);
    customContactbtn.backgroundColor = [UIColor whiteColor];
    [customContactbtn addTarget:self action:@selector(customcontact) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customContactbtn];

    
    
    
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //底部按钮显示
    //登录,未登录
   
    if ([self.comefrom isEqualToString:@"list"]) {
        if ([GVUserDefaults standardUserDefaults].accessToken) {
            if ([[GVUserDefaults standardUserDefaults].userRole  integerValue]<2) {
                //普通用户
                [btn setTitle:@"发起活动" forState:UIControlStateNormal];
                
            }else{
                //店主用户
                //判断状态
                NSString *str = [self.dic valueForKey:@"status"];
                if ([str isEqualToString:@"PENDING"]) {
                    [btn setTitle:@"未开始" forState:UIControlStateNormal];
                    
                }
                if ([str isEqualToString:@"INITIATE"]) {
                    [btn setTitle:@"发起活动" forState:UIControlStateNormal];
                }
                if ([str isEqualToString:@"ACTIVE"]) {
                    [btn setTitle:@"继续邀请" forState:UIControlStateNormal];
                }
                if ([str isEqualToString:@"UNOPENED"]) {
                    [btn setTitle:@"立即开奖" forState:UIControlStateNormal];
                }
                if ([str isEqualToString:@"OPENED"]) {
                    [btn setTitle:@"已开奖" forState:UIControlStateNormal];
                    
                }
                if ([str isEqualToString:@"INVALID"]) {
                    [btn setTitle:@"已过期" forState:UIControlStateNormal];
                    
                }
            }
            
        }else{
            [btn setTitle:@"发起活动" forState:UIControlStateNormal];
           
        }
    }else{
        
        if ([[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"relation"]] isEqualToString:@"1"]) {
            //参与者
            if ([GVUserDefaults standardUserDefaults].accessToken) {
            
                    NSString *str = [self.dic valueForKey:@"status"];
                if ([str isEqualToString:@"PENDING"]) {
                    [btn setTitle:@"未开始" forState:UIControlStateNormal];
                    
                }
                if ([str isEqualToString:@"INITIATE"]) {
                    [btn setTitle:@"发起活动" forState:UIControlStateNormal];
                    
                }
                    if ([str isEqualToString:@"ACTIVE"]) {
                        [btn setTitle:@"已参与" forState:UIControlStateNormal];
                        
                    }
                    if ([str isEqualToString:@"UNOPENED"]) {
                        [btn setTitle:@"等待开奖" forState:UIControlStateNormal];
                        
                    }
                    if ([str isEqualToString:@"OPENED"]) {
                        [btn setTitle:@"已开奖" forState:UIControlStateNormal];
                        
                    }
                    if ([str isEqualToString:@"INVALID"]) {
                        [btn setTitle:@"已过期" forState:UIControlStateNormal];
                        
                    }
                
                
            }else{
                [btn setTitle:@"发起活动" forState:UIControlStateNormal];
                
            }
            
            
        }
        if ([[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"relation"]] isEqualToString:@"0"]) {
            //发起者
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                if ([[GVUserDefaults standardUserDefaults].userRole  integerValue]<2) {
                    //普通用户
                    [btn setTitle:@"发起活动" forState:UIControlStateNormal];
                    
                    
                }else{
                    NSString *str = [self.dic valueForKey:@"status"];
                    if ([str isEqualToString:@"PENDING"]) {
                        [btn setTitle:@"未开始" forState:UIControlStateNormal];
                        
                    }
                    if ([str isEqualToString:@"INITIATE"]) {
                        [btn setTitle:@"发起活动" forState:UIControlStateNormal];
                        
                    }
                    if ([str isEqualToString:@"ACTIVE"]) {
                        [btn setTitle:@"继续邀请" forState:UIControlStateNormal];
                        
                    }
                    if ([str isEqualToString:@"UNOPENED"]) {
                        [btn setTitle:@"立即开奖" forState:UIControlStateNormal];
                        
                    }
                    if ([str isEqualToString:@"OPENED"]) {
                        [btn setTitle:@"已开奖" forState:UIControlStateNormal];
                        
                    }
                    if ([str isEqualToString:@"INVALID"]) {
                        [btn setTitle:@"已过期" forState:UIControlStateNormal];
                        
                    }
                }
                
            }else{
                [btn setTitle:@"发起活动" forState:UIControlStateNormal];
                
            }
            
        }
   
    }
    [btn addTarget:self action:@selector(startPricemore) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"F54915"],[UIColor colorWithHexString:@"F54915"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    btn.frame = CGRectMake(kRealValue(45), kScreenHeight- kRealValue(50) - kBottomHeight,  kScreenWidth-kRealValue(45), kRealValue(50) );
    [self.view addSubview:btn];
    self.alert = [[MHHucaiPersionList alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    

    NSString *drawnumpersion = [NSString stringWithFormat:@"%@",[self.dic valueForKey:@"drawNumber"]] ;
    NSInteger drawnumpersionnum = [drawnumpersion  integerValue];
    
    NSString *alertitle;
    if ([[self.dic valueForKey:@"userList"] count] == 0 ) {
        alertitle =[NSString stringWithFormat:@"0/%ld",drawnumpersionnum];
    }else
    {
        alertitle =[NSString stringWithFormat:@"%ld/%ld",[[self.dic  valueForKey:@"userList"] count],drawnumpersionnum];
    }

    self.alert.title =alertitle;
    self.alert.comeform = @"prizemore";
    self.alert.array = [self.dic valueForKey:@"userList"];
    self.alert.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.alert];
    
}
-(void)startPricemore
{
    
    
    if ([self.comefrom isEqualToString:@"list"]) {
        if ([GVUserDefaults standardUserDefaults].accessToken) {
            if ([[GVUserDefaults standardUserDefaults].userRole  integerValue]==1) {
                //普通用户
                [[MHBaseClass sharedInstance] presentAlertWithtitle:@"升级店主即可发起活动" message:@"去升级店主" leftbutton:@"取消" rightbutton:@"确定" leftAct:^{
                   
                    
                } rightAct:^{
                    
               
                    self.tabBarController.selectedIndex =2;
                    [self.navigationController popToRootViewControllerAnimated:YES];
                   
                }];
                
            }else{
                //店主用户
                //判断状态
                NSString *str = [self.dic valueForKey:@"status"];
                if ([str isEqualToString:@"PENDING"]) {
                    KLToast(@"活动未开始");
                }
                if ([str isEqualToString:@"INITIATE"]) {
                    [MBProgressHUD showActivityMessageInWindow:@"发起活动"];
                    [[MHUserService sharedInstance]initwithStartPrizewithDrawId:[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"drawId"]] morecompletionBlock:^(NSDictionary *response, NSError *error) {
                        if (ValidResponseDict(response)) {
                           
                            self.shareID = [[response valueForKey:@"data"] valueForKey:@"shareId"];
                            self.sharedic = response[@"data"];
                            [self showAlertView];
                             KLToast(@"活动发起成功");
                            [self getdata];
                        }else{
                            [MBProgressHUD showActivityMessageInWindow:response[@"message"]];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUD];
                            });

                        }
                       
                        
                    }];
                }
                if ([str isEqualToString:@"ACTIVE"]) {
                    [self showAlertView];
                }
                if ([str isEqualToString:@"UNOPENED"]) {
                    [[MHUserService sharedInstance]initwithopenprizeshareId:self.shareID completionBlock:^(NSDictionary *response, NSError *error) {
                        if (ValidResponseDict(response)) {
                            KLToast(@"开奖成功");
                            [self showOpenjiang:response[@"data"]];
                             [self getdata];
                            
                        }else{
                            [MBProgressHUD showActivityMessageInWindow:response[@"message"]];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUD];
                            });
                        }
                        
                    }];
                }
            }
            
        }else{
            MHLoginViewController *login = [[MHLoginViewController alloc] init];
            UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
            [self presentViewController:userNav animated:YES completion:nil];
        }
    }else{
         if ([[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"relation"]] isEqualToString:@"0"]) {
             if ([GVUserDefaults standardUserDefaults].accessToken) {
                 if ([[GVUserDefaults standardUserDefaults].userRole  integerValue]==1) {
                     //普通用户
                     [[MHBaseClass sharedInstance] presentAlertWithtitle:@"升级店主即可发起活动" message:@"去升级店主" leftbutton:@"取消" rightbutton:@"确定" leftAct:^{
                         
                         
                     } rightAct:^{
                         
                         self.tabBarController.selectedIndex =2;
                         [self.navigationController popToRootViewControllerAnimated:YES];
                     }];
                     
                 }else{
                     //店主用户
                     //判断状态
                     NSString *str = [self.dic valueForKey:@"status"];
                     if ([str isEqualToString:@"ACTIVE"]) {
                         [self showAlertView];
                     }
                     if ([str isEqualToString:@"UNOPENED"]) {
                         [[MHUserService sharedInstance]initwithopenprizeshareId:self.shareID completionBlock:^(NSDictionary *response, NSError *error) {
                             if (ValidResponseDict(response)) {
                                 KLToast(@"开奖成功");
                                 [self showOpenjiang:response[@"data"]];
                                 [self getdata];
                             }else{
                                 [MBProgressHUD showActivityMessageInWindow:response[@"message"]];
                                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     [MBProgressHUD hideHUD];
                                 });
                             }
                         }];
                     }
                     if ([str isEqualToString:@"OPENED"]) {
                         
                     }
                     if ([str isEqualToString:@"INVALID"]) {
                         
                     }
                     
                     
                 }
                 
             }else{
                 //   [btn setTitle:@"发起活动" forState:UIControlStateNormal];
                 MHLoginViewController *login = [[MHLoginViewController alloc] init];
                 UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                 [self presentViewController:userNav animated:YES completion:nil];
             }
         }
        
        if ([[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"relation"]] isEqualToString:@"1"]) {
            //参与者
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                
                NSString *str = [self.dic valueForKey:@"status"];
                if ([str isEqualToString:@"ACTIVE"]) {
                   
                    
                }
                if ([str isEqualToString:@"UNOPENED"]) {
                   
                    
                }
                if ([str isEqualToString:@"OPENED"]) {
                    
                }
                if ([str isEqualToString:@"INVALID"]) {
                   
                    
                }
                
                
            }
            
            
        }
        
        
    }
    
}


-(void)showAlertView{
    
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
    

//    imageView.centerY  =self.shareView.centerY;
    
    // 3.6 显示完成回调
    popView.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    popView.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [popView pop];
    
}


-(void)showOpenjiang:(NSDictionary *)dict{
    
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:self.jiangView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.1 显示时点击背景是否移除弹框
    popView.isClickBGDismiss = YES;
    // 3.2 显示时背景的透明度
    popView.popBGAlpha = 0.8f;
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
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:kGetImage(@"openjiang_ls")];
    imageView.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(400));
    [popView.contentView addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    imageView.centerY = popView.contentView.centerY;
    
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kRealValue(100), kRealValue(40), kRealValue(40))];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"userImage"]] placeholderImage:kGetImage(@"user_pic")];
    headImageView.layer.cornerRadius = kRealValue(20);
    headImageView.layer.masksToBounds = YES;
    [imageView addSubview:headImageView];
    headImageView.centerX = popView.contentView.centerX;
    
    UILabel  *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(150), kRealValue(260), kRealValue(30))];
    nameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
    nameLabel.text = [NSString stringWithFormat:@"中奖人：%@",dict[@"userNickName"]];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [imageView addSubview:nameLabel];
    nameLabel.centerX = popView.contentView.centerX;
    
    
    UILabel  *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(180), kRealValue(230), kRealValue(70))];
    textLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(17)];
    textLabel.text = @"您和中奖人同时获得活动奖品一份，快去领取吧！";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 2;
    textLabel.textColor = [UIColor whiteColor];
    [imageView addSubview:textLabel];
    textLabel.centerX = popView.contentView.centerX;
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kRealValue(255), kRealValue(136), kRealValue(35))];
    [closeBtn setImage:[UIImage imageNamed:@"openjiang_btn"] forState:UIControlStateNormal];
    [imageView addSubview:closeBtn];
    [closeBtn bk_addEventHandler:^(id sender) {
        [popView dismiss];
        MHPriceMoreOrderViewController *vc = [[MHPriceMoreOrderViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    closeBtn.centerX = popView.contentView.centerX;
    
}


-(UIImageView *)jiangView{
    if (!_jiangView) {
        _jiangView = [[UIImageView alloc]initWithImage:kGetImage(@"openjiang_bg")];
        _jiangView.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(400));
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 15;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = HUGE_VALF;
        _jiangView.clipsToBounds = YES;
        [_jiangView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

        

        
    }
    return _jiangView;
}






-(void)gotologin
{
    MHLoginViewController *login = [[MHLoginViewController alloc] init];
    UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
    [self presentViewController:userNav animated:YES completion:nil];
}
-(void)gotoupgrade
{
    [[MHBaseClass sharedInstance] presentAlertWithtitle:@"升级店主即可发起活动" message:@"去升级店主" leftbutton:@"取消" rightbutton:@"确定" leftAct:^{
        
        
    } rightAct:^{
        
    }];
}
-(MHHeadNavView *)headView
{
    if (!_headView) {
        __weak __typeof(self) weakSelf = self;
        
        _headView = [[MHHeadNavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopHeight) height:kTopHeight title:@""];
        _headView.rightButton.hidden = YES;
        _headView.backblock = ^(NSString *productID) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _headView.goshareblock = ^(NSString *productID) {
            
            [self showAlertView];
        };
    }
    return _headView;
}

-(MHProductShareView *)shareView{
    if (!_shareView) {
      
        
        _shareView = [[MHProductShareView alloc]initWithFrame:CGRectMake(kRealValue(15), kRealValue(28), kScreenWidth - kRealValue(30), kRealValue(600)) dict:self.sharedic.count>0?self.sharedic:self.dic dic:self.explandDic comefrom:@"prizemore" shareId:self.shareID];
//        _shareView.comefrom = @"prizemore";
//         _shareView.dic =self.explandDic;
//        _shareView.dict = self.dic;
//        _shareView.shareId = self.shareID;

        _shareView.superVC = self;
    }
    return _shareView;
}





#pragma mark lazy

-(MHProductDetailPicView *)detailView
{
    if (!_detailView) {
        _detailView = [[MHProductDetailPicView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kTopHeight)];
         _detailView.des =[self.dic valueForKey:@"productSubtitle"];
        _detailView.PicViewDelegate = self;
        _detailView.PictureArr = self.PicArr;
    }
    return _detailView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView registerClass:[MHProductDetailHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHProductDetailHeadCell class])];
        [_tableView registerClass:[MHCommentDetailCell class] forCellReuseIdentifier:NSStringFromClass([MHCommentDetailCell class])];
        [_tableView registerClass:[MHCommentDetailCellBottomCell class] forCellReuseIdentifier:NSStringFromClass([MHCommentDetailCellBottomCell class])];
        [_tableView registerClass:[MHProductDetailDesCell class] forCellReuseIdentifier:NSStringFromClass([MHProductDetailDesCell class])];
        [_tableView registerClass:[MHCommentDetailCellHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHCommentDetailCellHeadCell class])];
        [_tableView registerClass:[MHProductPriceMoredetailHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHProductPriceMoredetailHeadCell class])];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        if (self.CommentArr.count > 0) {
            return self.CommentArr.count +2;
        }
        return 0;
    }
    if (section ==2) {
        return 1;
    }
    return 1 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ([self.comefrom isEqualToString:@"list"]) {
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                if ([[GVUserDefaults standardUserDefaults].userRole  integerValue]<2) {
                    //普通用户
                    return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127) ;
                    
                }else{
                    //店主用户 根据状态判断
                    
                    NSString *str = [self.dic valueForKey:@"status"];
                    if ([str isEqualToString:@"PENDING"]) {
                        return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127);
                    }
                    if ([str isEqualToString:@"INITIATE"]) {
                        return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127);
                    }
                    if ([str isEqualToString:@"ACTIVE"]) {
                        return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127) +kRealValue(103);
                    }
                    if ([str isEqualToString:@"OPENED"]) {
                        return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127) +kRealValue(103);
                    }
                    
                    if ([str isEqualToString:@"UNOPENED"]) {
                        return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127) +kRealValue(103);
                    }
                    
                    if ([str isEqualToString:@"INVALID"]) {
                        return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127) +kRealValue(103);
                    }
                    
                    
                    
                    
                }
                
            }else{
                return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127);
                
                
            }
        }else{
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                MHLog(@"%@",[GVUserDefaults standardUserDefaults].userRole);
                NSString *str = [self.dic valueForKey:@"status"];
                if ([str isEqualToString:@"PENDING"]) {
                    return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127);
                }
                if ([str isEqualToString:@"INITIATE"]) {
                    return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127);
                }
                if ([str isEqualToString:@"ACTIVE"]) {
                    return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127) +kRealValue(103);
                }
                if ([str isEqualToString:@"OPENED"]) {
                    return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127) +kRealValue(103)+kRealValue(103);
                }
                
                if ([str isEqualToString:@"UNOPENED"]) {
                    return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127) +kRealValue(103);
                }
                
                if ([str isEqualToString:@"INVALID"]) {
                    return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127);
                }
                

            }else{
                return  kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(127);
                
                
            }
        }
    }
    if (indexPath.section == 1) {
        if (self.CommentArr.count > 0) {
            if (indexPath.row == 0) {
                return kRealValue(50);
            }
            if (indexPath.row == self.CommentArr.count+1) {
                return kRealValue(60);
            }
            MHProductCommentModel *model = [self.CommentArr objectAtIndex:indexPath.row-1];
            CGRect rect = [model.evaluateContent boundingRectWithSize:CGSizeMake(309, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)]} context:nil];
            if (klStringisEmpty(model.evaluateImages)) {
                return rect.size.height+kRealValue(44) +kRealValue(10);
            }else{
                return rect.size.height+kRealValue(44) + kRealValue(57)+kRealValue(10);
            }
            
        }else{
            return 0;
        }
        
    }
    if (indexPath.section == 2) {
        return kRealValue(50);
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        self.hucaiCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductPriceMoredetailHeadCell class])];

        self.hucaiCell.selectionStyle= UITableViewCellSelectionStyleNone;
        self.hucaiCell.dic  = self.dic;
        self.hucaiCell.bannerArr =self.Lunboarr;
        self.hucaiCell.expandDic  = self.explandDic;
        if (self.resttimer == 0) {
            
        }
        self.hucaiCell.hucaiSeeAll = ^{
            self.alert.hidden = NO;
        };
       
        
        
        return self.hucaiCell;
    }
    if (indexPath.section == 1) {
        if (self.CommentArr.count > 0) {
            if (indexPath.row == 0) {
                MHCommentDetailCellHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHCommentDetailCellHeadCell class])];
                
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                cell.CellHead.RightitleLabel.text = [NSString stringWithFormat:@"好评度%@",[[self.dic valueForKey:@"evaluate"] valueForKey:@"rate"]];
                cell.CellHead.RightitleLabel.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAct)];
                [cell.CellHead.RightitleLabel addGestureRecognizer:tap];
                
                
                return cell;
            }
            if (indexPath.row == self.CommentArr.count +1) {
                MHCommentDetailCellBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHCommentDetailCellBottomCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                return cell;
            }
            MHCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHCommentDetailCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            MHProductCommentModel *model = [self.CommentArr objectAtIndex:indexPath.row-1];
            cell.model = model;
            return cell;
        }
        
        MHCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHCommentDetailCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    if (indexPath.section == 2) {
        self.DesCellcell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductDetailDesCell class])];
        self.DesCellcell.selectionStyle= UITableViewCellSelectionStyleNone;
        self.DesCellcell.labeldetail1.text = [self.dic valueForKey:@"productSubtitle"];
        return self.DesCellcell;
    }
    return nil;
    
    
}
-(void)TapAct
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationSeeAllComment object:nil];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset  = scrollView.contentOffset.y;
    
    
    MHLog(@"%f",offset);
    if (scrollView == self.tableView) {
        self.alpha  = 0;
        if (offset<=0) {
            self.alpha = 0;
           
        } else if(offset < (kTopHeight+50)){
            self.alpha = offset/(kTopHeight+50);
           
        }else if(offset >= (kTopHeight+50)){
            self.alpha = 1;
        }else{
            self.alpha = 0;
            
        }
    }
}

#pragma mark ---- scrollView delegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if([scrollView isKindOfClass:[UITableView class]]) // tableView界面上的滚动
    {
        // 能触发翻页的理想值:tableView整体的高度减去屏幕本省的高度
        CGFloat valueNum = self.tableView.contentSize.height - kScreenHeight + kTopHeight ;
        if ((offsetY - valueNum) > 20)
        {
            [self goToDetailAnimation]; // 进入图文详情的动画
        }
    }
}
// 进入详情的动画
- (void)goToDetailAnimation
{
    
    self.navigationItem.title = @"图文详情";
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.detailView.frame = CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight);
        self.tableView.frame = CGRectMake(0, -kScreenHeight, kScreenWidth, kScreenHeight);
         self.DesCellcell.bottomView.hidden = YES;
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
       
        self.titlelabel.hidden =NO;
        self.titlelabel.frame = CGRectMake(0,kStatusBarHeight , kRealValue(100), 44);
        self.titlelabel.centerX =  self.view.centerX;
    } completion:^(BOOL finished) {
        
    }];
    
}
// 返回第一个界面的动画
- (void)backToFirstPageAnimation
{
    self.navigationItem.title = @"商品详情";
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.titlelabel.frame = CGRectMake(0,kTopHeight , kRealValue(100), 44);
        self.titlelabel.centerX =  self.view.centerX;
        self.titlelabel.hidden =YES;
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
     self.DesCellcell.bottomView.hidden = NO;
        self.detailView.frame = CGRectMake(0,kScreenHeight, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
       
    }];

}

#pragma mark --- ProductDetailViewDelegate ---
- (void)pullDragAndShowProduct
{
    
    [self backToFirstPageAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
