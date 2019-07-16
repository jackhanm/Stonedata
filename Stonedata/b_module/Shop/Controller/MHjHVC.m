//
//  MHjHVC.m
//  mohu
//
//  Created by AllenQin on 2019/1/10.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHjHVC.h"
#import "MHJFModel.h"
#import "MHJHCell.h"

@interface MHjHVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray       *taskArr;
@property (nonatomic, assign) NSInteger  index;

@end

@implementation MHjHVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.title = @"粉丝激活";
    _index = 1;
    _taskArr = [NSMutableArray array];
    [self.view addSubview:self.contentTableView];
    [self getData];

    
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



-(void)getData{
    
    //获取列表
    [[MHUserService sharedInstance]initwithJihuoListPageIndex:self.index pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.taskArr removeAllObjects];
            }
            [self.taskArr addObjectsFromArray:[MHJFModel baseModelWithArr:response[@"data"]]];
           
            if ([ response[@"data"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
            [self.contentTableView reloadData];
        }
    }];
}


-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight) style:UITableViewStyleGrouped];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        
        self.contentTableView.mj_header = [MHRefreshNomalHeader headerWithRefreshingBlock:^{
            self.index = 1;
            [self getData];
        }];
        
        self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.index ++;
            [self getData];
        }];
        [_contentTableView registerClass:[MHJHCell class] forCellReuseIdentifier:NSStringFromClass([MHJHCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MHJHCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHJHCell class])];
    MHJFModel  *model  =  _taskArr[indexPath.section];
    cell.jfModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(60);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _taskArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}



@end
