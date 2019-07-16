//
//  MHProductDetailViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProductDetailViewController.h"
#import "MHProductDetailHeadCell.h"
#import "MHCommentDetailCell.h"
#import "MHCommentDetailCellHeadCell.h"
#import "MHCommentDetailCellBottomCell.h"
#import "MHProductHucaidetailHeadCell.h"
#import "MHProductDetailDesCell.h"
#import "MHProductDetailPicView.h"
#import "MHShopCarSizeAlert.h"
#import "MHProductPicModel.h"
#import "MHProductCommentModel.h"
#import "MHProductCommentListModel.h"
#import "MHSumbitOrderVC.h"
#import "MHLoginViewController.h"
#import "MHHucaiPersionList.h"
#import "MHProductDetailModel.h"
#import "MHProductDescbottomView.h"
@interface MHProductDetailViewController ()<UITableViewDelegate,UITableViewDataSource,MHProductDetailPicViewDelegate>
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)MHProductDetailPicView *detailView;

@property (nonatomic, strong)MHProductDetailHeadCell *cell;
@property (nonatomic, strong)MHProductHucaidetailHeadCell *hucaiCell;
@property (nonatomic, strong) NSMutableArray *Lunboarr;
@property (nonatomic, strong) NSMutableArray *CommentArr;
@property (nonatomic, strong) NSMutableDictionary *CommentDic;
@property (nonatomic, strong) NSMutableArray *PicArr;
@property (nonatomic, strong) NSMutableDictionary *explandDic;
@property (nonatomic, strong) NSString *codeStr;
@property (nonatomic, assign) NSInteger productdetailTYpe;
@property (nonatomic, strong) MHHucaiPersionList *alert;
@property (nonatomic, strong) NSTimer *timer ;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic,strong)MHProductDetailDesCell *DesCellcell;
@end

@implementation MHProductDetailViewController

-(void)setComeform:(NSString *)comeform
{
    _comeform = comeform;
    
}
-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

- (instancetype)initWithNsmudic:(NSMutableDictionary *)dic  explandDic:(NSMutableDictionary *)explandDic productDetailtype:(NSInteger)productDetailtype
{
    self = [super init];
    if (self) {
        
        self.dic = dic;
        self.productdetailTYpe = productDetailtype;
        self.Lunboarr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productImages"]];
        self.CommentArr = [MHProductCommentModel baseModelWithArr:[[self.dic valueForKey:@"evaluate"] valueForKey:@"list"]] ;
         self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productBigImage"]];
        self.explandDic = explandDic;
        self.resttimer =[[NSString stringWithFormat:@"%@",[dic valueForKey:@"restTime"]] integerValue];
        if (self.resttimer > 0) {
            self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer: self.timer forMode: NSRunLoopCommonModes];
        }else{
            
        }
        
    }
    return self;
}
-(void)timerAction
{
   
    if (self.resttimer == 0) {
        [self.timer invalidate];
        self.timer = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshDetailview object:nil];
        return;
    }
     --self.resttimer ;
    NSString *str = [NSString stringWithFormat:@"%ld",self.resttimer];
    NSInteger seconds = [str integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    self.cell.secondelabel.text =str_second;
     self.cell.minutelabel.text =str_minute;
     self.cell.hourlabel.text =str_hour;
   
}
-(void)getdata
{
     [MBProgressHUD showActivityMessageInWindow:@"正在加载"];
    [[MHUserService sharedInstance] initwithProductId:[self.dic valueForKey:@"productId"] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.dic = (NSMutableDictionary *) [MHProductDetailModel baseModelWithDic:[response valueForKey:@"data"]];
            self.Lunboarr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productImages"]];
            self.CommentArr = [MHProductCommentModel baseModelWithArr:[[self.dic valueForKey:@"evaluate"] valueForKey:@"list"]] ;
            self.PicArr = [MHProductPicModel baseModelWithArr:[self.dic valueForKey:@"productBigImage"]];
            self.explandDic = [response valueForKey:@"expand"];
            self.resttimer =[[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"restTime"]] integerValue];
            if (self.resttimer > 0) {
                self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSRunLoopCommonModes];
            }
            
        }
        [MBProgressHUD hideHUD];
    }];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.fd_prefersNavigationBarHidden =YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createview];
    if (!klStringisEmpty(self.comeform)) {
        if ([self.comeform isEqualToString:@"vip"]) {
            self.btn.hidden= YES;
           
        }
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"infoNotification" object:nil];

    
}
-(void)receiveNotification:(NSNotification *)infoNotification {
    
    NSDictionary *dic = [infoNotification userInfo];
    NSString *str =[NSString stringWithFormat:@"已选%@",[dic objectForKey:@"info"]] ;
    self.cell.choseePropertyView.RightitleLabel.text = str;

}

