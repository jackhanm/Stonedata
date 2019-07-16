//
//  MHProductDetailCommentViewController.m
//  mohu
//
//  Created by 余浩 on 2018/9/22.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProductDetailCommentViewController.h"

#import "MHCommentDetailCell.h"
#import "MHCommentDetailCellHeadCell.h"
#import "MHCommentDetailCellBottomCell.h"
#import "MHProductCommentListModel.h"
#import "MHProductCommentModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "MHProductDetailCellHeadTwo.h"
@interface MHProductDetailCommentViewController ()<UITableViewDataSource,UITableViewDelegate, CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableDictionary *dataDic;
@property(nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, assign)NSInteger  index;
@end

@implementation MHProductDetailCommentViewController

- (instancetype)initWithDic:(NSMutableDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.dict = dic;
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
-(void)getdata
{
    
    
    [[MHUserService sharedInstance] initwithCommentProductId:[NSString stringWithFormat:@"%@",[self.dict valueForKey:@"productId"]] pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",_index] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.dataArr  removeAllObjects];
                 self.dataDic = (NSMutableDictionary *)[MHProductCommentListModel baseModelWithDic:[response valueForKey:@"data"]];
            }
           [self.dataArr addObjectsFromArray:[MHProductCommentModel baseModelWithArr:[[response valueForKey:@"data"] valueForKey:@"list"]]];
        
            if ([[[response valueForKey:@"data"] valueForKey:@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.tableView cyl_reloadData];
           
        }
        if (error) {
            [self.tableView cyl_reloadData];
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
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_tableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_tableView.frame];
    return networkErrorPlaceHolder;
}

-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
    [_tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _index  = 1;
    self.dataDic = [NSMutableDictionary dictionary];
    self.dataArr = [NSMutableArray array];
    [self getdata];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MHRefreshNomalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getdata];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getdata];
    }];
    
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight- kTopHeight -kRealValue(44)-kBottomHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
       
        [_tableView registerClass:[MHCommentDetailCell class] forCellReuseIdentifier:NSStringFromClass([MHCommentDetailCell class])];
        [_tableView registerClass:[MHCommentDetailCellBottomCell class] forCellReuseIdentifier:NSStringFromClass([MHCommentDetailCellBottomCell class])];
        [_tableView registerClass:[MHCommentDetailCellHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHCommentDetailCellHeadCell class])];
        
        //        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  kScreenWidth, 44)];
        //        tableHeaderView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        //        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
        //        _tableView.tableHeaderView = tableHeaderView;
        //    _tableView.bounces = NO;
      
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (self.dataArr.count > 0 ) {
        return self.dataArr.count +1;
    }else{
        return 0;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArr.count > 0 ) {
        return 1;
    }else{
         return 0;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count> 0) {
        if (indexPath.row == 0) {
            return kRealValue(50);
        }else{
            MHProductCommentModel *model = [self.dataArr objectAtIndex:indexPath.row-1];
            CGRect rect = [model.evaluateContent boundingRectWithSize:CGSizeMake(309, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)]} context:nil];
            if (klStringisEmpty(model.evaluateImages)) {
                return rect.size.height+kRealValue(44) +kRealValue(10)+kRealValue(25)+kRealValue(30);
            }else{
                return rect.size.height+kRealValue(44) + kRealValue(57)+kRealValue(17)+kRealValue(25)+kRealValue(30);
            }
            
            
        }
    }
    
    
    
        return kRealValue(185);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
  
        if (indexPath.row == 0) {
            MHCommentDetailCellHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHCommentDetailCellHeadCell class])];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.CellHead.RightitleLabel.text  = [NSString stringWithFormat:@"%@",[self.dataDic valueForKey:@"rate"]];
            cell.CellHead.titleLabel.text =@"好评度";
           
            return cell;
        }
    
        MHCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHCommentDetailCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
    if (self.dataArr.count > 0) {
        MHProductCommentModel *model = [self.dataArr objectAtIndex:indexPath.row-1];
        cell.model = model;
    }
   
        return cell;
   
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    if ( [self.ProCommentViewDelegate respondsToSelector:@selector(showNavAddtitle:)]) {
        [self.ProCommentViewDelegate showNavAddtitle:yOffset];
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
