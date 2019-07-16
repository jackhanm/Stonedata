//
//  MHHomefleaOneStepSaleViewController.m
//  mohu
//
//  Created by yuhao on 2019/1/8.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHHomefleaOneStepSaleViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "MHHomefleaOneStepCell.h"
#import "MHflealistModel.h"
#import "MHShopCarCountView.h"
@interface MHHomefleaOneStepSaleViewController ()<UITableViewDataSource,UITableViewDelegate, CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign)NSInteger  index;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong)MHflealistModel *dicmodel;
@property (nonatomic, strong)MHHomefleaOneStepCell *Cell;

@end

@implementation MHHomefleaOneStepSaleViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.index = 1;
   
//    [self getdata];
}
- (instancetype)initWithmodel:(MHflealistModel *)model
{
    self = [super init];
    if (self) {
        self.fleamodel = model;
        self.listArr = [NSMutableArray array];
        [self.listArr addObject:model];
        
    }
    return self;
}


-(void)getdata
{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xF2F3F2);
    self.title = @"一键转卖";
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)OnestepSale
{
    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"你确定转卖该商品吗？" ];
    alertVC.messageAlignment = NSTextAlignmentCenter;
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
        [alertVC showDisappearAnimation];
        
    }];
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确定" handler:^(CKAlertAction *action) {
        [alertVC showDisappearAnimation];
        [[MHUserService sharedInstance]initWithRecoredByIdWithrecoverId:self.fleamodel.recoverId productCount:self.Cell.shopcartCountView.editTextField.text completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                KLToast(@"转卖成功");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                 KLToast(@"转卖失败");
            }
            if (error) {
                KLToast(response[@"message"]);
            }
            
        }];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:NO completion:nil];
   
}
-(void)createview
{
    [self.view addSubview:self.contentTableView];
    
    UIView *bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - kRealValue(50) - kTopHeight-kBottomHeight, kScreenWidth, kRealValue(50)+kBottomHeight)];
    bottomview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomview];
    
    UIButton *bottombtn = [UIButton buttonWithType: UIButtonTypeCustom];
    bottombtn.frame = CGRectMake(kRealValue(24), kRealValue(7), kRealValue(325), kRealValue(32));
    bottombtn.backgroundColor = KColorFromRGB(0xe51c23);
    [bottombtn setTitle:@"一键转卖" forState:UIControlStateNormal];
    bottombtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    bottombtn.layer.cornerRadius = 3;
    [bottombtn addTarget:self action:@selector(OnestepSale) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:bottombtn];
    
    
    
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


-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = KColorFromRGB(0xF2F3F2);
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        [_contentTableView registerClass:[MHHomefleaOneStepCell class] forCellReuseIdentifier:NSStringFromClass([MHHomefleaOneStepCell class])];
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
    return kRealValue(180);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.Cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHomefleaOneStepCell class])];
    if (self.listArr.count > 0) {
        [self.Cell createviewWithModel:[self.listArr objectAtIndex:0]];
        
    }
    self.Cell.backgroundColor = KColorFromRGB(0xF2F3F2);
    self.Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.Cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
