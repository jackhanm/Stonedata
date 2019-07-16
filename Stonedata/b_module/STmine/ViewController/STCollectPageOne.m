//
//  STCollectPageOne.m
//  Stonedata
//
//  Created by yuhao on 2019/7/15.
//  Copyright © 2019 hf. All rights reserved.
//

#import "STCollectPageOne.h"
#import "HSMemberThreeCell.h"
#import "HSMemberNoImgCell.h"
#import "HSMemberOneCell.h"
#import "HSMemberOneRight.h"
#import "HSMemberOneLeftCell.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "HSEmporCell.h"
@interface STCollectPageOne ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic, assign)NSInteger  index;
@end

@implementation STCollectPageOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 1;
    self.view.backgroundColor = KColorFromRGB(0xffffff);
     [self createview];
    // Do any additional setup after loading the view.
}

-(void)getdata
{
    
}
-(void)createview
{
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
-(void)NodataemptyOverlayClicked:(id)sender
{
    self.index = 1;
    [self getdata];
    
}
- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:self.tableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:self.tableView.frame];
    networkErrorPlaceHolder.textLabel.text= @"点击刷新";
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}
-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    [self.tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.1,kScreenWidth, kScreenHeight-kTabBarHeight-kRealValue(44)-kRealValue(42)-kStatusBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
       

        [_tableView registerClass:[HSMemberThreeCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberThreeCell class])];
        [_tableView registerClass:[HSMemberOneCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberOneCell class])];
        [_tableView registerClass:[HSMemberNoImgCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberNoImgCell class])];
        [_tableView registerClass:[HSMemberOneRight class] forCellReuseIdentifier:NSStringFromClass([HSMemberOneRight class])];
        [_tableView registerClass:[HSMemberOneLeftCell class] forCellReuseIdentifier:NSStringFromClass([HSMemberOneLeftCell class])];
        [_tableView registerClass:[HSEmporCell class] forCellReuseIdentifier:NSStringFromClass([HSEmporCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (self.listArr.count > 0) {
//        MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row];
//        if (model.cover.count == 0) {
//            if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)]> kRealValue(50)) {
//                return kRealValue(105);
//            }
//            return kRealValue(55) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
//        }
//        if (model.cover.count >1 ) {
//            if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)]> kRealValue(50)) {
//                return kRealValue(185);
//            }
//            return kRealValue(133) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
//        }
//        if (model.cover.count == 1) {
//            if ([model.coverPos isEqualToString:@"LEFT"]) {
//
//                return   kRealValue(124);
//            }
//            else if ([model.coverPos isEqualToString:@"RIGHT"]) {
//
//                return   kRealValue(124);
//            }
//            else {
//                if ([model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)]> kRealValue(50)) {
//                    return kRealValue(320);
//                }
//                return kRealValue(267) + [model.title heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(16)] width:kRealValue(361)];
//            }
//
//
//        }
//    }
    return 0;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (self.listArr.count > 0) {
//        MHTaskDetailModel *model = [self.listArr objectAtIndex:indexPath.row];
//        if (model.cover.count == 0) {
//            HSMemberNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberNoImgCell class])];
//            cell.selectionStyle= UITableViewCellSelectionStyleNone;
//            [cell createviewWithModel:model];
//            return cell;
//        }
//        if (model.cover.count >1 ) {
//            HSMemberThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberThreeCell class])];
//            cell.selectionStyle= UITableViewCellSelectionStyleNone;
//            [cell createviewWithModel:model];
//            return cell;
//        }
//        if (model.cover.count == 1) {
//            if ([model.coverPos isEqualToString:@"LEFT"]) {
//
//                HSMemberOneLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberOneLeftCell class])];
//                cell.selectionStyle= UITableViewCellSelectionStyleNone;
//                [cell createviewWithModel:model];
//                return cell;
//            }
//            else if ([model.coverPos isEqualToString:@"RIGHT"]) {
//                HSMemberOneRight *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberOneRight class])];
//                cell.selectionStyle= UITableViewCellSelectionStyleNone;
//                [cell createviewWithModel:model];
//                return cell;
//            }
//            else {
//                HSMemberOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSMemberOneCell class])];
//                cell.selectionStyle= UITableViewCellSelectionStyleNone;
//                [cell createviewWithModel:model];
//                return cell;
//            }
//
//
//        }
//    }
    
    HSEmporCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HSEmporCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
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
