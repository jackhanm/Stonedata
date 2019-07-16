//
//  MHGuessOrderdetailViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHGuessOrderdetailViewController.h"
#import "MHAddressTableViewCell.h"
#import "MHGuessOrderDetailCell.h"
#import "MHHucaiPersionList.h"
@interface MHGuessOrderdetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property(strong,nonatomic)UIView *headView;

@property (nonatomic,strong) NSMutableArray  *shopArr;
@property (nonatomic, strong) UILabel *EMSnum;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) MHHucaiPersionList *alert;
@property (nonatomic, strong) UILabel *EMSlabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end

static NSString * const MHOrderDetailTableViewCellId = @"MHOrderDetailTableViewCellId";
static NSString * const MHAddressTableViewCellId = @"MHAddressTableViewCellId";
@implementation MHGuessOrderdetailViewController

-(instancetype)initWithwinningId:(NSString *)winningId comefrom:(NSString *)comeform statu:(NSString*)statu
{
    self = [super init];
    if (self) {
        self.winningId = winningId;
        self.comefrom = comeform;
        self.statu = statu ;
    }
    return self;
}
-(void)getdata
{
    self.dic = [NSMutableDictionary dictionary];
    [[MHUserService sharedInstance]initorderCommentAddressListwinningId:self.winningId completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.dic = [response valueForKey:@"data"];
            [self.tableView reloadData];
            NSString *drawnumpersion = [NSString stringWithFormat:@"%@",[self.dic valueForKey:@"drawNumber"]] ;
            NSInteger drawnumpersionnum = [drawnumpersion  integerValue];
            
            NSString *alertitle;
            if ([[self.dic valueForKey:@"userList"] count] == 0 ) {
                alertitle =[NSString stringWithFormat:@"0/%ld",drawnumpersionnum];
            }else
            {
                alertitle =[NSString stringWithFormat:@"%ld/%ld",[[self.dic  valueForKey:@"userList"] count],drawnumpersionnum];
            }
            
            self.alert.title =alertitle;
            self.alert.dic = self.dic;
            self.EMSlabel.text = [self.dic valueForKey:@"expressType"];
            self.EMSnum.text =[self.dic valueForKey:@"expressCode"];
        }
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getdata];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F7F8FA"];
    self.alert = [[MHHucaiPersionList alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) ];
    self.alert.comeform = self.comefrom;
    self.alert.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.alert];
    //方接口中
   [self.view addSubview:self.tableView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确认收货" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getprize) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF7A66"],[UIColor colorWithHexString:@"FF644C"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = kRealValue(22);
    btn.frame = CGRectMake(kRealValue(16), kScreenHeight - kRealValue(55)-kTopHeight,  kScreenWidth-kRealValue(32), kRealValue(40));
    [self.view addSubview:btn];
    
    self.shuline.hidden = NO;
    self.EMSfuzhi.hidden = NO;
    self.EMSimage.hidden = NO;
    if ([self.statu isEqualToString:@"4"]) {
        self.title =@"确认收货";
        self.stateLabel.text = @"确认收货";
        btn.hidden = NO;
        
    }
    if ([self.statu isEqualToString:@"5"]) {
        self.title =@"已完成";
        self.stateLabel.text = @"已完成";
        btn.hidden = YES;
    }
    if ([self.statu isEqualToString:@"6"]) {
        self.title =@"已失效";
        self.stateLabel.text = @"已失效";
        btn.hidden = YES;
    }
    if ([self.statu isEqualToString:@"7"]) {
        self.title =@"已转卖";
        self.stateLabel.text = @"已转卖";
        btn.hidden = YES;
    }
    if ([self.statu isEqualToString:@"10"]) {
        self.title =@"待发货";
        self.stateLabel.text = @"待发货";
        btn.hidden = YES;
        self.shuline.hidden = YES;
        self.EMSfuzhi.hidden = YES;
        self.EMSimage.hidden = YES;
    }
    
}
-(void)getprize
{
    [[MHUserService sharedInstance]initgetorderorderCommentListwinningId:self.winningId completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            KLToast(@"收货成功")
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            KLToast([response valueForKey:@"message"]);
        }
        
    }];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.sectionHeaderHeight= 0;
        _tableView.tableHeaderView = self.headView;
        _tableView.estimatedSectionFooterHeight = 0;
       [_tableView registerClass:[MHGuessOrderDetailCell class] forCellReuseIdentifier:NSStringFromClass([MHGuessOrderDetailCell class])];
        [_tableView registerClass:[MHAddressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MHAddressTableViewCell class])];
     
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

