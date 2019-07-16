//
//  MHHucaiPersionList.m
//  mohu
//
//  Created by yuhao on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHucaiPersionList.h"
#import "MHhucaiListCell.h"
@interface MHHucaiPersionList()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIView *smallbgview;
@property (nonatomic, strong)UITableView *contentTableView;
@property (nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic, strong)UILabel  *titilelable;
@end

@implementation MHHucaiPersionList


-(void)setArray:(NSMutableArray *)array
{
    _array = array;
    self.listArr = array;
//     self.titilelable.text = [NSString stringWithFormat:@"已参团好友%@",self.title];
    
    NSString *Str = [NSString stringWithFormat:@"已参团好友%@",self.title];
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
    [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xFA3837) range:NSMakeRange(5, Str.length -5)];

    self.titilelable.attributedText = attstring;
    

    if (self.listArr.count > 0) {
        [self.contentTableView reloadData];
       
    }
}
-(void)setDic:(NSMutableDictionary *)dic
{
    _dic = dic;
    self.listArr = [dic valueForKey:@"participateUser"];
    NSString *Str = [NSString stringWithFormat:@"已参团好友%@",self.title];
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
    [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xFA3837) range:NSMakeRange(5, Str.length -5)];
    
    self.titilelable.attributedText = attstring;
    if (self.listArr.count > 0) {
        [self.contentTableView reloadData];
    }
   
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createviewWithFrame:frame];
    }
    return self;
}
-(void)createviewWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    //半透明的背景
    self.bgView = [[UIView alloc]initWithFrame:frame];
    self.bgView.backgroundColor = KColorFromRGBA(0x00000, 0.5);
    self.bgView.userInteractionEnabled = YES;
    [self addSubview:self.bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
    [self.bgView addGestureRecognizer:tap];
  
    self.smallbgview = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(28), kRealValue(92), kScreenWidth - kRealValue(28) *2, kScreenHeight-kRealValue(92)*2)];
    self.smallbgview.backgroundColor = [UIColor whiteColor];
    self.smallbgview.layer.cornerRadius = kRealValue(10);
    self.smallbgview.centerX = self.centerX;
    [self.bgView addSubview:self.smallbgview];
    
    
    self.titilelable = [[UILabel alloc]init];
    self.titilelable.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(12)];
    self.titilelable.textColor = KColorFromRGB(0x000000);
    self.titilelable.textAlignment = NSTextAlignmentCenter;
    self.titilelable.userInteractionEnabled = YES;
    self.titilelable.text =@"已参团好友";
    self.titilelable.frame = CGRectMake(0, 0,self.smallbgview.frame.size.width , kRealValue(40));
    [self.smallbgview addSubview:self.titilelable];
    
    
    
    
    [self.smallbgview addSubview:self.contentTableView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.smallbgview addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.smallbgview.mas_bottom).with.offset(kRealValue(40));
        make.centerX.mas_equalTo(self.smallbgview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(30)));
    }];
    
    
//    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [closeBtn setBackgroundImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
//    [closeBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:closeBtn];
//    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.smallbgview.mas_bottom).with.offset(kRealValue(40));
//        make.centerX.mas_equalTo(self.smallbgview.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(30)));
//    }];

    
}
-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(kRealValue(3), kRealValue(40),self.smallbgview.frame.size.width - kRealValue(6), self.smallbgview.frame.size.height-kRealValue(40)-5);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHhucaiListCell class] forCellReuseIdentifier:NSStringFromClass([MHhucaiListCell class])];
        
        
    }
    return _contentTableView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kRealValue(58);
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHhucaiListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHhucaiListCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.listArr.count > 0) {
        
        [cell.headimage sd_setImageWithURL:[NSURL URLWithString:[self.listArr[indexPath.row] valueForKey:@"userImage"]] placeholderImage:kGetImage(kfailImage)];
        cell.username.text = [self.listArr[indexPath.row] valueForKey:@"userNickName"];
        cell.acttime.text = [self.listArr[indexPath.row] valueForKey:@"winningTime"];
        if ([[NSString stringWithFormat:@"%@",[self.listArr[indexPath.row] valueForKey:@"winningState"]] isEqualToString:@"3"]) {
            cell.actprice.text=[NSString stringWithFormat:@"已中奖 ¥%@",[self.listArr[indexPath.row] valueForKey:@"winnerNumber"]];
        }else{
            cell.actprice.text=[NSString stringWithFormat:@"¥%@",[self.listArr[indexPath.row] valueForKey:@"winnerNumber"]];
        }
        if ([self.comeform isEqualToString:@"prizemore"]) {
            if ([[NSString stringWithFormat:@"%@",[self.listArr[indexPath.row] valueForKey:@"winningState"]] isEqualToString:@"3"]) {
                cell.actprice.text=@"已中奖";
            }else{
                cell.actprice.text=@"";
            }
        }
        
        
    }
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.listArr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)showView{
    
    [UIView animateWithDuration:0.2 animations:^{
        
         self.hidden = NO;
        
    } completion:^(BOOL fin){
        //         [self removeFromSuperview];
        
//        self.bgView.hidden =NO;
        
        
    }];
}
-(void)hideView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = YES;
        
    } completion:^(BOOL fin){
        //         [self removeFromSuperview];
        
//        self.bgView.hidden =YES;
        
        
    }];
    
}
@end