-(void)createview
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.detailView];
    self.alert = [[MHHucaiPersionList alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.alert.hidden = YES;
     [[UIApplication sharedApplication].keyWindow addSubview:self.alert];
    
    self.btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setImage:kGetImage(@"xiajia") forState:UIControlStateNormal];
    [self.btn setImage:kGetImage(@"shangjia") forState:UIControlStateSelected];
//    btn.backgroundColor = KColorFromRGB(0xFF8819);
    
    
    self.btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    self.btn.frame =CGRectMake(kScreenWidth-kRealValue(55),kScreenHeight - kRealValue(120)-kBottomHeight, kRealValue(39), kRealValue(39));
    [self.btn addTarget:self action:@selector(productUpAct:) forControlEvents:UIControlEventTouchUpInside];
    self.btn.layer.cornerRadius = kRealValue(39/2);
    [self.view addSubview:self.btn];
    
    if ([[NSString stringWithFormat:@"%@",[self.dic valueForKey:@"updown"]] isEqualToString:@"0"]) {
        self.btn.selected = NO;
    }else{
        self.btn.selected = YES;
    }
    
    if ([[GVUserDefaults standardUserDefaults].userRole integerValue] < 2) {
        self.btn.hidden= YES;
    }
    
    
   
}

-(void)productUpAct:(UIButton *)sender
{
    if ([GVUserDefaults standardUserDefaults].accessToken) {
        [[MHUserService sharedInstance]initwithCommentProductId:[self.dic valueForKey:@"productId"] updown:[NSString stringWithFormat:@"%d",!sender.selected] completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                if (sender.selected == 0) {
                    KLToast(@"上架成功");
                   
                }else{
                    KLToast(@"下架成功");
                }
                 sender.selected =!sender.selected;
            }else{
                KLToast([response valueForKey:@"message"]);
            }
            
            
        }];
        
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
    
    
}

#pragma mark lazy

