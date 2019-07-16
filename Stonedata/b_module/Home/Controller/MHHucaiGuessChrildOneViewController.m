//
//  MHHucaiGuessChrildOneViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHucaiGuessChrildOneViewController.h"
#import "MHHuGuessOrderMyCell.h"
#import "MHGuessOrderdetailViewController.h"
#import "MHGuessMyPrizeViewController.h"
#import "MHStartprizeModelOrdersinger.h"
#import "MHGuessOrderdetailViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
#import "MHHomefleaShopViewController.h"
@interface MHHucaiGuessChrildOneViewController ()<UITableViewDataSource,UITableViewDelegate, CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) NSInteger  index;
@end

@implementation MHHucaiGuessChrildOneViewController

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
   
    [[MHUserService sharedInstance]initwithStartPrizewithdrawAllType:@"1" pageSize:@"10" pageIndex:[NSString stringWithFormat:@"%ld",_index] morecompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr  removeAllObjects];
            }
            [self.listArr addObjectsFromArray:[MHStartprizeModelOrdersinger baseModelWithArr:[response valueForKey:@"data"]]];
           
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
        [_contentTableView registerClass:[MHHuGuessOrderMyCell class] forCellReuseIdentifier:NSStringFromClass([MHHuGuessOrderMyCell class])];
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
    
    MHHuGuessOrderMyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHuGuessOrderMyCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.TakeNow = ^(NSInteger type) {
        MHHomefleaShopViewController *vc = [[MHHomefleaShopViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.PriceMoregotodetal = ^{
        if (self.listArr.count > 0) {
            MHStartprizeModelOrdersinger *singer = [self.listArr objectAtIndex:indexPath.row];
            if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"1"]) {
                
            }
            if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"2"]) {
                
            }
            if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"3"]) {
                
                MHGuessMyPrizeViewController *vc= [[MHGuessMyPrizeViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"4"]) {
                if ([[NSString stringWithFormat:@"%@",singer.expressStatus] isEqualToString:@"0"]) {
                    MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"10"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                if ([[NSString stringWithFormat:@"%@",singer.expressStatus] isEqualToString:@"1"]) {
                    MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"4"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                
            }
            if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"5"]) {
                MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"5"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"6"]) {
                MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"6"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"7"]) {
//                MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"7"];
//                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
            
        }
        
        
    };
    cell.backgroundColor =KColorFromRGB(0xEDEFF0);
    if (self.listArr.count > 0) {
        MHStartprizeModelOrdersinger *singer = [self.listArr objectAtIndex:indexPath.row];
        NSString *str  = [NSString stringWithFormat:@"%@",singer.drawOrderCode];
        if (!klStringisEmpty(str) ) {
            cell.orderNum.text = [NSString stringWithFormat:@"订单编号%@",singer.drawOrderCode];
        }else{
            cell.orderNum.text = @"";
        }
        [cell.productImage sd_setImageWithURL:[NSURL URLWithString:singer.productSmallImage] placeholderImage:kGetImage(kfailImage)];
        cell.productname.text =[NSString stringWithFormat:@"%@",singer.productName];
        cell.productPrice.text =[NSString stringWithFormat:@"¥%@",singer.productPrice];
        cell.ordertimer.text =[NSString stringWithFormat:@"%@",singer.winnerTime];
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"1"]) {
            cell.orderStatus.text =@"待开奖";
            cell.orderStatus.textColor = KColorFromRGB(0x666666);
            cell.takebtn.hidden =YES;
            cell.NowBuy.hidden =YES;
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"2"]) {
            cell.orderStatus.text =@"未中奖";
            cell.orderStatus.textColor = KColorFromRGB(0x666666);
            cell.takebtn.hidden =YES;
            cell.NowBuy.hidden =YES;
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"3"]) {
            cell.orderStatus.text =@"未领取";
            cell.orderStatus.textColor = KColorFromRGB(0x666666);
            [cell.NowBuy setTitle:@"立即领取" forState:UIControlStateNormal];
            cell.takebtn.hidden =NO;
            cell.NowBuy.hidden =NO;
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"4"]) {
            if ([[NSString stringWithFormat:@"%@",singer.expressStatus] isEqualToString:@"0"]) {
                cell.orderStatus.text =@"待发货";
                cell.orderStatus.textColor = KColorFromRGB(0xd71313);
                cell.NowBuy.hidden =NO;
                cell.takebtn.hidden =YES;
                [cell.NowBuy setTitle:@"待发货" forState:UIControlStateNormal];
             [cell changeview];
            }
            if ([[NSString stringWithFormat:@"%@",singer.expressStatus] isEqualToString:@"1"]) {
                cell.orderStatus.text =@"确认收货";
                [cell.NowBuy setTitle:@"确认收货" forState:UIControlStateNormal];
                cell.NowBuy.hidden =NO;
                cell.takebtn.hidden =YES;
                [cell changeview];
            }
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"5"]) {
            cell.orderStatus.text =@"已完成";
            cell.orderStatus.textColor = KColorFromRGB(0xd71313);
            cell.takebtn.hidden =YES;
            cell.NowBuy.hidden =YES;
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"6"]) {
            cell.orderStatus.text =@"已失效";
            cell.orderStatus.textColor = KColorFromRGB(0x999999);
            cell.takebtn.hidden =YES;
            cell.NowBuy.hidden =YES;
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"7"]) {
            cell.orderStatus.text  =@"已转卖";
            cell.orderStatus.textColor = KColorFromRGB(0x666666);
            cell.takebtn.hidden =YES;
            cell.NowBuy.hidden =YES;
        }
        
        
        
    }
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
    if (self.listArr.count > 0) {
        MHStartprizeModelOrdersinger *singer = [self.listArr objectAtIndex:indexPath.row];
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"1"]) {
            
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"2"]) {
            
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"3"]) {
            
            MHGuessMyPrizeViewController *vc= [[MHGuessMyPrizeViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"4"]) {
            if ([[NSString stringWithFormat:@"%@",singer.expressStatus] isEqualToString:@"0"]) {
                MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"10"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([[NSString stringWithFormat:@"%@",singer.expressStatus] isEqualToString:@"1"]) {
                MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"4"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
           
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"5"]) {
            MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"5"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"6"]) {
            MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"6"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([[NSString stringWithFormat:@"%@",singer.status] isEqualToString:@"7"]) {
//            MHGuessOrderdetailViewController *vc = [[MHGuessOrderdetailViewController alloc]initWithwinningId:[NSString stringWithFormat:@"%@",singer.winningId] comefrom:@"hucai" statu:@"7"];
//            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        
    }
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
