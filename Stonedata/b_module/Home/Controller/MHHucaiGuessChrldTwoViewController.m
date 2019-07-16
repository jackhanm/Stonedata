//
//  MHHucaiGuessChrldTwoViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHucaiGuessChrldTwoViewController.h"
#import "MHHuGuessOrderListCell.h"
#import "MHGuessOrderdetailViewController.h"
#import "MHStartprizeMoreOrderModel.h"
#import "MHStartprizeModelOrdersinger.h"
#import "MHHuGuessDetailViewController.h"
#import "MHMyJoinedViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
@interface MHHucaiGuessChrldTwoViewController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) NSInteger  index;
@end

@implementation MHHucaiGuessChrldTwoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _index  = 1;
    self.listArr = [NSMutableArray array];
    [self getdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = KColorFromRGB(0xEDEFF0);
    [self createview];
    
    
    // Do any additional setup after loading the view.
}

-(void)getdata
{
    if ([[GVUserDefaults standardUserDefaults].userRole integerValue] == 1) {
       
        [[MHUserService sharedInstance]initwithtackpartInwithdrawAllType:@"1" pageSize:@"20" pageIndex:[NSString stringWithFormat:@"%ld",_index] morecompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                if (self.index == 1) {
                    [self.listArr  removeAllObjects];
                }
                NSMutableArray *arr1 = [response valueForKey:@"data"];
                for (int i = 0; i < arr1.count; i++) {
                    MHStartprizeMoreOrderModel *model = [[MHStartprizeMoreOrderModel alloc]init];
                    model.date = [arr1[i] valueForKey:@"date"];
                    NSMutableArray *arr2 = [arr1[i] valueForKey:@"list"];
                    NSMutableArray *Arr2 = [MHStartprizeModelOrdersinger baseModelWithArr:arr2];
                    model.listArr = Arr2;
                   [self.listArr addObject:model];
                    
                }
                
                if (arr1.count > 0) {
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
        
    }else{
        [[MHUserService sharedInstance]initwithStartOrderListPrizewithdrawAllType:@"1" pageSize:@"20" pageIndex:[NSString stringWithFormat:@"%ld",_index] morecompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                if (self.index == 1) {
                    [self.listArr  removeAllObjects];
                    
                }
                NSMutableArray *arr1 = [response valueForKey:@"data"];
                for (int i = 0; i < arr1.count; i++) {
                    MHStartprizeMoreOrderModel *model = [[MHStartprizeMoreOrderModel alloc]init];
                    model.date = [arr1[i] valueForKey:@"date"];
                    NSMutableArray *arr2 = [arr1[i] valueForKey:@"list"];
                    NSMutableArray *Arr2 = [MHStartprizeModelOrdersinger baseModelWithArr:arr2];
                    model.listArr = Arr2;
                    [self.listArr addObject:model];
                }
                if (arr1.count > 0) {
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


-(void)createview
{
    [self.view addSubview:self.contentTableView];
    self.contentTableView.mj_header = [MHRefreshNomalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getdata];
    }];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getdata];
    }];
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"我参与的" forState:UIControlStateNormal];
    btn.backgroundColor = KColorFromRGB(0xFF6F59);
    btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    btn.frame =CGRectMake(kScreenWidth - kRealValue(70), kScreenHeight - kRealValue(50)-kTopHeight - kBottomHeight-kRealValue(44), kRealValue(80), kRealValue(24));
    btn.layer.cornerRadius = kRealValue(12);
    [btn addTarget:self action:@selector(myjoinedVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    if ([[GVUserDefaults standardUserDefaults].userRole integerValue] < 2) {
        btn.hidden= YES;
    }
}
-(void)myjoinedVc
{
    MHMyJoinedViewController *vc =[[MHMyJoinedViewController alloc]initWithComeform:@"hucai"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _contentTableView.backgroundColor = KColorFromRGB(0xEDEFF0);
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHHuGuessOrderListCell class] forCellReuseIdentifier:NSStringFromClass([MHHuGuessOrderListCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(190);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHHuGuessOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHuGuessOrderListCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor =KColorFromRGB(0xEDEFF0);
    if (self.listArr.count > 0) {
        MHStartprizeMoreOrderModel *model= [self.listArr objectAtIndex:indexPath.section];
        NSMutableArray *arr = model.listArr;
        MHStartprizeModelOrdersinger *singermodel = arr[indexPath.row];
        if ([[GVUserDefaults standardUserDefaults].userRole integerValue] == 1) {
            //参与者
            cell.userInfo = 1;
        }else{
            cell.userInfo = 0;
        }
        cell.comeform = @"hucai";
        cell.prizemoreModel = singermodel;
        
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 35;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    
    
    headerView.backgroundColor = KColorFromRGB(0xEDEFF0);
    UILabel *label = [[UILabel alloc]init];
    NSDictionary *attrDict = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                               NSForegroundColorAttributeName:[UIColor blackColor]
                               };
    NSString *Str =@"" ;
    if (self.listArr.count > 0) {
     Str= [[self.listArr objectAtIndex:section] valueForKey:@"date"];
    }
   
    NSMutableAttributedString *attr1 = [[NSMutableAttributedString alloc]initWithString:Str attributes:attrDict];
    
    label.attributedText = attr1;
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView.mas_left).offset(kRealValue(16));
    }];
    
    return headerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.listArr.count > 0) {
        MHStartprizeMoreOrderModel *model= [self.listArr objectAtIndex:section];
        return model.listArr.count;
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArr.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArr.count > 0) {
        MHStartprizeMoreOrderModel *model= [self.listArr objectAtIndex:indexPath.section];
        NSMutableArray *Arr = model.listArr;
        MHStartprizeModelOrdersinger *sigerModel = [Arr objectAtIndex:indexPath.row];
        MHHuGuessDetailViewController *vc = [[MHHuGuessDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@",sigerModel.shareId] comefrom:@"order"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
