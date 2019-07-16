//
//  MHMineSettingViewController.m
//  mohu
//
//  Created by yuhao on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineSettingViewController.h"
#import "MHMineUserInfoCommonView.h"
#import "MHAboutMHViewController.h"
#import "MHAlertViewController.h"
#import "XWPublishController.h"



@interface MHMineSettingViewController ()
@property(nonatomic, strong)UIScrollView *activityScroll;
@property(nonatomic, strong)MHMineUserInfoCommonView *cleanview;
@property (nonatomic, strong) UIButton *loginout;
@end

@implementation MHMineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = KColorFromRGB(0xf1f2f5);
    
    self.activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
    self.activityScroll.backgroundColor = KColorFromRGB(0xf1f2f5);
    self.activityScroll.showsHorizontalScrollIndicator = NO;
    self.activityScroll.showsVerticalScrollIndicator = NO;
    self.activityScroll.contentSize = CGSizeMake(0,kScreenHeight);
    
    MHMineUserInfoCommonView *noticeView = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0, kRealValue(10), kScreenWidth, kRealValue(50)) righttitle:@"" lefttitle:@"消息通知" istopLine:YES isBottonLine:YES];
    [self.activityScroll addSubview:noticeView];
    UITapGestureRecognizer *noticetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noticeAct)];
    [noticeView addGestureRecognizer:noticetap];
    
    MHMineUserInfoCommonView *adviceView = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0, kRealValue(70), kScreenWidth, kRealValue(50)) righttitle:@"" lefttitle:@"意见反馈" istopLine:YES isBottonLine:YES];
    [self.activityScroll addSubview:adviceView];
    UITapGestureRecognizer *advicetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adviceAct)];
    [adviceView addGestureRecognizer:advicetap];
    
    MHMineUserInfoCommonView *aboutMH = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0, kRealValue(130), kScreenWidth, kRealValue(50)) righttitle:@"" lefttitle:@"关于未来商视" istopLine:YES isBottonLine:NO];
    [self.activityScroll addSubview:aboutMH];
    
    UITapGestureRecognizer *AboutMHtapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aboutMh)];
    [aboutMH addGestureRecognizer:AboutMHtapAct];
    
    
    
    float picCount = [[SDImageCache sharedImageCache]getSize]/1000.0;
    float lastCount = picCount/1000.0;
    _cleanview = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0, kRealValue(180), kScreenWidth, kRealValue(50)) righttitle:[NSString stringWithFormat:@"%.1fM",lastCount] lefttitle:@"清空缓存" istopLine:NO isBottonLine:NO];
    [self.activityScroll addSubview:_cleanview];
    
    UITapGestureRecognizer *cleantap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cleanAct)];
    [_cleanview addGestureRecognizer:cleantap];
    
    
    MHMineUserInfoCommonView *version = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0, kRealValue(230), kScreenWidth, kRealValue(50)) righttitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] lefttitle:@"版本号" istopLine:NO isBottonLine:YES];
    [self.activityScroll addSubview:version];
    self.loginout = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginout.backgroundColor = KColorFromRGB(0xcccccc);
    self.loginout.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
    [self.loginout setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.loginout setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.loginout.layer.masksToBounds =YES;
    self.loginout.layer.cornerRadius = 5;
    [self.loginout addTarget:self action:@selector(loginout:) forControlEvents:UIControlEventTouchUpInside];
    self.loginout.frame =CGRectMake(kRealValue(108), kRealValue(310), kRealValue(160), kRealValue(40));
    [self.activityScroll addSubview:self.loginout];
    [self.view addSubview:self.activityScroll];
    
    // Do any additional setup after loading the view.
}
-(void)noticeAct
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}
-(void)adviceAct
{
    MHLog(@"意见反馈");
    XWPublishController *vc = [[XWPublishController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)loginout:(UIButton *)sender
{
    [[MHBaseClass sharedInstance] loginOut];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshHome object:nil userInfo:nil];
    UITabBarController *tabBarController = (UITabBarController *)kRootViewController;
    tabBarController.selectedIndex = 0;
    KLToast(@"退出成功");
}
- (void)aboutMh
{
    MHAboutMHViewController *vc =[[MHAboutMHViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)cleanAct{

    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"真的要清除缓存吗？" ];
    alertVC.messageAlignment = NSTextAlignmentCenter;
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
        [alertVC showDisappearAnimation];
    }];
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"立即清除" handler:^(CKAlertAction *action) {
        [[MHBaseClass sharedInstance] removeAppCatch];
        _cleanview.righttitle.text = @"0.0M";
        [alertVC showDisappearAnimation];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:NO completion:nil];
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
