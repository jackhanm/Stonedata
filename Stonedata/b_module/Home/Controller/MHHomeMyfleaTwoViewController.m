//
//  MHHomeMyfleaTwoViewController.m
//  mohu
//
//  Created by yuhao on 2019/1/9.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHHomeMyfleaTwoViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "MHHomefleaTwoCell.h"
#import "MHHomefleaOneStepSaleViewController.h"
#import "MHHomeMyfleaViewController.h"
@interface MHHomeMyfleaTwoViewController ()<UITableViewDataSource,UITableViewDelegate, CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign)NSInteger  index;
@property (nonatomic, strong) UIImageView *headImageView;
@end
@implementation MHHomeMyfleaTwoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.index = 1;
    self.listArr = [NSMutableArray array];
    [self getdata];
}
-(void)getdata
{
    [[MHUserService sharedInstance]initWithMYRecoredBusNiessListpageIndex:self.index pageSize:20 completionBlock:^(NSDictionary *response, NSError *error) {
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
    [self.view addSubview:self.contentTableView];
    self.contentTableView.mj_header = [MHRefreshNomalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getdata];
    }];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getdata];
    }];
    
    
    // Do any additional setup after loading the view.
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


-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight -kTopHeight - kRealValue(160));
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        [_contentTableView registerClass:[MHHomefleaTwoCell class] forCellReuseIdentifier:NSStringFromClass([MHHomefleaTwoCell class])];
        _contentTableView.showsVerticalScrollIndicator = NO;
        
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
    return kRealValue(178);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHHomefleaTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHomefleaTwoCell class])];
    if (self.listArr.count > 0) {
        [cell createviewWithModel:[self.listArr objectAtIndex:indexPath.row]];
        
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
