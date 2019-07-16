//
//  MHHomefleaShopViewController.m
//  mohu
//
//  Created by yuhao on 2019/1/8.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHHomefleaShopViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "MHHomefleaShopCell.h"
#import "MHHomefleaOneStepSaleViewController.h"
#import "MHHomeMyfleaViewController.h"
#import "MHflealistModel.h"
#import "MHLoginViewController.h"
#import "MHWebviewViewController.h"

@interface MHHomefleaShopViewController ()<UITableViewDataSource,UITableViewDelegate, CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign)NSInteger  index;
@property (nonatomic, strong) UIImageView *headImageView;
@end

@implementation MHHomefleaShopViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.index = 1;
    self.listArr = [NSMutableArray array];
    [self getdata];
}
-(void)getdata
{
    [[MHUserService sharedInstance]initWithRecoredListpageIndex:self.index pageSize:20 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr  removeAllObjects];
            }
            [self.listArr addObjectsFromArray:[MHflealistModel baseModelWithArr:[response valueForKey:@"data"]]];
            
            if ([ response[@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.contentTableView cyl_reloadData];
        }
        if (error) {
            [self.contentTableView cyl_reloadData];
        }
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xF2F3F2);
    self.title = @"跳蚤市场";
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)MyFlea
{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        //消息
        MHHomeMyfleaViewController *vc = [[MHHomeMyfleaViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
   

}
    


-(void)createview
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kRealValue(10), kRealValue(60), kRealValue(30));
    btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [btn setTitle:@"我的跳蚤" forState:UIControlStateNormal];
    [btn setTitleColor:KColorFromRGB(0x333333) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(MyFlea) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightItem];
    [self.view addSubview:self.contentTableView];
    self.contentTableView.mj_header = [MHRefreshNomalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getdata];
    }];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getdata];
    }];
    
}
- (UIView *)makePlaceHolderView {
    //    UIView *taobaoStyle = [self taoBaoStylePlaceHolder];
    if ([[MHBaseClass sharedInstance]isErrorNetWork]) {
        UIView *errorNetWork = [self MHNetworkErrorPlaceHolder];
        return errorNetWork;
    }else{
        UIView *noData = [self MHNoDataPlaceHolder];
        return noData;
    }
    
}

- (void)emptyOverlayClicked:(id)sender {
    self.index = 1;
    [self getdata];
}

- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    return networkErrorPlaceHolder;
}

-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.contentTableView.mj_header endRefreshing];
    });
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.contentTableView.mj_header endRefreshing];
    });
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
}
-(void)tap
{
    NSString *str  = [NSString stringWithFormat:@"%@%@",kMHHostWAP,@"/tsrule.html"];
    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:str comefrom:@"LauchImage"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        [_contentTableView registerClass:[MHHomefleaShopCell class] forCellReuseIdentifier:NSStringFromClass([MHHomefleaShopCell class])];
        _contentTableView.showsVerticalScrollIndicator = NO;
        UIView *headbg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(100))];
        headbg.backgroundColor = KColorFromRGB(0xF2F3F2);
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(10), kScreenWidth-kRealValue(20), kRealValue(90))];
        _headImageView.image = kGetImage(@"pic1");
        _headImageView.userInteractionEnabled = YES;
       
        [headbg addSubview:self.headImageView];
        
        UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.headImageView addGestureRecognizer:tapAct];
        _contentTableView.tableHeaderView = headbg;
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRealValue(142);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHHomefleaShopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHomefleaShopCell class])];
    if (self.listArr.count> 0 ) {
        MHflealistModel *model = [self.listArr objectAtIndex:indexPath.row];
        [cell createviewWithModel:model];
    }
    cell.backgroundColor = KColorFromRGB(0xF2F3F2);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        //消息
        MHflealistModel *model =[self.listArr objectAtIndex:indexPath.row];
        if (model.ownCount == 0 ) {
            KLToast(@"暂未拥有该商品");
        }else{
            MHHomefleaOneStepSaleViewController *VC = [[MHHomefleaOneStepSaleViewController alloc]initWithmodel:[self.listArr objectAtIndex:indexPath.row]];
            //    VC.model =[self.listArr objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
  
   
   
    
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
