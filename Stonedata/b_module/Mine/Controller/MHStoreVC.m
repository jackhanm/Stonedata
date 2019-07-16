//
//  MHStoreVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHStoreVC.h"
#import "MHshopkeeperInfo.h"
#import "NSString+Attribute.h"
#import "MHHomeDescTableViewCell.h"
#import "MHProductModel.h"
#import "MHStoreCell.h"
#import "MHProDetailViewController.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"

@interface MHStoreVC ()<UITableViewDataSource,UITableViewDelegate>{
    UILabel            *_titleLabel;
    UIImageView         *_headImageView;
}

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIView        *naviView;//自定义导航栏
@property (nonatomic, strong) NSMutableArray       *listArr;
@property (nonatomic, strong) NSDictionary  *descDict;
@property(nonatomic, strong)  UIImageView *headimageview;
@property(nonatomic, strong)  UIImageView *headerView;
@property(nonatomic, strong)  UIButton    *editBtn;
@property(nonatomic, strong)  UIButton    *addBtn;
@property(nonatomic, strong)  UILabel *username;
@property(nonatomic, strong)  UILabel *userNumber;
@property(nonatomic, strong)  UILabel *descLabel;


@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, copy) NSString *activityId;
@end

@implementation MHStoreVC




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[MHUserService sharedInstance]initwithStoreInfo:self.shopId completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.descDict = response[@"data"];
            self.username.text = self.descDict[@"shopName"];
            self.userNumber.text = [NSString stringWithFormat:@"店铺ID：%@",self.descDict[@"shopCode"]];
            if (ValidStr(self.descDict[@"shopDesc"])) {
                self.descLabel.text = [NSString stringWithFormat:@"简介：%@",self.descDict[@"shopDesc"]];
            }else{
                self.descLabel.text = @"简介：店主很懒，什么都没留下~~";
            }
            [self.headerView sd_setImageWithURL:[NSURL URLWithString:self.descDict[@"shopImage"]] placeholderImage:kGetImage(@"user_pic")];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = kBackGroudColor;
    _index = 1;
    _listArr = [NSMutableArray array];
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.naviView];
    [self getData];
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getData];
    }];
    

}


- (void)getData{
    
    [[MHUserService sharedInstance]initwithStoreHome:self.shopId pageIndex:self.index pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {

            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            
            [self.listArr  addObjectsFromArray:[MHProductModel baseModelWithArr:response[@"data"][@"list"]]];
            [self.contentTableView  cyl_reloadData];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
    }];
}


-(void)endRefresh{
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
}



-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, kRealValue(217),kScreenWidth, kScreenHeight - kRealValue(217));
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        [_contentTableView registerClass:[MHStoreCell class] forCellReuseIdentifier:NSStringFromClass([MHStoreCell class])];
        _contentTableView.showsVerticalScrollIndicator = NO;
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(217))];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.image = kGetImage(@"store_bg");
        
        _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(20), kRealValue(32), kRealValue(55), kRealValue(55))];
        ViewBorderRadius(_headerView, kRealValue(5), 1, [UIColor whiteColor]);
        _headerView.layer.masksToBounds = YES;
        _headerView.layer.cornerRadius = kRealValue(27.5);
        [_headImageView addSubview:_headerView];
        _headerView.centerY = _headImageView.centerY;
        
        
        _username = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(86), kRealValue(0), kScreenWidth/2, kRealValue(20))];
        _username.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _username.textColor = [UIColor whiteColor];
        _username.textAlignment = NSTextAlignmentLeft;
        [_headImageView addSubview:_username];
        _username.centerY = _headImageView.centerY - kRealValue(10);
        
        
        _userNumber = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(86), 0, kScreenWidth/2, kRealValue(20))];
        _userNumber.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _userNumber.textColor = [UIColor whiteColor];
        _userNumber.textAlignment = NSTextAlignmentLeft;
        [_headImageView addSubview:_userNumber];
        _userNumber.centerY = _headImageView.centerY + kRealValue(10);
        
        
        UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), _headerView.bottom + kRealValue(16), kScreenWidth - kRealValue(20), kRealValue(44))];
        centerView.backgroundColor = [UIColor colorWithHexString:@"f7395a"];
        [_headImageView addSubview:centerView];
        centerView.layer.masksToBounds = YES;
        centerView.layer.cornerRadius = 4;
        
        _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(20), kRealValue(44))];
        _descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _descLabel.textColor = [UIColor colorWithHexString:@"fcbec2"];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        [centerView addSubview:_descLabel];
        
        
        _editBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(60),0, kRealValue(60), kRealValue(20))];
        _editBtn.userInteractionEnabled = YES;
        [_editBtn addTarget:self action:@selector(changeDesc) forControlEvents:UIControlEventTouchUpInside];
        [_editBtn setBackgroundImage:[UIImage imageNamed:@"store_edit"] forState:UIControlStateNormal];
        [_headImageView addSubview:_editBtn];
        _editBtn.centerY = _username.centerY ;
        [self.view addSubview:_headImageView];
        //_contentTableView.tableHeaderView = _headImageView;
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


- (void)changeDesc{
    MHshopkeeperInfo *vc = [[MHshopkeeperInfo alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(278);
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MHStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHStoreCell class])];
    cell.backgroundColor = [UIColor clearColor];
    cell.ProductModel = self.listArr[indexPath.row];
    cell.downClick = ^{
        self.index = 1;
        [self getData];
    };
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}


- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kTopHeight)];
        _naviView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];//该透明色设置不会影响子视图
        //添加返回按钮
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:[UIImage imageNamed:@"left_back"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(5, 25 + kTopHeight - 64, 33, 33);
        backButton.adjustsImageWhenHighlighted = NO;
        [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:backButton];
        
        _titleLabel= [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:kPingFangMedium size:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        _titleLabel.text = @"我的店铺";
        _titleLabel.frame = CGRectMake(5, 25 + kTopHeight - 64, kScreenWidth/1.5, 25);
        _titleLabel.centerX = _naviView.centerX;
        _titleLabel.centerY = backButton.centerY;
        [_naviView addSubview:_titleLabel];
        
        
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(85),0, kRealValue(80), 25)];
        _addBtn.userInteractionEnabled = YES;
        _addBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:14];
        [_addBtn setTitle:@"添加商品" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addChange) forControlEvents:UIControlEventTouchUpInside];
        [_naviView addSubview:_addBtn];
        _addBtn.centerY = _titleLabel.centerY;
        
    }
    return _naviView;
}


-(void)addChange{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    if (scrollView == _contentTableView) {
//        //当前偏移量
//        CGFloat yOffset  = scrollView.contentOffset.y;
//        MHLog(@"%f",yOffset);
//        
//        //更改导航栏的背景图的透明度
//        CGFloat alpha = 0;
//        if (yOffset<=0) {
//            alpha = 0;
//        } else if(yOffset < (kTopHeight+50)){
//            alpha = yOffset/(kTopHeight+50);
//        }else if(yOffset >= (kTopHeight+50)){
//            alpha = 1;
//        }else{
//            alpha = 0;
//        }
//        if (alpha == 0) {
//             _titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
//            [_addBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
//        }else{
//            _titleLabel.textColor = [UIColor colorWithHexString:@"000000"andAlpha:alpha];
//            [_addBtn setTitleColor:[UIColor colorWithHexString:@"000000"andAlpha:alpha] forState:UIControlStateNormal];
//        }
//        self.naviView.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:alpha];
//    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MHProductModel *model = _listArr[indexPath.row];
    MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
    vc.productId = model.productId;
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
