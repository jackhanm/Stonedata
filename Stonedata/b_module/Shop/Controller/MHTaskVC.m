//
//  MHTaskVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/1.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHTaskVC.h"
#import "MHTaskCell.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "MHNewbeeVC.h"

@interface MHTaskVC ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSArray       *taskArr;

@end

static NSString * const MHTaskCellIdd = @"MHTaskCellIdd";

@implementation MHTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.title = @"进阶任务";
    [self.view addSubview:self.contentTableView];
    [[MHUserService sharedInstance]initwithShopTaskCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.taskArr =  response[@"data"];
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


- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:_contentTableView.frame];
    return networkErrorPlaceHolder;
}


- (void)emptyOverlayClicked:(id)sender {
    [[MHUserService sharedInstance]initwithShopTaskCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.taskArr =  response[@"data"];
            [self.contentTableView cyl_reloadData];
        }
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [_contentTableView registerClass:[MHTaskCell class] forCellReuseIdentifier:MHTaskCellIdd];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:MHTaskCellIdd];
    cell.titleLabel.text = _taskArr[indexPath.section][@"taskName"];
    
    if ([_taskArr[indexPath.section][@"taskStatus"] integerValue]  == 0) {
        [cell.titleBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"cccccc"]] forState:UIControlStateDisabled];
        [cell.titleBtn setTitle:@"未解锁" forState:UIControlStateDisabled];
        [cell.titleBtn setTitleColor:[UIColor colorWithHexString:@"#6E6E6E"] forState:UIControlStateDisabled];
        cell.titleBtn.enabled = NO;
        cell.titleBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    }else  if ([_taskArr[indexPath.section][@"taskStatus"] integerValue]  == 1){
        [cell.titleBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(60), kRealValue(24))] forState:UIControlStateNormal];
        [cell.titleBtn setTitle:@"去邀请" forState:UIControlStateNormal];
        [cell.titleBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        cell.titleBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        cell.titleBtn.enabled = YES;
    }else  if ([_taskArr[indexPath.section][@"taskStatus"] integerValue]  == 2){
        [cell.titleBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F2F3F5"]] forState:UIControlStateDisabled];
        [cell.titleBtn setTitle:@"已完成" forState:UIControlStateDisabled];
         [cell.titleBtn setTitleColor:[UIColor colorWithHexString:@"#ff5100"] forState:UIControlStateDisabled];
        cell.titleBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        cell.titleBtn.enabled = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(54);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _taskArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ((section +1) %3 == 0) {
        return kRealValue(15);
    }else{
         return 0;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_taskArr[indexPath.section][@"taskStatus"] integerValue]  == 1){
        
        MHNewbeeVC *vc = [[MHNewbeeVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
