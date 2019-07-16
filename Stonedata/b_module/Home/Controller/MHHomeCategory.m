//
//  MHHomeCategory.m
//  mohu
//
//  Created by 余浩 on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//
#import "MHHomeCategory.h"
#import "HomeproductCell.h"
#import "MHProductModel.h"
#import "MHbannerCell.h"
#import "MHActivityCell.h"
#import "MHNewerActCell.h"
#import "MHtitleCell.h"
#import "MHGuessActivityCell.h"
#import "MHTimeCell.h"
#import "MHLimitTimer.h"
#import "SGPagingView.h"
#import "MHChildOrderViewController.h"
#import "MHHomeNoticeView.h"
#import "MHHomeDetailViewController.h"
#import "MHPageSectionModel.h"
#import "MHPageItemModel.h"
#import "MHProductDetailViewController.h"
#import "MHLimitbuyListModel.h"
#import "MHgradeshowInfomodel.h"
#import "MHHuGuessViewController.h"
#import "MHProDetailViewController.h"
#import "MHPriceMoreViewController.h"
#import "UIScrollView+MJRefreshEX.h"
#import "MHWebviewViewController.h"
#import "MHNewbeeVC.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"

#import "MHHomefleaShopViewController.h"

#import "MHSignViewController.h"
#import "MHLoginViewController.h"

@interface MHHomeCategory ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate, SGPageContentScrollViewDelegate,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentCollectionView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) UIScrollView *segmentScrollView;
@property (nonatomic, strong) MHHomeNoticeView *showVipView;
@property (nonatomic, copy)   NSString *typeId;
@property (nonatomic, strong) NSMutableArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *limitBuyListArr;
@property (nonatomic, strong) NSMutableArray *gradeArr;
//升级会员信息
@property (nonatomic, assign) int  gradeIndex;
@property (nonatomic, strong) NSMutableArray *limittitleArr;
//限时抢购(正在抢购下标)
@property (nonatomic, assign) int limittimeindex;
@property (nonatomic, assign) NSInteger  index;

#define PADDING 15.0
@end
@implementation MHHomeCategory

- (instancetype)initWithTypeId:(NSString *)typeId
{
    self = [super init];
    if (self) {
       
        _typeId = typeId;
        
    }
    return self;
}
-(void)getLimitdata
{
 
    [[MHUserService sharedInstance]initWithLitmitBuyactivityType:@"FLASH_SALE" completionBlock:^(NSDictionary *response, NSError *error) {
         if (ValidResponseDict(response)) {
             if (self.index == 1) {
                 [self.limitBuyListArr  removeAllObjects];
                 [ self.limittitleArr removeAllObjects];
             }
             self.limitBuyListArr = [MHLimitbuyListModel baseModelWithArr:[response valueForKey:@"data"]];
             if (!klObjectisEmpty(self.limitBuyListArr)) {
                 for (int i = 0; i< self.limitBuyListArr.count; i++) {
                     MHLimitbuyListModel *model = [self.limitBuyListArr objectAtIndex:i];
                      NSString *str = [[NSString alloc]init];
                     if (model.name.length <=4) {
                         
                         str =[NSString stringWithFormat:@"0%@",model.name];
                     }else{
                     str =[NSString stringWithFormat:@"%@",model.name];
                        
                     }
                      [ self.limittitleArr addObject:str ];
                 }
                 if ([ response[@"data"] count] > 0) {
                     [self endRefresh];
                 }else{
                     [self endRefreshNoMoreData];
                 }
                 [self.tableView reloadData];
                 
             }
         }
        if (error) {
            [self endRefresh];
            [self.tableView reloadData];
        }
    } ];;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gradeIndex =0;
    self.view.backgroundColor = kBackGroudColor;
    self.canScroll = YES;
    _index  = 1;
    self.sectionArr = [NSMutableArray array];
    self.limitBuyListArr = [NSMutableArray array];
    self.limittitleArr = [NSMutableArray array];
    [self getNetwork:self.typeId];
    [self getLimitdata];
    [self getgradeList];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.showVipView];
    kWeakSelf(self);
    self.tableView.mj_header = [MHRefreshNomalHeader headerWithRefreshingBlock:^{
        self.index = 1;

        if (weakself.pageContentCollectionView) {
            [weakself.pageContentCollectionView removeAllSubviews];
            weakself.pageContentCollectionView = nil;
        }
        if (weakself.pageTitleView) {
            [weakself.pageTitleView removeAllSubviews];
            weakself.pageTitleView = nil;
        }
        [weakself getNetwork:weakself.typeId];
        [weakself getLimitdata];
    }];
    self.showVipView.hidden = YES;
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(showVip) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptTimeLimtMsg) name:KNotificationFatherSrcoll object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshhome) name:KNotificationRereshHome object:nil];
    // Do any additional setup after loading the view.
}