-(MHProductDetailPicView *)detailView
{
    if (!_detailView) {
        _detailView = [[MHProductDetailPicView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kTopHeight)];
        _detailView.PicViewDelegate = self;
        _detailView.des =[self.dic valueForKey:@"productSubtitle"];
        
        _detailView.PictureArr = self.PicArr;
    }
    return _detailView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
       [_tableView registerClass:[MHProductDetailHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHProductDetailHeadCell class])];
        [_tableView registerClass:[MHCommentDetailCell class] forCellReuseIdentifier:NSStringFromClass([MHCommentDetailCell class])];
         [_tableView registerClass:[MHCommentDetailCellBottomCell class] forCellReuseIdentifier:NSStringFromClass([MHCommentDetailCellBottomCell class])];
        [_tableView registerClass:[MHProductDetailDesCell class] forCellReuseIdentifier:NSStringFromClass([MHProductDetailDesCell class])];
         [_tableView registerClass:[MHCommentDetailCellHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHCommentDetailCellHeadCell class])];
         [_tableView registerClass:[MHProductHucaidetailHeadCell class] forCellReuseIdentifier:NSStringFromClass([MHProductHucaidetailHeadCell class])];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        if (self.CommentArr.count > 0) {
            return self.CommentArr.count +2;
        }
        return 0;
    }
    if (section ==2) {
        return 1;
    }
    return 1 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (self.productdetailTYpe == 0 ||self.productdetailTYpe == 1) {
           
                return kScreenWidth + kRealValue(60)+kRealValue(76)+kRealValue(98) + kRealValue(69)+kRealValue(20);
            
            
        }
        
        if (self.productdetailTYpe == 2) {
            return kScreenWidth + kRealValue(54)+kRealValue(83)+kRealValue(98) + kRealValue(69)+kRealValue(30)+kRealValue(34)+kRealValue(127) +kRealValue(103)+ kRealValue(103);
        }
       
    }
    if (indexPath.section == 1) {
        if (self.CommentArr.count > 0) {
            if (indexPath.row == 0) {
                return kRealValue(50);
            }
            if (indexPath.row == self.CommentArr.count+1) {
                return kRealValue(60);
            }
            MHProductCommentModel *model = [self.CommentArr objectAtIndex:indexPath.row-1];
            CGRect rect = [model.evaluateContent boundingRectWithSize:CGSizeMake(309, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)]} context:nil];
            if (klStringisEmpty(model.evaluateImages)) {
                return rect.size.height+kRealValue(44) +kRealValue(10)+ kRealValue(25)+kRealValue(40);
            }else{
                return rect.size.height+kRealValue(44) + kRealValue(57)+kRealValue(10)+kRealValue(25)+kRealValue(40);
            }
            
        }else{
            return 0;
        }
        
    }
    if (indexPath.section == 2) {
        return kRealValue(50);
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.productdetailTYpe == 0 || self.productdetailTYpe == 1) {
            self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductDetailHeadCell class])];
            kWeakSelf(self);
            self.cell.chooseSizeAct = ^(NSString *productID, NSString *brandID) {
                [weakself.ProDetailViewDelegate ShowAlert];
            };
            self.cell.ShowshareAlert = ^{
                [weakself.ProDetailViewDelegate showShareAlert];
            };
            self.cell.selectionStyle= UITableViewCellSelectionStyleNone;
            self.cell.CellrestTimer = self.resttimer;
            self.cell.dic  = self.dic;
             self.cell.bannerArr =self.Lunboarr;
            self.cell.expandDic  = self.explandDic;
            if ([self.comeform isEqualToString:@"vip"]) {
                self.cell.originalPrice.hidden = YES;
            }
            if ([self.comeform isEqualToString:@"hasclose"]) {
                self.cell.labeltitle.text = @"距离活动结束还剩";
            }
            if ([self.comeform isEqualToString:@"willopen"]) {
                self.cell.labeltitle.text = @"距离活动开始还剩";
            }
            if ([self.comeform isEqualToString:@"limettime"]) {
                self.cell.labeltitle.text = @"距离活动结束还剩";
            }
           
             return self.cell;
            
        }
        if (self.productdetailTYpe == 2) {
            self.hucaiCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductHucaidetailHeadCell class])];
            kWeakSelf(self);
            self.hucaiCell.selectionStyle= UITableViewCellSelectionStyleNone;
            self.hucaiCell.bannerArr =self.Lunboarr;
            self.hucaiCell.dic  = self.dic;
            self.hucaiCell.expandDic  = self.explandDic;
            self.hucaiCell.hucaiSeeAll = ^{
               self.alert.hidden = NO;
            };
            return self.hucaiCell;
            
        }
        
        
        
       
    }
    if (indexPath.section == 1) {
        if (self.CommentArr.count > 0) {
            if (indexPath.row == 0) {
                MHCommentDetailCellHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHCommentDetailCellHeadCell class])];
                
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                NSString *Str = [NSString stringWithFormat:@"好评度:%@",[[self.dic valueForKey:@"evaluate"] valueForKey:@"rate"]];
                NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
                [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xff891b) range:NSMakeRange(4, Str.length -4)];
                [attstring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontValue(14)] range:NSMakeRange(4, Str.length -4)];
                cell.CellHead.RightitleLabel.attributedText = attstring;
                
                cell.CellHead.RightitleLabel.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAct)];
                [cell.CellHead.RightitleLabel addGestureRecognizer:tap];
                
                
                return cell;
            }
            if (indexPath.row == self.CommentArr.count +1) {
                MHCommentDetailCellBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHCommentDetailCellBottomCell class])];
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                return cell;
            }
            MHCommentDetailCell *cell = [[MHCommentDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
            cell.selectionStyle= UITableViewCellSelectionStyleNone;
            MHProductCommentModel *model = [self.CommentArr objectAtIndex:indexPath.row-1];
            cell.model = model;
            return cell;
        }
        
        MHCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHCommentDetailCell class])];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    if (indexPath.section == 2) {
        self.DesCellcell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHProductDetailDesCell class])];
        self.DesCellcell .selectionStyle= UITableViewCellSelectionStyleNone;
        self.DesCellcell .labeldetail1.text = [self.dic valueForKey:@"productSubtitle"];
        return self.DesCellcell ;
    }
    return nil;
    
    
}
-(void)TapAct
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationSeeAllComment object:nil];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
     CGFloat yOffset  = scrollView.contentOffset.y;
    if ( [self.ProDetailViewDelegate respondsToSelector:@selector(showNavAddtitle:)]) {
        [self.ProDetailViewDelegate showNavAddtitle:yOffset];
    }
    
      MHLog(@"%f",yOffset);
    if (scrollView == self.tableView) {
        //当前偏移量
        CGFloat yOffset  = scrollView.contentOffset.y;
        NSLog(@"%f",yOffset);
        
        //更改导航栏的背景图的透明度
        CGFloat alpha = 0;
        if (yOffset<=0) {
            alpha = 0;
        } else if(yOffset < (kTopHeight+50)){
            alpha = yOffset/(kTopHeight+50);
        }else if(yOffset >= (kTopHeight+50)){
            alpha = 1;
        }else{
            alpha = 0;
        }
        
       
     
    }
}