-(UIView *)headView{
    
    if (!_headView) {
        _headView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(79))];
        _headView.userInteractionEnabled = YES;
        _headView.backgroundColor = [UIColor colorWithHexString:@"F7F8FA"];
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(79))];
        contentView.userInteractionEnabled = YES;
        contentView.backgroundColor = [UIColor colorWithHexString:@"F76C6C"];
        [_headView addSubview:contentView];
        
        //订单状态
        self.stateLabel = [[UILabel alloc]init];
        self.stateLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        self.stateLabel.textColor =[UIColor colorWithHexString:@"FFFFFF"];

        self.stateLabel.text = @"确认收货";
        self.title = @"确认收货";
        [contentView addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).with.offset(kRealValue(29));
            make.left.equalTo(contentView.mas_left).with.offset(kRealValue(16));
        }];
        //快递信息
        self.EMSlabel = [[UILabel alloc]init];
        self.EMSlabel.textAlignment = NSTextAlignmentRight;
        self.EMSlabel.text = @"中通快递";
        self.EMSlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.EMSlabel.textColor = KColorFromRGB(0xffffff);
        [contentView addSubview:self.EMSlabel];
        
        [self.EMSlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView.mas_right).offset(-kRealValue(10));
            make.top.equalTo(contentView.mas_top).offset(kRealValue(20));
        }];
        self.EMSimage = [[UIImageView alloc]init];
        self.EMSimage.image = kGetImage(@"ic_add_logistics");
        [contentView addSubview:self.EMSimage];
        [self.EMSimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.EMSlabel.mas_left).offset(-kRealValue(3));
            make.top.equalTo(contentView.mas_top).offset(kRealValue(21));
        }];
        
        self.EMSfuzhi = [[UILabel alloc]init];
        self.EMSfuzhi.textAlignment = NSTextAlignmentRight;
        self.EMSfuzhi.text = @"复制";
        self.EMSfuzhi.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        self.EMSfuzhi.textColor = KColorFromRGB(0xffffff);
        self.EMSfuzhi.userInteractionEnabled = YES;
        [contentView addSubview:self.EMSfuzhi];
        [self.EMSfuzhi mas_makeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(contentView.mas_right).offset(-kRealValue(10));
            make.top.equalTo(contentView.mas_top).offset(kRealValue(40));
        }];
        
        UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(copyTapact)];
        [self.EMSfuzhi addGestureRecognizer:tapAct];
        
        self.shuline = [[UIView alloc]init];
        self.shuline.backgroundColor = KColorFromRGB(0xffffff);
        [contentView addSubview:self.shuline];
        
        [self.shuline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.EMSfuzhi.mas_left).offset(-kRealValue(5));
//            make.top.equalTo(contentView.mas_top).offset(kRealValue(50));
            make.centerY.equalTo(self.EMSfuzhi.mas_centerY).offset(0);
            make.width.mas_offset(1);
            make.height.mas_offset(kRealValue(10));
        }];
        
        
        self.EMSnum = [[UILabel alloc]init];
         self.EMSnum.textAlignment = NSTextAlignmentRight;
         self.EMSnum.text = @"8372 8377 3748";
         self.EMSnum.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
         self.EMSnum.textColor = KColorFromRGB(0xffffff);
        [contentView addSubview: self.EMSnum];
        [ self.EMSnum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shuline.mas_left).offset(-kRealValue(5));
            make.top.equalTo(contentView.mas_top).offset(kRealValue(40));
            make.centerY.equalTo(self.EMSfuzhi.mas_centerY).offset(0);
        }];
        
    }
    return _headView;
}
-(void)copyTapact
{
    UIPasteboard *copy = [UIPasteboard generalPasteboard];
    [copy setString: self.EMSnum.text];
    if (copy == nil || [ self.EMSnum.text isEqualToString:@""]==YES)
    {
        
        KLToast(@"复制失败")
        
        
    }else{
        KLToast(@"复制成功")
        
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return kRealValue(86);
    }
    return kRealValue(433)+ kRealValue(107);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        MHAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHAddressTableViewCell class]) forIndexPath:indexPath];
        if (!klObjectisEmpty(self.dic)) {
            NSMutableDictionary *dic= [self.dic valueForKey:@"userAddress"];
            cell.nameLabel.text = [dic valueForKey:@"userName"];
            cell.phoneLabel.text = [dic valueForKey:@"userPhone"];
            cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",[dic valueForKey:@"province"],[dic valueForKey:@"city"],[dic valueForKey:@"area"],[dic valueForKey:@"details"]];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    MHGuessOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHGuessOrderDetailCell class]) forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellEditingStyleNone;
    cell.seeAll = ^{
        MHLog(@"展示参团好友");
        self.alert.hidden = NO;
    };
    if (!klObjectisEmpty(self.dic)) {
        cell.dic = self.dic;
    }
    if ([self.comefrom isEqualToString:@"prizemore"]) {
        cell.prizePersonPricelabel.hidden = YES;
    }
    return cell;
}





@end
