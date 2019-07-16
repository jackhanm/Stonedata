//
//  STmineViewController.m
//  Stonedata
//
//  Created by yuhao on 2019/7/15.
//  Copyright © 2019 hf. All rights reserved.
//

#import "STmineViewController.h"
#import "MHMineHeadCell.h"
#import "STItemTableViewCell.h"
#import "MHMineManagerCell.h"
#import "MHMineHelpCell.h"
#import "MHMineUserInfoViewController.h"
#import "MHMineUserInfoAddressViewController.h"
#import "MHMineSettingViewController.h"
#import "MHMineUserCollectionViewController.h"
#import "MHMyOrderViewController.h"
#import "MHMessageListViewController.h"
#import "MHStoreVC.h"
#import "MHWebviewViewController.h"
#import "MHTimeLimitViewController.h"
#import "MHLoginViewController.h"
#import "MHSumbitOrderVC.h"
#import "MHMyOrderViewController.h"
#import "XWPublishController.h"
#import "STCollectViewController.h"
@interface STmineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableDictionary *dict;
@end

@implementation STmineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = KColorFromRGB(0xf4f4f4);
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)createview
{
    _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight);
    _contentTableView.backgroundColor = KColorFromRGB(0xF1F2F1);
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
    
    _contentTableView.estimatedRowHeight = 0;
    _contentTableView.sectionHeaderHeight= 0;
    _contentTableView.estimatedSectionFooterHeight = 0;
    _contentTableView.dataSource = self;
    _contentTableView.delegate = self;
    _contentTableView.showsVerticalScrollIndicator = NO;
    [_contentTableView registerClass:[MHMineHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHMineHeadCell class])];
    [_contentTableView registerClass:[STItemTableViewCell class] forCellReuseIdentifier:NSStringFromClass([STItemTableViewCell class])];
    [_contentTableView registerClass:[MHMineManagerCell class] forCellReuseIdentifier:NSStringFromClass([MHMineManagerCell class])];
    [_contentTableView registerClass:[MHMineHelpCell class] forCellReuseIdentifier:NSStringFromClass([MHMineHelpCell class])];
    
    if (@available(iOS 11.0, *)) {
        _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.contentTableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return kRealValue(125)+kStatusBarHeight;
    }
    if (indexPath.row == 1) {
        return kRealValue(65);
    }
    if (indexPath.row == 2) {
        return kRealValue(159);
    }
    if (indexPath.row == 3) {
        return kRealValue(103);
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MHMineHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHMineHeadCell class])];
        //        cell.backgroundColor = kRandomColor;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.Gotomeg = ^{
            if ([GVUserDefaults standardUserDefaults].accessToken) {
                //消息
                MHMessageListViewController *vc= [[MHMessageListViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                MHLoginViewController *login = [[MHLoginViewController alloc] init];
                UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                [self presentViewController:userNav animated:YES completion:nil];
            }
        };
        cell.GotoUserInfo = ^{
            MHMineUserInfoViewController *vc = [[MHMineUserInfoViewController alloc]init];
            vc.dic = self.dict;
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        if (!klObjectisEmpty(self.dict) ) {
            [cell.headimageview sd_setImageWithURL:[NSURL URLWithString:[self.dict valueForKey:@"userImage"]] placeholderImage:kGetImage(@"user_pic")];
            cell.username.text = [self.dict valueForKey:@"userNickName"];
            NSString *str = [NSString stringWithFormat:@"%@",[self.dict valueForKey:@"userRole"]];
            
            switch ([str integerValue]) {
                case 0:
                    //内部员工
                    cell.userlever.text = @"内部员工";
                    cell.userleverImage.image = kGetImage(@"ic_store_member_white");
                    break;
                case 1:
                    //普通会员
                    cell.userlever.text = @"普通会员";
                    cell.userleverImage.image = kGetImage(@"ic_store_member_white");
                    break;
                    
                case 2:
                    //尊贵店主
                    cell.userlever.text = @"店主";
                    cell.userleverImage.image = kGetImage(@"ic_store_store_white");
                    break;
                case 3:
                    //掌柜子
                    cell.userlever.text = @"掌柜子";
                    cell.userleverImage.image = kGetImage(@"ic_data_manager_white");
                    break;
                case 4:
                    //分舵主
                    cell.userlever.text = @"分舵主";
                    cell.userleverImage.image = kGetImage(@"ic_data_rudder_white");
                    break;
                default:
                    break;
            }
            
        }
        return cell;
    }
    if (indexPath.row == 1) {
        STItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([STItemTableViewCell class])];
        cell.seeorderWithtype = ^(NSInteger type) {
            if (type == 160000) {
                STCollectViewController *vc = [[STCollectViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        };
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    if (indexPath.row == 2) {
        MHMineManagerCell *cell = [[MHMineManagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];;
        //        cell.backgroundColor = kRandomColor;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        kWeakSelf(self);
        
        
        cell.tapAct = ^(NSInteger tag) {
            if (tag == 15000) {
                if ([GVUserDefaults standardUserDefaults].accessToken) {
                    //消息
                    MHMessageListViewController *vc= [[MHMessageListViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    MHLoginViewController *login = [[MHLoginViewController alloc] init];
                    UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                    [self presentViewController:userNav animated:YES completion:nil];
                }
            }
            if (tag == 15001) {
                MHLog(@"意见反馈");
                XWPublishController *vc = [[XWPublishController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (tag == 15003) {
                MHMineUserCollectionViewController *vc = [[MHMineUserCollectionViewController alloc]init];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
            if (tag == 15004) {
                
                MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/help_center.html" comefrom:@"mine"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if (tag == 15002) {
                if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
                    [self.tabBarController setSelectedIndex:2];
                }else{
                    MHStoreVC *vc = [[MHStoreVC alloc]init];
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
            }
            
        };
        return cell;
    }
    if (indexPath.row == 3) {
        MHMineHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHMineHelpCell class])];
        cell.HelpCenter = ^{
            MHMineSettingViewController *vc = [[MHMineSettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        //        cell.backgroundColor = kRandomColor;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == 0) {
    //        MHMineUserInfoViewController *vc = [[MHMineUserInfoViewController alloc]init];
    //        vc.dic = self.dict;
    //        [self.navigationController pushViewController:vc animated:YES];
    //
    //    }
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