//
//  MHMyJoinedViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/17.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMyJoinedViewController.h"
#import "MHHuGuessOrderListCell.h"
#import "MHPriceMoreDetailViewController.h"
#import "MHStartprizeMoreOrderModel.h"
#import "MHStartprizeModelOrdersinger.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
@interface MHMyJoinedViewController ()<UITableViewDataSource,UITableViewDelegate, CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) NSInteger  index;
@end



@implementation MHMyJoinedViewController
- (instancetype)initWithComeform:(NSString *)comeform
{
    self = [super init];
    if (self) {
        self.comeform = comeform;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
}
-(void)getdata
{
   
    [[MHUserService sharedInstance]initwithtackpartInwithdrawAllType:@"0" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",_index] morecompletionBlock:^(NSDictionary *response, NSError *error) {
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
-(void)getdatahucai
{
    [[MHUserService sharedInstance]initwithtackpartInwithdrawAllType:@"1" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",_index] morecompletionBlock:^(NSDictionary *response, NSError *error) {
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

- (void)viewDidLoad {
    [super viewDidLoad];
      self.index = 1;
    self.title =@"我参与的";
     self.listArr = [NSMutableArray array];
    if ([self.comeform isEqualToString:@"myprize"]) {
        [self getdata];
    }else{
        [self getdatahucai];
    }
    self.view.backgroundColor = KColorFromRGB(0xEDEFF0);
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)createview
{
    [self.view addSubview:self.contentTableView];
    self.contentTableView.mj_header = [MHRefreshNomalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        if ([self.comeform isEqualToString:@"myprize"]) {
            [self getdata];
        }else{
            [self getdatahucai];
        }
    }];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        if ([self.comeform isEqualToString:@"myprize"]) {
            [self getdata];
        }else{
            [self getdatahucai];
        }
    }];

}
-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        cell.userInfo = 1;
        cell.comeform = self.comeform;
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
    NSString *Str = [[self.listArr objectAtIndex:section] valueForKey:@"date"];
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
        MHPriceMoreDetailViewController *vc = [[MHPriceMoreDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@",sigerModel.shareId] comefrom:@"order"];
        
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