-(void)refreshhome
{
    MHLog(@"刷新首页");
    [self.pageContentCollectionView removeAllSubviews];
    [self.pageTitleView removeAllSubviews];
    self.pageContentCollectionView = nil;
    self.pageTitleView = nil;
    [self getNetwork:self.typeId];
    [self getLimitdata];
}
-(void)getgradeList
{
    //获取最新会员信息
    self.gradeArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initwithUpgradeCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.gradeArr = [MHgradeshowInfomodel baseModelWithArr:[response valueForKey:@"data"]];
            
        }
    }];
}

-(void)getNetwork:(NSString *)typeId
{
    MHLog(@"%@",typeId);
    
    [[MHUserService sharedInstance] initWithFirstPageComponent:@"0" parentTypeId:@"-1" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.sectionArr  removeAllObjects];
            }
            NSMutableArray *Arr = [NSMutableArray arrayWithArray:[response objectForKey:@"data"]];
            for (int i = 0; i <Arr.count ; i++) {
                MHPageSectionModel *model1 = [[MHPageSectionModel alloc]init];
                model1.type = [[Arr objectAtIndex:i] valueForKey:@"type"];
                model1.visible = [[Arr objectAtIndex:i] valueForKey:@"visible"];
                model1.itemArr =[NSMutableArray arrayWithArray:[MHPageItemModel baseModelWithArr:[[[response objectForKey:@"data"] objectAtIndex:i] valueForKey:@"result"]]]  ;
                [self.sectionArr addObject:model1];
            }
            
            if (Arr.count> 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.tableView reloadData];
      
        }
       
        if (error) {
            [self endRefresh];
            KLToast(@"请检查网络情况");
          [self.tableView reloadData];
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
    [self getNetwork:self.typeId];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
        if (indexPath.section == 1) {
            return kScreenHeight;
        }else{
            if (self.sectionArr.count > 0) {
                MHPageSectionModel *model = self.sectionArr[indexPath.row];
                if ( [model.type isEqualToString:@"SCROLL_PIC"]) {
                    return kRealValue(170);
                }
                if ( [model.type isEqualToString:@"SHOW_MENU"]) {
                    return kRealValue(83);
                }
                if ( [model.type isEqualToString:@"NEW_WELFARE"]) {
                    return kRealValue(82);
                }
                if ( [model.type isEqualToString:@"MH_WELFARE"]) {
                    return kRealValue(115);
                }
            }
            return kRealValue(0);
            
        }

    return kScreenHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        if (self.sectionArr.count > 0) {
            return self.sectionArr.count ;
        }
    }else{
        if (self.limittitleArr.count > 0) {
            return 1;
        }
        return 0;
    }
    
    return 0 ;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (void)acceptTimeLimtMsg{
    self.canScroll = YES;
    [self changeChildCanScroll:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //当前偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    
    
    CGFloat bottomCellOffset =  [self.tableView rectForSection:1].origin.y ;
    if (yOffset >= bottomCellOffset ) {
        
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            [self changeChildCanScroll:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationChildSrcoll object:nil userInfo:nil];
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
}


-(void)changeChildCanScroll:(BOOL)canScroll{
    for (MHLimitTimer *VC in _pageContentCollectionView.childViewControllers) {
        VC.vcCanScroll = canScroll;
        if (!canScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            VC.tableView.contentOffset = CGPointZero;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    kWeakSelf(self);
    if (indexPath.section == 1) {
        
        if (self.limitBuyListArr.count > 0) {
        MHTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHTimeCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_pageContentCollectionView == nil) {
////
//            NSArray *titleArr =[ NSArray arrayWithObjects:@"09:00",@"12:00",@"15:00",@"18:00",@"21:00", nil];
            SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
            configure.indicatorStyle = SGIndicatorStyleDynamic;
            configure.titleAdditionalWidth = 40;
            configure.showBottomSeparator = NO;
            configure.indicatorDynamicWidth = 50;
            configure.indicatorToBottomDistance = -10;
            configure.indicatorCornerRadius = 2.5;
            configure.titleColor = [UIColor colorWithHexString:@"000000"];
            configure.titleSelectedColor = [UIColor colorWithHexString:@"FF5100"];
            configure.indicatorColor = [UIColor colorWithHexString:@"FF5100"];
            configure.indicatorHeight = 1.5;
            configure.titleFont = [UIFont fontWithName:kPingFangMedium size:18];

            
            self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) delegate:self  titleNames:self.limittitleArr configure:configure];
            for (int i=0; i< self.limittitleArr.count; i++) {
                 MHLimitbuyListModel *model = [self.limitBuyListArr objectAtIndex:i];
                    NSString *string = [self.limittitleArr objectAtIndex:i];
                if ([model.loading isEqualToString:@"DELETED"]) {
                    string = [NSString stringWithFormat:@"%@\n 已结束",string];
                }
                if ([model.loading isEqualToString:@"PENDING"]) {
                    string = [NSString stringWithFormat:@"%@\n 即将开始",string];
                }
                if ([model.loading isEqualToString:@"ACTIVE"]) {
                    string = [NSString stringWithFormat:@"%@\n 正在抢购",string];
                    self.limittimeindex = i;
                }
            
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
                NSDictionary *normalDict = @{
                                             NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:10],
                                             };
                NSDictionary *normalDict1 = @{
                                                NSForegroundColorAttributeName:  [UIColor colorWithHexString:@"666666"]
                                                };
                
                NSRange normalRange = NSMakeRange(5, attributedString.length-5);
          
//                NSRange normalRange1 = NSMakeRange(0, attributedString.length);
                [attributedString addAttributes:normalDict range:normalRange];
                 [attributedString addAttributes:normalDict1 range:normalRange];
                
                NSMutableAttributedString *selectedAttributedString = [[NSMutableAttributedString alloc] initWithString:string];
                NSDictionary *selectedDict = @{
                                                NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:10]
                                               
                                               };
                NSDictionary *selectedDict1 = @{
                                                NSForegroundColorAttributeName:  [UIColor colorWithHexString:@"FF5100"]
                                                };
                NSRange selectedRange = NSMakeRange(5, selectedAttributedString.length-5);
                NSRange selectedRange1 = NSMakeRange(0, attributedString.length);
                [selectedAttributedString addAttributes:selectedDict range:selectedRange];
                [selectedAttributedString addAttributes:selectedDict1 range:selectedRange1];
                
                [self.pageTitleView setAttributedTitle:attributedString selectedAttributedTitle:selectedAttributedString forIndex:i];
            }
            NSMutableArray *childArr = [NSMutableArray array];
            for (int i =0 ; i < self.limitBuyListArr.count; i++) {
                
                MHLimitbuyListModel *model = [self.limitBuyListArr objectAtIndex:i];
                 MHLimitTimer *oneVC = [[MHLimitTimer alloc] initWithTypeId:model];
                [childArr addObject:oneVC ];
            }
   
            CGFloat ContentCollectionViewHeight = kScreenHeight-kTopHeight-kTabBarHeight-44;
            self.pageContentCollectionView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
            [cell addSubview:self.pageTitleView ];
            [cell addSubview:self.pageContentCollectionView];
            [self.pageTitleView setSelectedIndex:self.limittimeindex];
            _pageContentCollectionView.delegatePageContentScrollView = self;
            [_pageContentCollectionView setPageContentScrollViewCurrentIndex:self.limittimeindex];
        }
        return cell;
            
        }
        return nil;
    }else{
        MHPageSectionModel *model;
        if (self.sectionArr.count > 0) {
          model  = self.sectionArr[indexPath.row];
        }
        
        if ([model.type isEqualToString:@"SCROLL_PIC"]) {
            MHbannerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHbannerCell class])];
            cell.changepage = ^(NSString *code, NSString *parm) {
                if ([code isEqualToString:@"0"]) {
                    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:parm comefrom:@"firstpage"];
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
                if ([code isEqualToString:@"5"]) {
                    //产品详情
                    MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
                    vc.productId = parm;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                if ([code isEqualToString:@"7"]) {
                    //奖多多
                    MHPriceMoreViewController *vc = [[MHPriceMoreViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                if ([code isEqualToString:@"8"]) {
                    //胡猜
                    MHHuGuessViewController *vc = [[MHHuGuessViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            };
            cell.comeform = @"firstpage";
            cell.bannerArr = model.itemArr;
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if ([model.type isEqualToString:@"SHOW_MENU"]) {
            MHActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHActivityCell class])];
            cell.ActivityArr = model.itemArr;
           
            cell.block = ^(NSInteger type) {
                if (type  ==  20005) {
                    if ([GVUserDefaults standardUserDefaults].accessToken) {
                        MHSignViewController *vc = [[MHSignViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        MHLoginViewController *login = [[MHLoginViewController alloc] init];
                        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
                        [self presentViewController:userNav animated:YES completion:nil];
                    }

                }else{
                    NSArray *colorArr = @[@"#f05a7a",@"#ffa022",@"#ff897f ",@"#e666d5",@"#35aafa"];
                    MHPageItemModel *pageModel = model.itemArr[type -20001];
                    MHHomeDetailViewController *vc = [[MHHomeDetailViewController alloc] initWithId:[NSString stringWithFormat:@"%@", pageModel.actionUrl]];
                    vc.nameTitle  = pageModel.name;
                    vc.colorStr = colorArr[type -20001];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            return cell;
        }
        if ([model.type isEqualToString:@"NEW_WELFARE"]) {
            MHNewerActCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHNewerActCell class])];
            cell.NewActArr = model.itemArr;
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            cell.changepage = ^(NSString *code, NSString *parm) {
                MHNewbeeVC *vc = [[MHNewbeeVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
               
            };
            
            return cell;
        }
        
        if ([model.type isEqualToString:@"MH_WELFARE"]) {
            MHGuessActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHGuessActivityCell class])];
            cell.tapactblock = ^(NSInteger index) {
                
                MHPageItemModel *pageModel = model.itemArr[index];
           
                if ([[NSString stringWithFormat:@"%ld",pageModel.actionUrlType] isEqualToString:@"0"] ) {
                    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:pageModel.actionUrl comefrom:@"firstpage"];
                    [weakself.navigationController pushViewController:vc animated:YES];
                   
                }
                if ([[NSString stringWithFormat:@"%ld",pageModel.actionUrlType] isEqualToString:@"1"] ) {
                    NSData *jsonData = [pageModel.actionUrl dataUsingEncoding:NSUTF8StringEncoding];
                    NSError *err;
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
                    if (err) {
                        NSLog(@"json解析失败：%@",err);
                    }else{
                        if ([[NSString stringWithFormat:@"%@",[dic valueForKey:@"code"]] isEqualToString:@"5"]) {
                            //产品详情
                            MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
                            vc.productId = [dic valueForKey:@"parm"];
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                        if ([[NSString stringWithFormat:@"%@",[dic valueForKey:@"code"]] isEqualToString:@"7"]) {
                            //奖多多
                            MHPriceMoreViewController *vc = [[MHPriceMoreViewController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                           
                        }
                        if ([[NSString stringWithFormat:@"%@",[dic valueForKey:@"code"]] isEqualToString:@"8"]) {
                            //胡猜
                            MHHuGuessViewController *vc = [[MHHuGuessViewController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }
                        if ([[NSString stringWithFormat:@"%@",[dic valueForKey:@"code"]] isEqualToString:@"9"]) {
                            MHHomefleaShopViewController *vc = [[MHHomefleaShopViewController alloc]init];
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                        
                        
                    }
                    
                    
                }
                
                
                if (pageModel.actionUrlType == 7) {
                    MHPriceMoreViewController *vc = [[MHPriceMoreViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
               if (pageModel.actionUrlType == 8) {
                    MHHuGuessViewController *vc = [[MHHuGuessViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
               
            };
            cell.MHfuliArr = model.itemArr;
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            //        cell.backgroundColor =kRandomColor;
            return cell;
        }
    }
    MHGuessActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHGuessActivityCell class])];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
}

-(void)showVip
{
    //可以写网路请求
    if (self.gradeArr.count < 1) {
        return;
    }
    if (self.gradeIndex >= self.gradeArr.count) {
        self.gradeIndex = 0;
    }
  
    if (self.showVipView.hidden == YES) {
        
        self.showVipView.hidden = NO;
        self.showVipView.alpha = 0;
        MHgradeshowInfomodel *model= self.gradeArr[ self.gradeIndex];
        [self.showVipView.headImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:kGetImage(@"user_pic")];
        self.showVipView.width = [model.msg widthForFont:[UIFont fontWithName:kPingFangRegular size:11]] + kRealValue(25);
        self.showVipView.noticelabel.text = model.msg;;
         self.gradeIndex++;
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.showVipView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.showVipView.alpha = 0;
            } completion:^(BOOL finished) {
                self.showVipView.hidden = YES;
            }];
        }];
    }
}


#pragma mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[MHBaseTableView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight-kTabBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        //        _tableView.backgroundColor = [UIColor redColor];
        [_tableView registerClass:[HomeproductCell class] forCellReuseIdentifier:NSStringFromClass([HomeproductCell class])];
        [_tableView registerClass:[MHTimeCell class] forCellReuseIdentifier:NSStringFromClass([MHTimeCell class])];
        [_tableView registerClass:[MHbannerCell class] forCellReuseIdentifier:NSStringFromClass([MHbannerCell class])];
        [_tableView registerClass:[MHActivityCell class] forCellReuseIdentifier:NSStringFromClass([MHActivityCell class])];
        [_tableView registerClass:[MHNewerActCell class] forCellReuseIdentifier:NSStringFromClass([MHNewerActCell class])];
        [_tableView registerClass:[MHtitleCell class] forCellReuseIdentifier:NSStringFromClass([MHtitleCell class])];
        [_tableView registerClass:[MHGuessActivityCell class] forCellReuseIdentifier:NSStringFromClass([MHGuessActivityCell class])];
        //        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  kScreenWidth, 44)];
        //        tableHeaderView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        //        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
        //        _tableView.tableHeaderView = tableHeaderView;
        //    _tableView.bounces = NO;
        
        
    }
    return _tableView;
}
-(MHHomeNoticeView *)showVipView
{

    if (!_showVipView) {
        _showVipView = [[MHHomeNoticeView alloc]initWithFrame:CGRectMake(kRealValue(11), kRealValue(20), kRealValue(197), kRealValue(22)) title:@"212" imageStr:@""];
            
        }
   
       return _showVipView;
    }


#pragma mark 代理
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (NSString*)CharacterStringMainString:(NSString*)MainString AddDigit:(int)AddDigit AddString:(NSString*)AddString

{
    
    NSString*ret = [[NSString alloc]init];
    
    ret = MainString;
    
    for(int y =0;y < (AddDigit - MainString.length) ;y++ ){
        
        ret = [NSString stringWithFormat:@"%@%@",ret,AddString];
        
    }
    return ret;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
