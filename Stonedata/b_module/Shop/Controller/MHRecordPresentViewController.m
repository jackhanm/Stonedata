


//
//  MHRecordPresentViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHRecordPresentViewController.h"
#import "MHRecordPresentCell.h"
#import "MHRecordPresentStatuController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "MHWithDrawRecordModel.h"

@interface MHRecordPresentViewController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) NSInteger  index;

@end

@implementation MHRecordPresentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现记录";
    self.view.backgroundColor = KColorFromRGB(0xEEEFF1);
    _index = 1;
    _listArr = [NSMutableArray array];
    [self createview];
    [self getData];
    self.contentTableView.mj_header = [MHRefreshNomalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getData];
    }];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getData];
    }];
}


-(void)createview{
    [self.view addSubview:self.contentTableView];
}


-(void)getData{
    
    [[MHUserService sharedInstance]initwithWithDrawDataPageIndex:_index pageSize:20 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[MHWithDrawRecordModel baseModelWithArr:response[@"data"][@"list"]]];
            [self.contentTableView cyl_reloadData];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
        if (error) {
            [self.contentTableView cyl_reloadData];
        }
    }];
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

- (void)emptyOverlayClicked:(id)sender {
    self.index = 1;
    [self getData];
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
        [_contentTableView registerClass:[MHRecordPresentCell class] forCellReuseIdentifier:NSStringFromClass([MHRecordPresentCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(73);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHRecordPresentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHRecordPresentCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor =KColorFromRGB(0xffffff);
    MHWithDrawRecordModel *model =_listArr[indexPath.row];

    cell.RecordPresentname.text = model.takeDate;
    cell.RecordPresentbank.text = model.takeTypeName;
    cell.RecordPresentnum.text = [NSString stringWithFormat:@"-%.2f",model.money];
    cell.RecordPresenttime.text = model.takeTime;
    cell.RecordPresentcardnum.text = model.takeTypeCode;
    cell.RecordPresentstate.text = model.takeState;
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return _listArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MHRecordPresentStatuController *vc =[[MHRecordPresentStatuController alloc]init];
    vc.model = _listArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UIView *)makePlaceHolderView {
    if ([[MHBaseClass sharedInstance]isErrorNetWork]) {
        UIView *errorNetWork = [self MHNetworkErrorPlaceHolder];
        return errorNetWork;
    }else{
        UIView *noData = [self MHNoDataPlaceHolder];
        return noData;
    }
    
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


@end
