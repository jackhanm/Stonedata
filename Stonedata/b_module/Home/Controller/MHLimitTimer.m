
//
//  MHLimitTimer.m
//  mohu
//
//  Created by 余浩 on 2018/9/13.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHLimitTimer.h"
#import "HomeproductCell.h"
#import "MHProductModel.h"
#import "MHProductDetailViewController.h"
#import "MHProDetailViewController.h"
#import "MHLimitbuyListModel.h"

@interface MHLimitTimer ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) MHLimitbuyListModel *model;
@property (nonatomic, assign) NSInteger  index;
@end

@implementation MHLimitTimer

- (instancetype)initWithTypeId:(MHLimitbuyListModel *)model
{
    self = [super init];
    if (self) {
        
        self.model = model;

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     _index = 1;
     [self getData];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 1;
    _modelArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
   
}


- (void)getData{
    
    [[MHUserService sharedInstance] initWithLitmitBuyactivityId:[NSString stringWithFormat:@"%@",self.model.id] beginTime:[NSString stringWithFormat:@"%@",self.model.beginTime] endTime:[NSString stringWithFormat:@"%@",self.model.endTime] pageSize:10 pageIndex:_index completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.modelArray removeAllObjects];
            }
            [self.modelArray addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"][@"list"]]];
        }
        [self.tableView reloadData];
        if ([ response[@"data"][@"list"] count] > 0) {
            [self endRefresh];
        }else{
            [self endRefreshNoMoreData];
        }
    }];
}


-(void)endRefresh{
    [_tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return kRealValue(280);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.modelArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeproductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeproductCell class])];
    if (cell == nil) {
        cell = [[HomeproductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeproductCell class])];
    }
    if (self.modelArray.count > 0) {
        cell.ProductModel = self.modelArray[indexPath.row];
        MHProductModel *ProductModel =self.modelArray[indexPath.row];
        if ([ProductModel.status isEqualToString:@"DELETED"]) {
            //已结束
            [cell.Buybtn setTitle:@"已结束" forState:UIControlStateNormal];
            [cell.Buybtn setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
            cell.Buybtn.backgroundColor = KColorFromRGB(0xe0e0e0);
            
        }
        if ([ProductModel.status isEqualToString:@"PENDING"]) {
            //未开始
            cell.Buybtn.backgroundColor = KColorFromRGB(0xEB2109);
            [cell.Buybtn setTitle:@"即将开始" forState:UIControlStateNormal];
            
        }
        if ([ProductModel.status isEqualToString:@"ACTIVE"]) {
            //进行中
            cell.Buybtn.backgroundColor = KColorFromRGB(0xEB2109);
            [cell.Buybtn setTitle:@"正在抢购" forState:UIControlStateNormal];
        }
        
    }
     cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHProDetailViewController *vc =[[MHProDetailViewController alloc]init];
    MHProductModel *ProductModel =self.modelArray[indexPath.row];
    if ([ProductModel.status isEqualToString:@"DELETED"]) {
        //已结束
        vc.beginTime = [NSString stringWithFormat:@"%@",self.model.beginTime];
        vc.endTime =[NSString stringWithFormat:@"%@",self.model.endTime];
        vc.comeform = @"hasclose";
        vc.activityId = [NSString stringWithFormat:@"%@",self.model.id];
        
    }
    if ([ProductModel.status isEqualToString:@"PENDING"]) {
        //未开始
        vc.beginTime = [NSString stringWithFormat:@"%@",self.model.beginTime];
        vc.endTime =[NSString stringWithFormat:@"%@",self.model.endTime];
        vc.comeform = @"willopen";
        vc.activityId = [NSString stringWithFormat:@"%@",self.model.id];
        
    }
    if ([ProductModel.status isEqualToString:@"ACTIVE"]) {
        //进行中
        vc.comeform = @"limettime";
        vc.beginTime = [NSString stringWithFormat:@"%@",self.model.beginTime];
        vc.endTime =[NSString stringWithFormat:@"%@",self.model.endTime];
        vc.activityId = [NSString stringWithFormat:@"%@",self.model.id];
        
    }
    
    vc.productId= [self.modelArray[indexPath.row] productId];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight-44)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
         _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.index ++;
            [self getData];
        }];
        [_tableView registerClass:[HomeproductCell class] forCellReuseIdentifier:NSStringFromClass([HomeproductCell class])];
    }
    return _tableView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <=0) {
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationFatherSrcoll object:nil userInfo:nil];
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