#pragma mark ---- scrollView delegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if([scrollView isKindOfClass:[UITableView class]]) // tableView界面上的滚动
    {
        // 能触发翻页的理想值:tableView整体的高度减去屏幕本省的高度
        CGFloat valueNum = self.tableView.contentSize.height - kScreenHeight + kTopHeight ;
        if ((offsetY - valueNum) > 20)
        {
            [self.ProDetailViewDelegate changeNavTitle:NO];
            [self.ProDetailViewDelegate changeskipable:NO];
            [self goToDetailAnimation]; // 进入图文详情的动画
        }
    }
}
// 进入详情的动画
- (void)goToDetailAnimation
{
    
    self.navigationItem.title = @"图文详情";
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.detailView.frame = CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight-kTopHeight);
        self.tableView.frame = CGRectMake(0, -self.view.bounds.size.height, kScreenWidth, kScreenHeight);
        self.DesCellcell.bottomView.hidden = YES;
    } completion:^(BOOL finished) {
        
    }];
}
// 返回第一个界面的动画
- (void)backToFirstPageAnimation
{
    self.navigationItem.title = @"商品详情";
     [self.ProDetailViewDelegate changeskipable:YES];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
         [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        self.detailView.frame = CGRectMake(0,kScreenHeight, kScreenWidth, kScreenHeight);
         self.DesCellcell.bottomView.hidden = NO;
    } completion:^(BOOL finished) {
          [self.ProDetailViewDelegate changeNavTitle:YES];
    }];
}

#pragma mark --- ProductDetailViewDelegate ---
- (void)pullDragAndShowProduct
{
    
    [self backToFirstPageAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
