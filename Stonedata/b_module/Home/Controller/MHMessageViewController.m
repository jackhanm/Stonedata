


//
//  MHMessageViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMessageViewController.h"
#import "MHMineitemView.h"
#import "MHMessageListViewController.h"
#import "MHMineProductCommentController.h"
#import "MHRecordPresentViewController.h"
#import "MHHucaiGuessOrderViewController.h"
#import "MHMessageListViewController.h"
#import <JSBadgeView.h>
#import "MHWebviewViewController.h"
@interface MHMessageViewController ()
@property(nonatomic, strong)MHMineitemView * itemview;
@property(nonatomic, strong)MHMineitemView * itemview1;
@property(nonatomic, strong)MHMineitemView * itemview2;
@property(nonatomic, strong)MHMineitemView * itemview3;
@property(nonatomic, strong)JSBadgeView *badgeView;
@property(nonatomic, strong)JSBadgeView *badgeView1;
@property(nonatomic, strong)JSBadgeView *badgeView2;

@end

@implementation MHMessageViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"消息";
   
    self.view.backgroundColor = KColorFromRGB(0xF2F3F5);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 10, 80, 20);
    btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
    [btn setTitle:@"全部已读" forState:UIControlStateNormal];
    [btn setTitleColor:KColorFromRGB(0x689DFF) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Allread) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    NSArray *imageArr = [NSArray arrayWithObjects:@"ic_news_notice",@"ic_news_assets",@"ic_news_assets",@"ic_news_help",nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"通知公告",@"我的资产",@"活动通知",@"帮助中心",nil];
    NSArray *subtitleArr = [NSArray arrayWithObjects:@"未来商视最新消息，关于你的点点滴滴",@"资产动态，流水记录",@"狐猜,奖多多活动消息",@"疑难问题求助，在线客服",nil];
    
    NSInteger pading = 10;
    NSInteger lox = 10;
    self.itemview  = [[MHMineitemView alloc]initWithFrame:CGRectMake(0, pading*0+kRealValue(60) *0+lox, kScreenWidth, kRealValue(60)) title:titleArr[0] subtitle:subtitleArr[0] imageStr:imageArr[0] righttitle:@"暂未开放" isline:NO isRighttitle:NO];
    self.itemview.tag = 18000+0;
    self.itemview.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:self.itemview];
    
    self.badgeView = [[JSBadgeView alloc] initWithParentView:self.itemview.leftIcon alignment:JSBadgeViewAlignmentTopRight];
   
    UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.itemview addGestureRecognizer:tapAct];
    
    
    
    self.itemview1  = [[MHMineitemView alloc]initWithFrame:CGRectMake(0, pading*1+kRealValue(60) *1+lox, kScreenWidth, kRealValue(60)) title:titleArr[1] subtitle:subtitleArr[1] imageStr:imageArr[1] righttitle:@"暂未开放" isline:NO isRighttitle:NO];
    self.itemview1.tag = 18000+1;
    self.itemview1.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:self.itemview1];
    
    self.badgeView1 = [[JSBadgeView alloc] initWithParentView:self.itemview1.leftIcon alignment:JSBadgeViewAlignmentTopRight];
   
    UITapGestureRecognizer *tapAct1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.itemview1 addGestureRecognizer:tapAct1];
    
    
    self.itemview2  = [[MHMineitemView alloc]initWithFrame:CGRectMake(0, pading*2+kRealValue(60) *2+lox, kScreenWidth, kRealValue(60)) title:titleArr[2] subtitle:subtitleArr[2] imageStr:imageArr[2] righttitle:@"暂未开放" isline:NO isRighttitle:NO];
    self.itemview2.tag = 18000+2;
    self.itemview2.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:self.itemview2];
    
    self.badgeView2 = [[JSBadgeView alloc] initWithParentView:self.itemview2.leftIcon alignment:JSBadgeViewAlignmentTopRight];
   
    UITapGestureRecognizer *tapAct2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.itemview2 addGestureRecognizer:tapAct2];
    
    
    
    self.itemview3  = [[MHMineitemView alloc]initWithFrame:CGRectMake(0, pading*3+kRealValue(60) *3+lox, kScreenWidth, kRealValue(60)) title:titleArr[3] subtitle:subtitleArr[3] imageStr:imageArr[3] righttitle:@"暂未开放" isline:NO isRighttitle:NO];
    self.itemview3.tag = 18000+3;
    self.itemview3.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:self.itemview3];
    UITapGestureRecognizer *tapAct3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.itemview3 addGestureRecognizer:tapAct3];

    // Do any additional setup after loading the view.
}
-(void)getdata
{

    [[MHUserService sharedInstance]initWithGetMessageUnreadtypeCodeList:@"NOTICE,ACTIVITY,CAPITAL" CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            NSMutableArray *arr = [response valueForKey:@"data"];
            for (int i =0; i < arr.count; i++) {
                if ([[arr[i] valueForKey:@"typeCode"] isEqualToString:@"NOTICE"]) {
                    if ([[NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"unreadCount"]] isEqualToString:@"0"]) {
                        self.badgeView.hidden = YES;
                    }else{
                         self.badgeView.badgeText = [NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"unreadCount"]];
                    }
                   
                }
                if ([[arr[i] valueForKey:@"typeCode"] isEqualToString:@"ACTIVITY"]) {
                    
                    if ([[NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"unreadCount"]] isEqualToString:@"0"]) {
                        self.badgeView2.hidden =YES;
                    }else{
                         self.badgeView2.badgeText = [NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"unreadCount"]];
                    }
                    
                   
                }
                if ([[arr[i] valueForKey:@"typeCode"] isEqualToString:@"CAPITAL"]) {
                    if ([[NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"unreadCount"]] isEqualToString:@"0"]) {
                        self.badgeView1.hidden =YES;
                    }else{
                       self.badgeView1.badgeText = [NSString stringWithFormat:@"%@",[arr[i] valueForKey:@"unreadCount"]];
                    }
                    
                    
                }
            }
            
        }
        
    }];
}
-(void)tapAction:(UITapGestureRecognizer *)sender
{
    if (sender.view.tag == 18000) {
        MHMessageListViewController *vc = [[MHMessageListViewController alloc]initWithtypeCode:@"NOTICE"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.view.tag == 18001) {
        MHMessageListViewController *vc = [[MHMessageListViewController alloc]initWithtypeCode:@"CAPITAL"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.view.tag == 18002) {
        MHMessageListViewController *vc = [[MHMessageListViewController alloc]initWithtypeCode:@"ACTIVITY"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.view.tag == 18003) {
        MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/help_center.html" comefrom:@"notice"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)Allread
{
    [[MHUserService sharedInstance]initWithCleanMessageUnreadtypeCodeList:@"NOTICE,ACTIVITY,CAPITAL" CompletionBlock:^(NSDictionary *response, NSError *error) {
         if (ValidResponseDict(response)) {
             self.badgeView.badgeText = @"0";
             self.badgeView.hidden = YES;
             self.badgeView1.badgeText = @"0";
             self.badgeView1.hidden = YES;
             self.badgeView2.badgeText = @"0";
             self.badgeView2.hidden = YES;
             KLToast(@"清除成功");
         }else{
             KLToast([response valueForKey:@"message"]);
         }
    }];
    
    
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
