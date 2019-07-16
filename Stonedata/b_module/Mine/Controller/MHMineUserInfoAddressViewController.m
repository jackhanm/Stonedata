//
//  MHMineUserInfoAddressViewController.m
//  mohu
//
//  Created by yuhao on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineUserInfoAddressViewController.h"
#import "MHMineUserAddressCell.h"
#import "MHMineUserAddNewAddress.h"
#import "MHMineuserAddress.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "CYLTableViewPlaceHolder.h"
@interface MHMineUserInfoAddressViewController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate,MHNetworkErrorPlaceHolderDelegate>
@property (nonatomic, strong) NSMutableArray *addressListArr;
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIButton *addNewaddress;
@property (nonatomic, strong)  MHMineUserAddressCell *cell;
@end

@implementation MHMineUserInfoAddressViewController

-(instancetype)initWithcomeform:(NSString *)awordprize
{
    self = [super init];
    if (self) {
        self.awordprize = awordprize;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getNetdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xf1f2f5);
    self.title = @"收货地址";
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)createview
{
    [self.view addSubview:self.contentTableView];
    self.addNewaddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addNewaddress setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    self.addNewaddress.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
    [self.addNewaddress setTitle:@" 十 添加新地址" forState:UIControlStateNormal];
    self.addNewaddress.layer.masksToBounds =YES;
    self.addNewaddress.layer.cornerRadius = 5;
    [self.addNewaddress addTarget:self action:@selector(Address) forControlEvents:UIControlEventTouchUpInside];
    self.addNewaddress.frame =CGRectMake(kRealValue(16), kScreenHeight- kBottomHeight-kTopHeight-kRealValue(70), kRealValue(343), kRealValue(44));
    [self.view addSubview:self.addNewaddress];
    
}
-(void)getNetdata
{
    self.addressListArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initWithGetUserAdressInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.addressListArr=[MHMineuserAddress baseModelWithArr:response[@"data"]];
        }
        [self.contentTableView cyl_reloadData];
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
   
    [self getNetdata];
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

-(void)Address
{
    MHMineUserAddNewAddress *vc = [[MHMineUserAddNewAddress alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _contentTableView.backgroundColor = KColorFromRGB(0xF1F3F4);
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHMineUserAddressCell class] forCellReuseIdentifier:NSStringFromClass([MHMineUserAddressCell class])];
       
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return kRealValue(127);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
       self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHMineUserAddressCell class])];
//        cell.backgroundColor = kRandomColor;
        self.cell.selectionStyle= UITableViewCellSelectionStyleNone;
    kWeakSelf(self);
    self.cell.deleteAct = ^(NSInteger index) {
        [[MHBaseClass sharedInstance] presentAlertWithtitle:@"删除地址" message:@"确认删除地址吗" leftbutton:@"取消" rightbutton:@"确定" leftAct:^{
            
        } rightAct:^{
            MHMineuserAddress  *adressModel = [weakself.addressListArr objectAtIndex:indexPath.row];
            [[MHUserService sharedInstance]initWithdeleteAdressInfoWithaddressId:[NSString stringWithFormat:@"%@",adressModel.addressId]  CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    KLToast(@"删除成功");
                    [weakself getNetdata];
                }
            }];
        }];
       
        
    
    };
    self.cell.editAct = ^(NSInteger index) {
       MHMineuserAddress *adressModel =  [weakself.addressListArr objectAtIndex:indexPath.row];
        MHMineUserAddNewAddress *vc = [[MHMineUserAddNewAddress alloc]initWithModel:adressModel];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    self.cell.setdefaultAct = ^(NSInteger index) {
        MHMineuserAddress  *adressModel = [weakself.addressListArr objectAtIndex:indexPath.row];
        if ([[NSString stringWithFormat:@"%@",adressModel.addressState] isEqualToString:@"0"]) {
            [[MHUserService sharedInstance]initWithSetDefaultAdressInfoWithaddressId:[NSString stringWithFormat:@"%@",adressModel.addressId] CompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    KLToast(@"设置成功");
                    [weakself getNetdata];
                }
            }];
        }else{
           
        }
        
       

    };
    if (self.addressListArr.count > 0) {
        self.cell.adressModel = [self.addressListArr objectAtIndex:indexPath.row];
    }
        return self.cell;
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.addressListArr.count>0 ) {
        return self.addressListArr.count;
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!klStringisEmpty(self.awordprize)) {
        MHMineuserAddress *model = [self.addressListArr objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationchangeAdress object:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ([self.type isEqualToString:@"sumbit"]) {
        MHMineuserAddress *model = [self.addressListArr objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationchangeAdress object:model];
        [self.navigationController popViewControllerAnimated:YES];
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
