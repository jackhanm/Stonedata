//
//  MHMineUserCollectionViewController.m
//  mohu
//
//  Created by yuhao on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserCollectionViewController.h"
#import "HomeproductCell.h"
#import "MHProductModel.h"
#import "MHProDetailViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"


@interface MHMineUserCollectionViewController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@end

@implementation MHMineUserCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kRealValue(10), kRealValue(80), kRealValue(30));
    btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
    [btn setTitle:@"清空过期商品" forState:UIControlStateNormal];
    [btn setTitleColor:KColorFromRGB(0x666666) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightItem];
    self.view.backgroundColor = KColorFromRGB(0xf1f2f5);
    [self createview];
    [self getnetwork];
    // Do any additional setup after loading the view.
}
-(void)clear
{
    [[MHBaseClass sharedInstance] presentAlertWithtitle:@"清除失效产品" message:@"确定清除失效产品" leftbutton:@"取消" rightbutton:@"确定" leftAct:^{
        
    } rightAct:^{
        NSString *str= @"";
        NSMutableArray *noActiveArr = [NSMutableArray array];
        for (int i = 0; i < self.listArr.count; i++) {
            MHProductModel *productModel = [self.listArr objectAtIndex:i];
            if (![productModel.status isEqualToString:@"ACTIVE"] ) {
                [noActiveArr addObject:productModel];
            }
        }
        for (int i = 0; i < noActiveArr.count; i++) {
            MHProductModel *productModel = [noActiveArr objectAtIndex:i];
            if (i== 0) {
                str = [NSString stringWithFormat:@"%@%@",str,productModel.productId];
            }else{
                str = [NSString stringWithFormat:@"%@,%@",str,productModel.productId];
            }
        }
        if (klStringisEmpty(str)) {
            KLToast(@"暂无过期商品");
            return;
        }
        [[MHUserService sharedInstance]initWithDeleteCollects:str completionBlock:^(NSDictionary *response, NSError *error) {
            
            if (ValidResponseDict(response)) {
                KLToast(@"清除成功");
                [self getnetwork];
            }
            
            
        }];
    }];
    
    
    
}
-(void)getnetwork
{
    self.listArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initWithCollectListCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.listArr = [MHProductModel baseModelWithArr:response[@"data"][@"list"]] ;
            [self.contentTableView cyl_reloadData];
        }
        if (error) {
            [self.contentTableView cyl_reloadData];
        }
       
    }];
}
-(void)createview
{
    [self.view addSubview:self.contentTableView];
}

-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
//        [_contentTableView registerClass:[HomeproductCell class] forCellReuseIdentifier:NSStringFromClass([HomeproductCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(280);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        HomeproductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
//        cell.backgroundColor = kRandomColor;
    if (!cell) {
        cell = [[HomeproductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        
        
    }
    cell.tag = indexPath.row;
    kWeakSelf(self);
    cell.CancelAct = ^(NSInteger index) {
        [[MHUserService sharedInstance]initWithDeleteCollects:[NSString stringWithFormat:@"%@",[weakself.listArr[index] productId]]  completionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        KLToast(@"取消收藏成功");
                        [weakself getnetwork];
                    }
                }];
    };
    if (self.listArr.count > 0) {
        cell.isCollect = YES;
        cell.ProductModel = self.listArr[indexPath.row];
        
    }
    
    
        return cell;
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}


-(void)cancelAction:(UITapGestureRecognizer *)sender{
    MHLog(@"点击%ld",sender.view.tag);
    [[MHUserService sharedInstance]initWithDeleteCollects:[NSString stringWithFormat:@"%@",[self.listArr[sender.view.tag-17000] productId]]  completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            KLToast(@"取消收藏成功");
            [self getnetwork];
        }
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
    vc.productId =[self.listArr[indexPath.row] productId];
    vc.productdetailTYpe = 0;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
